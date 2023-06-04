//
//  MATailoredOrderFlowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import Foundation

final class MATailoredOrderFlowViewModel {
    
    var model: MAOrderModel
    
    let cloathesText: String = "Roupa"
    let tailoredText: String = "sob medida"
    let cloathesNameText: String = "Nome da peça"
    let cloathesNamePlaceholder: String = "Nome"
    let cloathesDescriptionText: String = "Descrição da peça"
    let cloathesDescriptionPlaceholder: String = "Descrição"
    let estimatedDeliveryDateText: String = "Data de entrega prevista"
    let continueActionButtonText: String = "CONTINUAR"
    
    init(_ model: MAOrderModel) {
        self.model = model
    }
    
}
