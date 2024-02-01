//
//  BrandUIKitButtonPresentable.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation
import SwiftUI

// MARK: - UIKit wrapper for swfitUI button BrandButton
// SwiftUI wrapper for BrandUIKitButton to use in SwiftUI views.
public struct BrandUIKitButtonRepresentable: UIViewRepresentable {
    var title: String
    var mode: BrandUIKitButton.ButtonMode
    var color: Color
    var leadingImage: String? = nil
    var trailingImage: String? = nil
    var action: () -> Void

    // Creates the UIKit button and configures it for use in SwiftUI.
    public func makeUIView(context: Context) -> BrandUIKitButton {
        let button = BrandUIKitButton(mode: mode,
                                      baseColor: UIColor(color),
                                      iconLeading: leadingImage != nil ? UIImage(named: leadingImage!) : nil,
                                      iconTrailing: trailingImage != nil ? UIImage(named: trailingImage!) : nil,
                                      action: action)
        button.setTitle(title, for: .normal)
        return button
    }

    // Updates the button view when SwiftUI state changes.
    public func updateUIView(_ uiView: BrandUIKitButton, context: Context) {
        uiView.setTitle(title, for: .normal)
    }
}
