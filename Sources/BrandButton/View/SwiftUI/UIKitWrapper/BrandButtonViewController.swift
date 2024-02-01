//
//  BrandButtonViewController.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//


import UIKit
import SwiftUI

// MARK: - UIKit wrapper for swfitUI button BrandButton
//  class to act as a wrapper around the swiftui button
public final class BrandButtonViewController: UIViewController {
    private var hostingController: UIHostingController<BrandButton>?

    init(action: @escaping () -> Void,
         isDisabled: Binding<Bool>,
         color: Color,
         font: Font? = nil,
         image: Image? = nil,
         style: ButtonStyles? = .leading,
         mode: ButtonModes) {
        
        super.init(nibName: nil, bundle: nil)

        let brandButtonView = BrandButton(action: action,
                                          isDisabled: isDisabled,
                                          color: color,
                                          font: font,
                                          image: image,
                                          style: style,
                                          mode: mode)

        // Create a UIHostingController with the BrandButton view
        let hostingController = UIHostingController(rootView: brandButtonView)
        self.hostingController = hostingController

        // Add the hosting controller as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        // Set constraints for the hosting controller's view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Use case example in UIKit

//func presentBrandButton() {
//    let brandButtonVC = BrandButtonViewController(action: {
//        print("Button tapped")
//    }, isDisabled: .constant(false), // Example binding
//       color: Color.blue, // Replace with your desired color
//       image: Image(systemName: "star.fill"), // Example image
//       style: .leading,
//       mode: .primary)
//
//    present(brandButtonVC, animated: true)
//}
