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
    
    let createText: String = "Criar"
    let newOrderText: String = "novo pedido"
    let serviceTypeText: String = "Selecione o tipo de serviço:"
    let service1Text: String = "Roupa sob medida"
    let service2Text: String = "Ajuste/Conserto de roupa"
    let clientSelectionText: String = "Selecione o cliente:"
    let newClientText: String = "Adicionar novo cliente"
    let continueActionText: String = "CONTINUAR"
    
//    func create(order: MAOrderModel, _ dismiss: DismissAction) {
//        isLoading = true
//        let db = Firestore.firestore()
//        let ref = db.collection("Orders").document(order.id)
//
//        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
//                     "clientName": order.clientName,
//                     "typeName": order.typeName,
//                     "dateOfDelivery": order.dateOfDelivery]) { error in
//            self.isLoading = false
//            if let error {
//                print("some error occured on creating data for order: \(error)")
//                return
//            }
//
//            dismiss()
//        }
//    }
    
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
                        
                        self.clients.append(MAClientModel(id: document.documentID,
                                                          fullName: clientFullName,
                                                          phone: clientPhone))
                    }
                }
            }
        }
    }
    
}
