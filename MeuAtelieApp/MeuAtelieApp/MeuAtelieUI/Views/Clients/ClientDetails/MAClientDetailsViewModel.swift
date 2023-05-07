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
    
    var client: MAClientModel
    var clientPhone: String {
        "Telefone: \(client.phone)"
    }
    
    let clientServicesText: String = "SERVIÇOS CONTRATADOS"
    let editClientText: String = "EDITAR CLIENTE"
    let deleteClientText: String = "DELETAR CLIENTE"
    
    init(_ client: MAClientModel) {
        self.client = client
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
                for document in snapshot.documents where document.documentID == self.client.id {
                    document.reference.delete()
                }
            }
            
            dismiss()
        }
    }
    
}
