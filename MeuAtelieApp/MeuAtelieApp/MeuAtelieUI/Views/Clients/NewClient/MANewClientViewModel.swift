//
//  MANewClientViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Firebase

final class MANewClientViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    let createText: String = "Adicionar"
    let newClientText: String = "novo cliente"
    let fullNameText: String = "Nome completo"
    let phoneText: String = "Telefone"
    let createActionText: String = "CADASTRAR"
    let backText: String = "Voltar"
    
    func createClient(with client: MAClientModel, _ dismiss: DismissAction) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients").document(client.id)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "fullname": client.fullName,
                     "phone": client.phone]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            dismiss()
        }

    }
    
}
