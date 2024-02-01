//
//  BrandButton.swift
//  BrandButton
//
//  Created by rouzbeh on 31.01.24.
//

import Foundation
import SwiftUI

public struct BrandButton: View {
    @StateObject var store: ButtonStore
    @Binding var isDisabled: Bool
    let dispatch: () -> Void
    
    public init(action: @escaping () -> Void,
         isDisabled: Binding<Bool>,
         color: Color,
         font: Font? = nil,
         image: Image? = nil,
         style: ButtonStyles? = .leading,
         mode: ButtonModes) {
        self._isDisabled = isDisabled
        let initialState = ButtonState(color: color,
                                       isPressed: false,
                                       isEnabled: !isDisabled.wrappedValue,
                                       font: font,
                                       image: image,
                                       style: style,
                                       mode: mode)
        
        _store = StateObject(wrappedValue: ButtonStore(initialState: initialState))
        self.dispatch = action
    }
    
    public var body: some View {
        ZStack {
            store.state.colorSet.backgroundColor
                .frame(height: 44)
                .cornerRadius(8) // Apply corner radius first
                .overlay(
                    RoundedRectangle(cornerRadius: 8) // Use RoundedRectangle for the border
                        .stroke(store.state.colorSet.bordercolor, lineWidth: 1) // Set the stroke (border)
                )
            buttonContent(store.state.style,
                          store.state.mode)
        }
        .padding()
        .onTapGesture {
            guard store.state.isEnabled else { return }
            DispatchQueue.main.async {
                store.dispatch(action: .press)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4,
                                              execute: {
                    self.dispatch()
                    store.dispatch(action: .release)
                })
                
            }
        }
        .onChange(of: isDisabled) { newValue in
            store.dispatch(action: !newValue ? .enable: .disable)
        }
        .scaleEffect(store.state.isPressed ? 1.2: 1.0)
        .animation(.easeInOut(duration: 0.3),
                   value: store.state.isPressed)
    }
    
    @ViewBuilder private func buttonContent(_ style: ButtonStyles? = nil,
                                    _ mode: ButtonModes) -> some View {
        switch style {
        case .trailing:
            trailingStyle()
        case .leading:
            leadingStyle()
        default:
            Text(store.state.title)
                .foregroundStyle(store.state.colorSet.titleColor)
        }
        
    }
    
    private func trailingStyle() -> some View {
        HStack(spacing: 8) {
            Text(store.state.title)
                .foregroundStyle(store.state.colorSet.titleColor)
            if let image = store.state.image {
                image
                    .resizable()
                    .frame(width: 20,
                           height: 20)
                    .background(store.state.colorSet.imageBackgroundColor)
            }
        }
    }
    
    private func leadingStyle() -> some View {
        HStack(spacing: 8) {
            if let image = store.state.image {
                image
                    .resizable()
                    .frame(width: 20,
                           height: 20)
                    .background(store.state.colorSet.imageBackgroundColor)
            }
            Text(store.state.title)
                .foregroundStyle(store.state.colorSet.titleColor)
        }
    }
}

