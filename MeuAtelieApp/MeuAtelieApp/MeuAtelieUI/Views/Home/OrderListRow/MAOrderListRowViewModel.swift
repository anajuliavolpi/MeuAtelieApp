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

    lazy var dateText: String = {
        "Entrega: \(order.estimatedDeliveryDate)"
    }()

    init(order: MAOrderModel) {
        self.order = order
    }
    
}
