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
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    let changePasswordText: String = "Trocar"
    let changePasswordSubtext: String = "SENHA"
    let insertNewPasswordText: String = "Insira a nova senha"
    let newPasswordText: String = "Nova Senha"
    let cancelText: String = "CANCELAR"
    let changeText: String = "ATUALIZAR"
    let confirmationAlertText: String = "Tem certeza que deseja alterar sua senha?"
    
    func change(password: String, _ dismiss: DismissAction) {
        isLoading = true
        
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            self.isLoading = false
            if let error = error as? NSError {
                self.showErrorAlert = true
                
                switch AuthErrorCode.Code(rawValue: error.code) {
                case .userDisabled:
                    self.errorMessage = "Essa conta foi desabilitada pela administrador."
                case .weakPassword:
                    self.errorMessage = "A senha deve conter 6 ou mais caracteres."
                default:
                    self.errorMessage = "Ocorreu um erro ao tentar alterar a senha."
                }
                
            } else {
                dismiss()
            }
        }
    }
    
}
