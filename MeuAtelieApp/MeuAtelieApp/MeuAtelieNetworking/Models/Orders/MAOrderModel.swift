//
//  MAOrderModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import Foundation

struct MAOrderModel: Identifiable {
    
    let uuid = UUID()
    let id: String
    let clientName: String
    let typeName: String
    let dateOfDelivery: String
    
}
