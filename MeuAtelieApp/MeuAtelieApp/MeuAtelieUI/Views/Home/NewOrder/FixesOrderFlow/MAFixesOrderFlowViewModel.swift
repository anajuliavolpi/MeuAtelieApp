//
//  MAFixesOrderFlowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import Foundation

final class MAFixesOrderFlowViewModel {
    
    var model: MAOrderModel
    
    let headerText: String = "Ajuste/Conserto"
    let subheaderText: String = "DE ROUPA"
    
    init(_ model: MAOrderModel) {
        self.model = model
    }
    
}
