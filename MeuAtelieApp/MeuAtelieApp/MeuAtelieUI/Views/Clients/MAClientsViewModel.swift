//
//  MAClientsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Firebase

final class MAClientsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var clients: [MAClientModel] = []
    
    var viewTitle: String = "Clientes"
    var newClientText: String = "+"
    
    init() {
        fetchClients()
    }
    
    func fetchClients() {
        isLoading = true
        clients.removeAll()
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
                    
                    if userId == Auth.auth().currentUser?.uid {
                        let clientFullName = data["fullname"] as? String ?? ""
                        let clientPhone = data["phone"] as? String ?? ""
                        let clientEmail = data["email"] as? String ?? ""
                        
                        self.clients.append(MAClientModel(userId: userId,
                                                          id: document.documentID,
                                                          fullName: clientFullName,
                                                          phone: clientPhone,
                                                          email: clientEmail))
                    }
                }
            }
        }
    }
    
}
