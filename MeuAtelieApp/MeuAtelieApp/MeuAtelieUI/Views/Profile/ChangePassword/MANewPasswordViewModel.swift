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
    
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    @MainActor func change(password: String) async {
        self.isLoading = true
        
        do {
            try await Auth.auth().currentUser?.updatePassword(to: password)
            self.path.removeLast()
        } catch {
            let errorCode = (error as NSError).code
            
            switch AuthErrorCode.Code(rawValue: errorCode) {
            case .userDisabled:
                self.errorMessage = "Essa conta foi desabilitada pela administrador."
            case .weakPassword:
                self.errorMessage = "A senha deve conter 6 ou mais caracteres."
            default:
                self.errorMessage = "Ocorreu um erro ao tentar alterar a senha."
            }
            
            self.isLoading = false
            self.showErrorAlert = true
        }
    }
    
}
