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
            if let error {
                self.isShowingError = true
                self.errorMessage = error.localizedDescription
                return
            }
            
            networkManager.isUserLoggedIn()
        }
    }
    
}
