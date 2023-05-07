//
//  View+Ext.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI

extension View {
    
    public func addMALoading(state: Bool) -> some View {
        ZStack {
            self
                .disabled(state)
                .opacity(state ? 0.5 : 1)
            
            if state {
                ProgressView()
                    .tint(.MAColors.MAPinkMedium)
                    .scaleEffect(2)
            }
        }
    }
    
    public func addMAError(state: Bool, message: String, action: @escaping (() -> ())) -> some View {
        ZStack {
            self
                .disabled(state)
                .opacity(state ? 0.5 : 1)
            
            if state {
                MAErrorView(buttonMessage: message, action: action)
                    .padding()
            }
        }
        .animation(.default, value: state)
    }
    
    public func hideKeyboard() -> some View {
        self
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}
