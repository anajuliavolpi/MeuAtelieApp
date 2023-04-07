//
//  MALoginViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MALoginViewModel {
    
    let backgroundColors: [Color] = [.MAColors.MAPinkLightStrong,
                                     .MAColors.MAPinkLight,
                                     .MAColors.MAPinkLightMedium]
    let loginText: String = "Login"
    let passwordText: String = "Senha"
    let enterText: String = "ENTRAR"
    let registerText: String = "Não tem conta? Cadastre-se!"
    
    func signInWith(_ networkManager: NetworkManager, login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if let error {
                print(error)
                return
            }
            
            networkManager.isUserLoggedIn()
        }
    }
    
}
