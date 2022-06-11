//
//  RefundTransactionsView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.06.2022.
//

import SwiftUI
import StoreKit
import SwiftDate

@available(iOS 15.0, *)
struct RefundTransactionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var transactions = [StoreKit.Transaction]()
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(uiImage: UIImage.init(named: "iconClose")!)
                        
                    }
                    .padding(.top, 16)
                    .padding(.trailing, 16)
                    Spacer()
                }
                Text("Available transactions".uppercased())
                    .kerning(1.25)
                .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                .font(UIFont.compactRoundedSemibold(14).uiFont)
                .padding(.top, 24)
            }
            Spacer()
            Group {
                if transactions.isEmpty {
                    Text("You have no transactions")
                        .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                } else {
                    List(transactions) { tr in
                        VStack {
                            Text(tr.productID)
                                .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                            Text("\(tr.purchaseDate)")
                                .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                        }
                    }
                    .background(Color.clear)
                }
            }
            .task {
                await fetchTransactions()
            }
            Spacer()
            RefundView()
                .padding(.top, 24)
                .frame(height: 40)
        }
    }
    
    func fetchTransactions() async {
        for try await result in StoreKit.Transaction.all {
            guard case .verified(let transaction) = result else { continue }
            transactions.append(transaction)
        }
    }
    
    struct RefundView: View {
        @State private var selectedTransactionID: UInt64?
        @State private var refundSheetIsPresented = false
        @Environment(\.dismiss) private var dismiss
        var body: some View {
            Button {
                refundSheetIsPresented = true
            } label: {
                
                Text("Request Refund")
                    .foregroundColor(activeColor)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(activeColor, lineWidth: 1)
                            .frame(height: 40)
                    )
                    .frame(height: 40)
                
            }
            .padding([.horizontal, .bottom])
            .disabled(selectedTransactionID == nil)
            .refundRequestSheet(
                for: selectedTransactionID ?? 0,
                isPresented: $refundSheetIsPresented
            ) { result in
                if case .success(.success) = result {
                    dismiss()
                }
            }
        }
        var activeColor: Color {
            selectedTransactionID == nil ? Color.gray : UIColor.Gainy.mainText!.uiColor
        }
    }
}

@available(iOS 15.0, *)
struct RefundTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        RefundTransactionsView()
    }
}
