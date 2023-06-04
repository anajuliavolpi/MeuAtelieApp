//
//  MAOrderModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import Foundation

enum ServiceType: String {
    case tailored = "Roupa sob medida"
    case fixes = "Ajuste/Conserto de roupa"
}

struct MAOrderModel: Identifiable {
    
    let uuid = UUID()
    let id: String
    let serviceType: ServiceType
    let client: MAClientModel
    let cloathesName: String
    let cloathesDescription: String
    let estimatedDeliveryDate: String
    let shoulderMeasurement: Int
    let bustMeasurement: Int
    let lengthMeasurement: Int
    let waistMeasurement: Int
    let abdomenMeasurement: Int
    let hipsMeasurement: Int
    
}
