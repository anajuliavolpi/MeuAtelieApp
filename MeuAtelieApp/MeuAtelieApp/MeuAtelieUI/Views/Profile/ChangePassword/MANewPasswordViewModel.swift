//
//  MANewPasswordViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI
import Firebase

final class MANewPasswordViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    let newPasswordText = "Escolher nova senha"
    let insertNewPasswordText = "Insira a nova senha"
    let changeText: String = "TROCAR"
    
    func changePasswordWithNew(password: String, _ dismiss: DismissAction) {
        isLoading = true
        
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            self.isLoading = false
            if let error {
                print("some error ocurred when changing password: \(error)")
                return
            }
            
            dismiss()
        }
    }
    
}
