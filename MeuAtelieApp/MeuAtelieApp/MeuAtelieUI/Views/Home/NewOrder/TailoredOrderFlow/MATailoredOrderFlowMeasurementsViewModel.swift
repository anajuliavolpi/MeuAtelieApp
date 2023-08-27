//
//  MATailoredOrderFlowMeasurementsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import SwiftUI
import Firebase

final class MATailoredOrderFlowMeasurementsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    var model: MAOrderModel
    var path: Binding<NavigationPath>
    
    let cloathesText: String = "Roupa"
    let tailoredText: String = "sob medida"
    let measurementsText: String = "Insira as medidas (em centímetros)"
    let shoulderText: String = "Ombro"
    let bustText: String = "Busto"
    let lengthText: String = "Comprimento"
    let waistText: String = "Cintura"
    let abdomenText: String = "Abdomên"
    let hipsText: String = "Quadril"
    let finishActionButtonText: String = "FINALIZAR"
    
    init(_ model: MAOrderModel, path: Binding<NavigationPath>) {
        self.model = model
        self.path = path
    }
    
    func create(order: MAOrderModel) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(order.id)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "serviceType": order.serviceType.rawValue,
                     "clientId": order.client.id,
                     "clientName": order.client.fullName,
                     "clientPhone": order.client.phone,
                     "cloathesName": order.cloathesName,
                     "cloathesDescription": order.cloathesDescription,
                     "estimatedDeliveryDate": order.estimatedDeliveryDate,
                     "shoulderMeasurement": order.shoulderMeasurement,
                     "bustMeasurement": order.bustMeasurement,
                     "lengthMeasurement": order.lengthMeasurement,
                     "waistMeasurement": order.waistMeasurement,
                     "abdomenMeasurement": order.abdomenMeasurement,
                     "hipsMeasurement": order.hipsMeasurement,
                     "waistFix": false,
                     "lengthFix": false,
                     "hipsFix": false,
                     "barFix": false,
                     "shoulderFix": false,
                     "wristFix": false,
                     "legFix": false,
                     "totalValue": 0,
                     "hiredDate": Date.now.formatted()]
        ) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            self.path.wrappedValue.removeLast(self.path.wrappedValue.count)
        }
    }
    
}
