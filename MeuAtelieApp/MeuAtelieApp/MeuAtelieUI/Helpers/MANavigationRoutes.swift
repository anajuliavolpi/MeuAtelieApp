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
        case tailoredFlowMeasurements(order: MAOrderModel, images: [OrderImages], editing: Bool)
    }
    
    enum ClientRoutes: Hashable {
        case newClient
        case details(client: MAClientModel)
        case edit(clientID: String)
    }
    
    enum CalendarRoutes: Hashable {
        case orderDetails(order: MAOrderModel)
        case editOrder(order: MAOrderModel)
    }
    
    enum ProfileRoutes: Hashable {
        case changePassword
    }
    
}
