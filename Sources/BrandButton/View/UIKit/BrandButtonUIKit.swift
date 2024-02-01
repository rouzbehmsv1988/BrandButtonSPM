//
//  BrandButtonUIKit.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation
import SwiftUI
import UIKit

import Foundation
import SwiftUI
import UIKit

// Custom UIButton class for a brand button in UIKit.
public class BrandUIKitButton: UIButton {
    
    // Closure to be executed when the button is tapped.
    private var action: (() -> Void)?
    
    // Base color for the button, which may change based on the mode.
    private var baseColor: UIColor
    
    // Optional leading and trailing icons for the button.
    private var iconLeading: UIImage?
    private var iconTrailing: UIImage?
    
    // Enum to represent button style modes.
    public enum ButtonMode {
        case primary
        case secondary
    }
    
    // Current mode of the button, changing this updates the button's appearance.
    var mode: ButtonMode = .primary {
        didSet {
            updateConfiguration()
        }
    }
    
    // Custom initializer for the button.
    init(mode: ButtonMode,
         baseColor: UIColor,
         iconLeading: UIImage? = nil,
         iconTrailing: UIImage? = nil,
         action: @escaping () -> Void) {
        self.baseColor = baseColor
        self.iconLeading = iconLeading
        self.iconTrailing = iconTrailing
        super.init(frame: .zero)
        self.mode = mode
        self.action = action
        commonInit()
    }
    
    // Required initializer for decoding, not implemented for this custom button.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Common initialization code for setting up the button.
    private func commonInit() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        updateConfiguration()
    }
    
    // Action handler for the button tap.
    @objc private func buttonTapped() {
        action?()
    }
    
    // Configures the button's color based on its mode.
    private func configColors(_ config: inout UIButton.Configuration) {
        switch mode {
        case .primary:
            config.baseBackgroundColor = baseColor
            config.baseForegroundColor = UIColor.white
        case .secondary:
            config.baseBackgroundColor = .clear
            config.baseForegroundColor = baseColor
            config.buttonSize = .large
        }
    }
    
    // Sets up a leading icon if one is provided.
    private func leadingIcon(_ config: inout UIButton.Configuration) {
        if let leadingIcon = iconLeading {
            config.image = leadingIcon.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 10
        }
    }
    
    // Sets up a trailing icon if one is provided.
    private func trailing(_ config: inout UIButton.Configuration) {
        if let trailingIcon = iconTrailing {
            config.image = trailingIcon.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .trailing
            config.imagePadding = 10
        }
    }
    
    // Updates the button configuration when its properties change.
    public override func updateConfiguration() {
        var config = UIButton.Configuration.plain()

        configColors(&config)
        leadingIcon(&config)
        trailing(&config)
        
        config.cornerStyle = .medium
        self.configuration = config
        
        // Update the button's configuration based on its highlighted state.
        self.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            updatedConfig?.showsActivityIndicator = button.isHighlighted
            button.configuration = updatedConfig
        }
    }
    
    // Adjusts the button's background color when highlighted.
    public override var isHighlighted: Bool {
        didSet {
            configuration?.baseBackgroundColor = isHighlighted ? baseColor.withAlphaComponent(0.7) : baseColor
        }
    }
    
    // Adjusts the button's opacity based on its enabled state.
    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}


