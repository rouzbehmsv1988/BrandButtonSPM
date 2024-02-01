//
//  ButtonStore.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation
import SwiftUI

// Class for the Button Store
final class ButtonStore: ObservableObject {
    @Published private(set) var state: ButtonState
    
    init(initialState: ButtonState) {
        self.state = initialState
    }
    
    func dispatch(action: ButtonAction) {
        buttonReducer(state: &state, action: action)
    }
}
