//
//  MAOrderListRowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import Foundation

final class MAOrderListRowViewModel {
    
    var order: MAOrderModel
    var action: (() -> ())
    
    lazy var clientText: String = {
        "Cliente: \(order.clientName)"
    }()
    
    lazy var typeText: String = {
        "Tipo de peça: \(order.typeName)"
    }()
    
    lazy var dateText: String = {
        "Data: \(order.dateOfDelivery)"
    }()
    
    let deleteText: String = "Deletar"
    
    init(order: MAOrderModel, action: @escaping (() -> ())) {
        self.order = order
        self.action = action
    }
    
}
