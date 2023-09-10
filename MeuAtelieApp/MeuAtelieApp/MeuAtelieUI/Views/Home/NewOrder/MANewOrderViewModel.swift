//
//  MANewOrderViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI
import Firebase

final class MANewOrderViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var clients: [MAClientModel] = []
    @Published var orderService: String = "Serviço"
    @Published var orderClient: String = "Cliente"
    @Published var isValid: Bool = false
    @Published var piecesNumber: String = ""
    
    var showPieces: Bool {
        return orderService == service2Text 
    }
    
    let createText: String = "Criar"
    let newOrderText: String = "novo pedido"
    let serviceTypeText: String = "Selecione o tipo de serviço:"
    let service1Text: String = "Roupa sob medida"
    let service2Text: String = "Ajuste/Conserto de roupa"
    let clientSelectionText: String = "Selecione o cliente:"
    let newClientText: String = "Adicionar novo cliente"
    let piecesQuantityText: String = "Quantidade de peças"
    let piecesQuantityPlaceholder: String = "Quantidade"
    let continueActionText: String = "CONTINUAR"
    
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
    
    func validateFields() {
        if showPieces {
            isValid = (orderService == service1Text || orderService == service2Text) && orderClient != "Cliente" && Int(piecesNumber) ?? 0 > 0
        } else {
            isValid = (orderService == service1Text || orderService == service2Text) && orderClient != "Cliente"
        }
    }
    
}
