//
//  MAProfileViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI
import Firebase

final class MAProfileViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var model: MARegisterModel? = nil
    @Published var isShowingChangePassword: Bool = false
    
    let helloText: String = "Olá, "
    let checkYourDataText: String = "Confira seus dados:"
    let emailText: String = "Email:"
    let nameText: String = "Nome:"
    
    lazy var fullNameText: String = {
        "\(model?.firstName ?? "") \(model?.lastName ?? "")"
    }()
    
    let changePasswordText: String = "Trocar de senha"
    let exitText: String = "SAIR"
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
        
        ref.getDocument { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching user data: \(error)")
                return
            }
            
            if let snapshot {
                let data = snapshot.data()
                self.model = MARegisterModel(emailAddress: Auth.auth().currentUser?.email ?? "",
                                             password: "",
                                             firstName: data?["name"] as? String ?? "",
                                             lastName: data?["lastname"] as? String ?? "")
            }
        }
    }
    
    func signOutWith(_ networkManager: NetworkManager) {
        isLoading = true
        do {
            self.isLoading = false
            try Auth.auth().signOut()
            networkManager.signOut()
        } catch {
            print("Some error on signing out: \(error)")
        }
    }
    
}
