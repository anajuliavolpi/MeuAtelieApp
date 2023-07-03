//
//  MAFixesOrderFlowViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import Foundation
import Firebase

final class MAFixesOrderFlowViewModel: ObservableObject {
    
    var model: MAOrderModel
    var pieces: Int
    var currentPiece: Int = 1 {
        didSet {
            updateTexts()
        }
    }
    
    let headerText: String = "Ajuste/Conserto"
    let subheaderText: String = "DE ROUPA"
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
    
    init(_ model: MAOrderModel, pieces: Int) {
        self.model = model
        self.pieces = pieces
        
        updateTexts()
    }
    
    func register() {
        registerOrder()
        
        if currentPiece != pieces {
            updateTexts()
        } else {
            NavigationUtil.popToRootView()
        }
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
        let ref = db.collection("Orders").document(UUID().uuidString)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "serviceType": model.serviceType.rawValue,
                     "clientName": model.client.fullName,
                     "clientPhone": model.client.phone,
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
                     "totalValue": getTotalValue()]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            self.currentPiece += 1
        }
    }
    
}
