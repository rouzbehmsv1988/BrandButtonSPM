//
//  ButtonState.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation
import SwiftUI

// MARK: - Enums

// Enum defining possible button styles.
public enum ButtonStyles: CaseIterable, Identifiable {
    case leading
    case trailing
    
    // Conformance to Identifiable for use in SwiftUI views.
    public var id: Self { self }
}

// Enum defining possible modes a button can be in.
public enum ButtonModes: CaseIterable, Identifiable {
    case primary
    case secondary
    
    public var id: Self { self }
}

// Enum defining actions that can be performed on a button.
enum ButtonAction {
    case press
    case release
    case enable
    case disable
}

// MARK: - Supporting Structures

// Struct to encapsulate color properties for the button.
struct ColorSet {
    var backgroundColor: Color
    var titleColor: Color
    var bordercolor: Color
    var imageBackgroundColor: Color
}

// Struct holding data for primary and secondary button states.
struct PrimarySecondaryData {
    var colorSet: ColorSet
    var title: String
}

// MARK: - ButtonState

// Class to manage and observe the state of a button.
final class ButtonState: ObservableObject {
    // Properties defining the button's appearance and behavior.
    var color: Color
    @Published var isPressed: Bool
    var font: Font?
    var image: Image?
    
    // Computed property returning the button's title based on its mode.
    var title: String {
        switch mode {
        case .primary:
            return getPrimaryData(color: color).title
        case .secondary:
            return getSecondaryData(color: color).title
        }
    }
    
    var style: ButtonStyles?
    var mode: ButtonModes
    @Published var isEnabled: Bool = false
    
    // Computed property returning the color set based on the button's mode.
    var colorSet: ColorSet {
        switch mode {
        case .primary:
            return getPrimaryData(color: color).colorSet
        case .secondary:
            return getSecondaryData(color: color).colorSet
        }
    }
    
    // Initializer to set up the initial state of the button.
    init(color: Color,
         isPressed: Bool,
         isEnabled: Bool,
         font: Font?,
         image: Image?,
         style: ButtonStyles?,
         mode: ButtonModes) {
        
        self.color = color
        self.isPressed = isPressed
        self.isEnabled = isEnabled
        self.font = font
        self.image = image
        self.style = style
        self.mode = mode
    }
    
    // MARK: - Private Helper Methods
    
    // Helper method to get data for the primary button style.
    private func getPrimaryData(color: Color) -> PrimarySecondaryData {
        guard isEnabled else {
            return PrimarySecondaryData(colorSet: ColorSet(backgroundColor: Color.gray,
                                                           titleColor: .white,
                                                           bordercolor: .white,
                                                           imageBackgroundColor: .white),
                                        title: AppConfig.PrimaryDisabled)
        }
        
        let alpha = isPressed ? 1.0 : 0.75
        let colorset = ColorSet(backgroundColor: color.opacity(alpha),
                                titleColor: .white,
                                bordercolor: .white,
                                imageBackgroundColor: .white)
        let title = isPressed ? AppConfig.primaryPressed : AppConfig.primaryDefault
        return PrimarySecondaryData(colorSet: colorset, title: title)
    }
    
    // Helper method to get data for the secondary button style.
    private func getSecondaryData(color: Color) -> PrimarySecondaryData {
        guard isEnabled else {
            return PrimarySecondaryData(colorSet: ColorSet(backgroundColor: .white,
                                                           titleColor: Color.gray,
                                                           bordercolor: Color.gray,
                                                           imageBackgroundColor: .black),
                                        title: AppConfig.secondaryDisabled)
        }
        
        let alpha = isPressed ? 0.3 : 0.0
        let colorset = ColorSet(backgroundColor: color.opacity(alpha),
                                titleColor: color,
                                bordercolor: color,
                                imageBackgroundColor: .black)
        let title = isPressed ? AppConfig.secondaryPressed : AppConfig.secondaryDefault
        return PrimarySecondaryData(colorSet: colorset, title: title)
    }
}
