//
//  MALoginViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MALoginViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isShowingError: Bool = false
    @Published var errorMessage: String = ""
    
    let backgroundColors: [Color] = [.MAColors.MAPinkLightStrong,
                                     .MAColors.MAPinkLight,
                                     .MAColors.MAPinkLightMedium]
    let loginText: String = "Login"
    let passwordText: String = "Senha"
    let enterText: String = "ENTRAR"
    let registerText: String = "Não tem conta? Cadastre-se!"
    
    func signInWith(_ networkManager: NetworkManager, login: String, password: String) {
        isLoading = true
        
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            self.isLoading = false
            if let error = error as? NSError {
                switch AuthErrorCode.Code(rawValue: error.code) {
                case .wrongPassword:
                    self.errorMessage = "Senha incorreta, por favor tente novamente."
                case .invalidEmail:
                    self.errorMessage = "Email inválido, por favor tente novamente."
                case .userNotFound:
                    self.errorMessage = "Email não encontrado, por favor tente novamente."
                default:
                    self.errorMessage = error.localizedDescription
                }
                
                self.isShowingError = true
                return
            }
            
            networkManager.isUserLoggedIn()
        }
    }
    
}
