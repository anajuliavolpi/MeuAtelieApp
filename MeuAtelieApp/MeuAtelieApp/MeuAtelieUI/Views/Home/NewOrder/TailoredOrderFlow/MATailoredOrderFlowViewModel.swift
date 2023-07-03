//
//  MATailoredOrderFlowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import Foundation

final class MATailoredOrderFlowViewModel: ObservableObject {
    
    var model: MAOrderModel
    
    var cloathesText: String = "Roupa"
    var tailoredText: String = "sob medida"
    let cloathesNameText: String = "Nome da peça"
    let cloathesNamePlaceholder: String = "Nome"
    let cloathesDescriptionText: String = "Descrição da peça"
    let cloathesDescriptionPlaceholder: String = "Descrição"
    let estimatedDeliveryDateText: String = "Data de entrega prevista"
    var continueActionButtonText: String = "CONTINUAR"
    
    @Published var cloathesName: String = ""
    @Published var cloathesDescription: String = ""
    @Published var dateNow = Date.now
    
    var isValid: Bool {
        !cloathesName.isEmpty && !cloathesDescription.isEmpty
    }
    
    init(_ model: MAOrderModel, editing: Bool = false) {
        self.model = model
    }
    
    // needs to finish this implementation
    private func setUpEditing() {
        cloathesText = "Editar"
        tailoredText = "PEDIDO"
        cloathesName = model.cloathesName
        cloathesDescription = model.cloathesDescription
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: model.estimatedDeliveryDate)
        dateNow = date ?? .now
        
        continueActionButtonText = "ATUALIZAR"
    }
    
}
