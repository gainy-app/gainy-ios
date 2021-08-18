//
//  CustomHostingController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import SwiftUI
import UIKit

class CustomHostingController <Content>: UIHostingController<AnyView> where Content : View {

  public init(shouldShowNavigationBar: Bool, rootView: Content) {
      super.init(rootView: AnyView(rootView.navigationBarHidden(!shouldShowNavigationBar)))
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
