//
//  MAHomeViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MAHomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showingCreateNewOrder: Bool = false
    @Published var orders: [MAOrderModel] = []
    
    let viewTitle: String = "Pedidos"
    let navBarText: String = "Novo pedido"
    
    init() {
        fetchOrders()
    }
    
    func fetchOrders() {
        isLoading = true
        orders.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        ref.getDocuments { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let clientName = data["clientName"] as? String ?? ""
                    let typeName = data["typeName"] as? String ?? ""
                    let dateOfDelivery = data["dateOfDelivery"] as? String ?? ""
                    
                    self.orders.append(MAOrderModel(id: document.documentID,
                                                    clientName: clientName,
                                                    typeName: typeName,
                                                    dateOfDelivery: dateOfDelivery))
                }
            }
        }
    }
    
    func deleteOrderWith(id: String) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        ref.getDocuments { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents where document.documentID == id {
                    document.reference.delete()
                }
            }
            
            self.fetchOrders()
        }
    }
    
}
