//
//  MAHomeViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MAHomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var orders: [MAOrderModel] = []
    
    let viewTitle: String = "Pedidos"
    
    func fetchOrders() {
        isLoading = true
        orders.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        ref.getDocuments { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }

            if let snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let userId = data["userId"] as? String ?? ""

                    if userId == Auth.auth().currentUser?.uid {
                        let serviceType = data["serviceType"] as? String ?? ""
                        let clientName = data["clientName"] as? String ?? ""
                        let clientPhone = data["clientPhone"] as? String ?? ""
                        let cloathesName = data["cloathesName"] as? String ?? ""
                        let cloathesDescription = data["cloathesDescription"] as? String ?? ""
                        let estimatedDeliveryDate = data["estimatedDeliveryDate"] as? String ?? ""
                        let shoulderMeasurement = data["shoulderMeasurement"] as? Int ?? 0
                        let bustMeasurement = data["bustMeasurement"] as? Int ?? 0
                        let lengthMeasurement = data["lengthMeasurement"] as? Int ?? 0
                        let waistMeasurement = data["waistMeasurement"] as? Int ?? 0
                        let abdomenMeasurement = data["abdomenMeasurement"] as? Int ?? 0
                        let hipsMeasurement = data["hipsMeasurement"] as? Int ?? 0
                        let waistFix = data["waistFix"] as? Bool ?? false
                        let lengthFix = data["lengthFix"] as? Bool ?? false
                        let hipsFix = data["hipsFix"] as? Bool ?? false
                        let barFix = data["barFix"] as? Bool ?? false
                        let shoulderFix = data["shoulderFix"] as? Bool ?? false
                        let wristFix = data["wristFix"] as? Bool ?? false
                        let legFix = data["legFix"] as? Bool ?? false
                        let totalValue = data["totalValue"] as? Double ?? 0.0
                        let hiredDate = data["hiredDate"] as? String ?? ""

                        self.orders.append(MAOrderModel(id: document.documentID,
                                                        serviceType: ServiceType(rawValue: serviceType) ?? .tailored,
                                                        client: MAClientModel(userId: "",
                                                                              id: "",
                                                                              fullName: clientName,
                                                                              phone: clientPhone),
                                                        cloathesName: cloathesName,
                                                        cloathesDescription: cloathesDescription,
                                                        estimatedDeliveryDate: String(estimatedDeliveryDate.prefix(10)),
                                                        shoulderMeasurement: shoulderMeasurement,
                                                        bustMeasurement: bustMeasurement,
                                                        lengthMeasurement: lengthMeasurement,
                                                        waistMeasurement: waistMeasurement,
                                                        abdomenMeasurement: abdomenMeasurement,
                                                        hipsMeasurement: hipsMeasurement,
                                                        waistFix: waistFix,
                                                        lengthFix: lengthFix,
                                                        hipsFix: hipsFix,
                                                        barFix: barFix,
                                                        shoulderFix: shoulderFix,
                                                        wristFix: wristFix,
                                                        legFix: legFix,
                                                        totalValue: totalValue,
                                                        hiredDate: hiredDate))
                    }
                }
            }
        }
    }
    
}
