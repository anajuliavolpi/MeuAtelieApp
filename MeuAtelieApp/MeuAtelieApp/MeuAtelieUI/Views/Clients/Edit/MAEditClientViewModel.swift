//
//  MAEditClientViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI
import Firebase

final class MAEditClientViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var fullName: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    
    var clientID: String
    
    let editText: String = "Editar"
    let clientText: String = "cliente"
    let saveText: String = "SALVAR"
    let fullNameText: String = "Nome completo"
    let phoneText: String = "Telefone"
    let emailText: String = "Email"
    
    init(clientID: String) {
        self.clientID = clientID
        
        fetchClient()
    }
    
    func fetchClient() {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients")
        
        ref.getDocuments { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let userId = data["userId"] as? String ?? ""
                    
                    if userId == Auth.auth().currentUser?.uid && document.documentID == self.clientID {
                        let clientFullName = data["fullname"] as? String ?? ""
                        let clientPhone = data["phone"] as? String ?? ""
                        let clientEmail = data["email"] as? String ?? ""
                        
                        self.fullName = clientFullName
                        self.phone = clientPhone
                        self.email = clientEmail
                    }
                }
            }
        }
    }
    
    func saveClient(_ dismiss: DismissAction) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients").document(self.clientID)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "fullname": self.fullName,
                     "phone": self.phone,
                     "email": self.email]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            dismiss()
        }
    }
    
}
