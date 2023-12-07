//
//  MAOrderListRowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import Foundation

final class MAOrderListRowViewModel {
    
    var order: MAOrderModel

    lazy var serviceType: String = {
        "Serviço: \(order.serviceType.rawValue)"
    }()
    
    lazy var titleDescription: String = {
        "Peça: \(order.cloathesName)"
    }()

    lazy var dateText: String = {
        if order.status == .onGoing {
            return "Entrega: \(order.estimatedDeliveryDate)"
        } else {
            return "Entregue em: \(order.deliveryDate)"
        }
    }()

    init(order: MAOrderModel) {
        self.order = order
    }
    
}
