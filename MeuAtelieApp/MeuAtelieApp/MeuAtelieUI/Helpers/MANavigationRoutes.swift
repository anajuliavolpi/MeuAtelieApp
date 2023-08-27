//
//  MANavigationRoutes.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/07/23.
//

import Foundation

struct MANavigationRoutes {
    
    enum LoginRoutes: Hashable {
        case register
    }
    
    enum HomeRoutes: Hashable {
        case orderDetails(order: MAOrderModel)
        case editOrder(order: MAOrderModel)
        case newOrder
        case newTailored(order: MAOrderModel)
        case newFixes(order: MAOrderModel, pieces: Int)
        case tailoredFlowMeasurements(order: MAOrderModel)
    }
    
}
