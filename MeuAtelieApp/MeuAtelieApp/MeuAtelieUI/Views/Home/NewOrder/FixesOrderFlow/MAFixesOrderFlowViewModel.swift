//
//  MAFixesOrderFlowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI
import Firebase

final class MAFixesOrderFlowViewModel: ObservableObject {
    
    var model: MAOrderModel
    var pieces: Int
    var currentPiece: Int = 1 {
        didSet {
            updateTexts()
        }
    }
    var path: Binding<NavigationPath>
    var isEditing: Bool
    
    var headerText: String = "Ajuste/Conserto"
    var subheaderText: String = "DE ROUPA"
    let selectFixesText: String = "Selecione os ajustes solicitados:"
    let pieceName: String = "Nome da peça:"
    let pieceNamePlaceholder: String = "Nome"
    let pieceDescription: String = "Descrição da Peça:"
    let pieceDescriptionPlaceholder: String = "Descrição:"
    let deliveryDateText: String = "Data de entrega prevista"
    let adjustFixText: String = "Ajuste/Conserto"
    let valueText: String = "Valor"
    
    var modelsToRegister: [MAOrderModel] = []
    
    struct Fixes: Hashable {
        var toggle: Bool
        let description: String
        let value: Double
    }
    
    @Published var isLoading: Bool = false
    @Published var continueButtonText: String = "FINALIZAR"
    @Published var piecesText: String = "PEÇA ÚNICA"
    @Published var cloathesName: String = ""
    @Published var cloathesDescription: String = ""
    @Published var dateNow = Date.now
    @Published var fixes: [Fixes] = [
        .init(toggle: false, description: "Ajuste de cintura", value: 25),
        .init(toggle: false, description: "Ajuste de manga", value: 15),
        .init(toggle: false, description: "Ajuste de quadril", value: 34),
        .init(toggle: false, description: "Ajuste de barra", value: 36),
        .init(toggle: false, description: "Ajuste de ombro", value: 15),
        .init(toggle: false, description: "Ajuste de punho", value: 46),
        .init(toggle: false, description: "Ajuste de perna", value: 84),
    ]
    
    var isValid: Bool {
        !cloathesName.isEmpty && !cloathesDescription.isEmpty
    }
    
    init(_ model: MAOrderModel, pieces: Int, path: Binding<NavigationPath>, editing: Bool = false) {
        self.model = model
        self.pieces = pieces
        self.path = path
        self.isEditing = editing
        
        if editing {
            setUpEditing()
        } else {
            updateTexts()
        }
    }
    
    func register() {
        registerOrder()
        
        if currentPiece != pieces {
            updateTexts()
        } else {
            path.wrappedValue.removeLast(path.wrappedValue.count)
        }
    }
    
    private func setUpEditing() {
        headerText = "Editar"
        subheaderText = "PEDIDO"
        piecesText = "SERVIÇO"
        cloathesName = model.cloathesName
        cloathesDescription = model.cloathesDescription
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: model.estimatedDeliveryDate)
        dateNow = date ?? .now
        
        fixes = [
            .init(toggle: model.waistFix, description: "Ajuste de cintura", value: 25),
            .init(toggle: model.lengthFix, description: "Ajuste de manga", value: 15),
            .init(toggle: model.hipsFix, description: "Ajuste de quadril", value: 34),
            .init(toggle: model.hipsFix, description: "Ajuste de barra", value: 36),
            .init(toggle: model.shoulderFix, description: "Ajuste de ombro", value: 15),
            .init(toggle: model.wristFix, description: "Ajuste de punho", value: 46),
            .init(toggle: model.legFix, description: "Ajuste de perna", value: 84),
        ]
        
        continueButtonText = "ATUALIZAR"
    }
    
    private func updateTexts() {
        if pieces > 1 {
            self.piecesText = "PEÇA \(currentPiece)/\(pieces)"
            self.continueButtonText = pieces != currentPiece ? "CONTINUAR" : "FINALIZAR"
            self.cloathesName = ""
            self.cloathesDescription = ""
            self.dateNow = .now
            self.fixes = [
                .init(toggle: false, description: "Ajuste de cintura", value: 25),
                .init(toggle: false, description: "Ajuste de manga", value: 15),
                .init(toggle: false, description: "Ajuste de quadril", value: 34),
                .init(toggle: false, description: "Ajuste de barra", value: 36),
                .init(toggle: false, description: "Ajuste de ombro", value: 15),
                .init(toggle: false, description: "Ajuste de punho", value: 46),
                .init(toggle: false, description: "Ajuste de perna", value: 84),
            ]
        }
    }
    
    private func getTotalValue() -> Double {
        let total = fixes.filter({$0.toggle}).map({$0.value}).reduce(0, +)
        return total
    }
    
    private func registerOrder() {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(isEditing ? model.id : UUID().uuidString)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "status": model.status.rawValue,
                     "serviceType": model.serviceType.rawValue,
                     "clientId": model.client.id,
                     "clientName": model.client.fullName,
                     "clientPhone": model.client.phone,
                     "clientEmail": model.client.email,
                     "cloathesName": cloathesName,
                     "cloathesDescription": cloathesDescription,
                     "estimatedDeliveryDate": dateNow.formatted(),
                     "shoulderMeasurement": 0,
                     "bustMeasurement": 0,
                     "lengthMeasurement": 0,
                     "waistMeasurement": 0,
                     "abdomenMeasurement": 0,
                     "hipsMeasurement": 0,
                     "waistFix": fixes[0].toggle, // these are hardcoded for now
                     "lengthFix": fixes[1].toggle,
                     "hipsFix": fixes[2].toggle,
                     "barFix": fixes[3].toggle,
                     "shoulderFix": fixes[4].toggle,
                     "wristFix": fixes[5].toggle,
                     "legFix": fixes[6].toggle,
                     "totalValue": getTotalValue(),
                     "hiredDate": Date.now.formatted()]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            self.currentPiece += 1
        }
    }
    
}
