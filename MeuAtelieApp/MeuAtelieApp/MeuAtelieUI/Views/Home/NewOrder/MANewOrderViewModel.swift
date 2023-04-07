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
    
    let createNewOrderText: String = "Criar novo pedido"
    let clientText: String = "Cliente"
    let typeText: String = "Tipo de peça"
    let deliveryDateText: String = "Data de entrega"
    let createText: String = "CRIAR"
    
    func create(order: MAOrderModel, _ dismiss: DismissAction) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(order.id)
        
        ref.setData(["clientName": order.clientName,
                     "typeName": order.typeName,
                     "dateOfDelivery": order.dateOfDelivery]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            dismiss()
        }
    }
    
}
