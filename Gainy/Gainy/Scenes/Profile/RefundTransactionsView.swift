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
struct RefundGradientBackgroundView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> GradientBackgroundView {
        let view = GradientBackgroundView()
        view.startColor = UIColor.init(hexString: "#FFA29B")?.withAlphaComponent(0.2)
        view.middleColor = UIColor.init(hexString: "#EEBFFF")?.withAlphaComponent(0.2)
        view.endColor = UIColor.init(hexString: "#EFECFA")?.withAlphaComponent(0.2)
        view.middleLocation = 0.346
        return view
    }

    func updateUIView(_ uiView: GradientBackgroundView, context: Context) {
        uiView.startColor = UIColor.init(hexString: "#FFA29B")?.withAlphaComponent(0.2)
        uiView.middleColor = UIColor.init(hexString: "#EEBFFF")?.withAlphaComponent(0.2)
        uiView.endColor = UIColor.init(hexString: "#EFECFA")?.withAlphaComponent(0.2)
        uiView.middleLocation = 0.346
    }
}

@available(iOS 15.0, *)
struct RefundTransactionsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var transactions = [StoreKit.Transaction]()
    @State var selectedTransactionID: UInt64?
    
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
                    .padding(.leading, 16)
                    Spacer()
                }
                .background(Color.clear)
                
                Text("Available transactions".uppercased())
                    .kerning(1.25)
                .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                .font(UIFont.compactRoundedSemibold(14).uiFont)
                .padding(.top, 24)
                .background(Color.clear)
            }
            .background(Color.clear)
            Spacer()
            Group {
                if transactions.isEmpty {
                    Text("You have no transactions")
                        .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                } else {
                    
                    ScrollView {
                        VStack {
                            ForEach(transactions, id: \.self) { tr in
                                HStack {
                                    HStack {
                                        Button(action: {
                                            self.selectedTransactionID = tr.id
                                        }, label: {
                                            VStack(alignment: .leading, spacing: 8.0, content: {
                                                Text( Product.getProductByID(tr.productID)?.name ?? "Transaction from" )
                                                    .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                                                    .font(UIFont.proDisplayMedium(16).uiFont)
                                                    .multilineTextAlignment(.leading)
                                                Text("\(tr.purchaseDate)")
                                                    .foregroundColor(UIColor.Gainy.mainText?.uiColor)
                                                    .font(UIFont.proDisplayMedium(16).uiFont)
                                                    .multilineTextAlignment(.leading)
                                            })
                                            .background(Color.clear)
                                            .lineSpacing(8.0)
                                        })
                                    }
                                    .padding()
                                    .background(tr.id == self.selectedTransactionID ? UIColor.init(hexString: "#F0F0F0")!.uiColor : UIColor.white.uiColor)
                                    .contentShape(Rectangle())
                                    .cornerRadius(8.0)
                                }
                                .padding([.top, .bottom], 0)
                            }
                        }
                    }.padding([.top], 32.0)
                }
            }
            .background(Color.clear)
            .task {
                await fetchTransactions()
            }
            Spacer()
            RefundView(selectedTransactionID: self.$selectedTransactionID)
                .padding(.top, 24)
                .padding([.leading, .trailing], 32.0)
                .padding([.bottom], 43.0)
                .frame(height: 64)
        }
        .background(
            RefundGradientBackgroundView.init()
        )
    }
    
    func fetchTransactions() async {
        for try await result in StoreKit.Transaction.all {
            guard case .verified(let transaction) = result else { continue }
            transactions.append(transaction)
        }
    }
    
    struct RefundView: View {
        @Binding var selectedTransactionID: UInt64?
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
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(activeColor, lineWidth: 2)
                            .frame(height: 64)
                    )
                    .frame(height: 64)
                
            }
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
