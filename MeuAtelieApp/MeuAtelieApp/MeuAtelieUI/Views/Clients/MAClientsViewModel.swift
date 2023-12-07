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
    
    @Binding var navigationPath: NavigationPath
    
    var viewTitle: String = "Clientes"
    var newClientText: String = "+"
    
    init(path: Binding<NavigationPath>) {
        self._navigationPath = path
        
        Task {
            await fetch()
        }
    }
    
    @MainActor func fetch() async {
        self.isLoading = true
        self.clients.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Clients")
        
        do {
            let snapshot = try await ref.getDocuments()
            self.configureClientModel(with: snapshot)
            self.isLoading = false
        } catch {
            print("Some error occured: \(error)")
            self.isLoading = false
        }
    }
    
    private func configureClientModel(with snapshot: QuerySnapshot) {
        for document in snapshot.documents {
            let data = document.data()
            let userId = data["userId"] as? String ?? ""
            
            if userId == Auth.auth().currentUser?.uid {
                let clientFullName = data["fullname"] as? String ?? ""
                let clientPhone = data["phone"] as? String ?? ""
                let clientEmail = data["email"] as? String ?? ""
                let clientImageURL = data["imageURL"] as? String
                
                self.clients.append(MAClientModel(userId: userId,
                                                  id: document.documentID,
                                                  fullName: clientFullName,
                                                  phone: clientPhone,
                                                  email: clientEmail,
                                                  imageURL: clientImageURL))
            }
        }
    }
    
}
