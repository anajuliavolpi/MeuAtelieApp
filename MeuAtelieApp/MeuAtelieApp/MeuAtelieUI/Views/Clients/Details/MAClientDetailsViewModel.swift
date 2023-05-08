//
//  MAClientDetailsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI
import Firebase

final class MAClientDetailsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var fullName: String = ""
    @Published var phone: String = ""
    
    var clientID: String
    
    let clientServicesText: String = "SERVIÇOS CONTRATADOS"
    let editClientText: String = "EDITAR CLIENTE"
    let deleteClientText: String = "DELETAR CLIENTE"
    
    init(_ clientID: String) {
        self.clientID = clientID
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
                        
                        self.fullName = clientFullName
                        self.phone = clientPhone
                    }
                }
            }
        }
    }
    
    func deleteClient(_ dismiss: DismissAction) {
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
                for document in snapshot.documents where document.documentID == self.clientID {
                    document.reference.delete()
                }
            }
            
            dismiss()
        }
    }
    
}
