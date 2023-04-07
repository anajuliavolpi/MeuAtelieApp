//
//  MARegisterViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MARegisterViewModel {
    
    let backgroundColors: [Color] = [.MAColors.MAPinkLightStrong,
                                     .MAColors.MAPinkLight,
                                     .MAColors.MAPinkLightMedium]
    let fillYourDataText: String = "Preencha seus dados"
    let emailText: String = "Email"
    let passwordText: String = "Senha"
    let firstNameText: String = "Primeiro nome"
    let lastNameText: String = "Último nome"
    let registerText: String = "CADASTRAR"
    
    func signUpWith(_ networkManager: NetworkManager, and model: MARegisterModel) {
        Auth.auth().createUser(withEmail: model.emailAddress, password: model.password) { result, error in
            if let error {
                print("some error occured on user sign up: \(error)")
                return
            }
            
            let db = Firestore.firestore()
            let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            ref.setData(["name": model.firstName, "lastname": model.lastName]) { error in
                if let error {
                    print("some error occured on creating data for user: \(error)")
                    return
                }
            }
            
            networkManager.isUserLoggedIn()
        }
    }
    
}
