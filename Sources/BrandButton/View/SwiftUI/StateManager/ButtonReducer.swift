//
//  ButtonReducer.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation

// Reducer to combine actions on Button states
func buttonReducer(state: inout ButtonState,
                   action: ButtonAction) {
    switch action {
    case .press:
        state.isPressed = true
    case .release:
        state.isPressed = false
    case .enable:
        state.isEnabled = true
    case .disable:
        state.isEnabled = false
    }
}
