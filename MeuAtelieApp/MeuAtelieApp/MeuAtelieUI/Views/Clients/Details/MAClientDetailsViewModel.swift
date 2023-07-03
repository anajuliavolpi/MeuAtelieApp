//
//  MAClientDetailsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI
import Firebase

final class MAClientDetailsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var fullName: String = ""
    @Published var phone: String = ""
    @Published var order: [MAOrderModel] = []
    
    var clientID: String
    var clientUserID: String
    
    let clientServicesText: String = "SERVIÇOS CONTRATADOS"
    let editClientText: String = "EDITAR CLIENTE"
    let deleteClientText: String = "DELETAR CLIENTE"
    
    init(_ clientID: String, clientUserID: String) {
        self.clientID = clientID
        self.clientUserID = clientUserID
    }
    
    func fetchClient() {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients")
        
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
                    
                    if userId == Auth.auth().currentUser?.uid && document.documentID == self.clientID {
                        let clientFullName = data["fullname"] as? String ?? ""
                        let clientPhone = data["phone"] as? String ?? ""
                        
                        self.fullName = clientFullName
                        self.phone = clientPhone
                    }
                }
            }
        }
    }
    
    func deleteClient(_ dismiss: DismissAction) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients")
        
        ref.getDocuments { snapshot, error in
            self.isLoading = false
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents where document.documentID == self.clientID {
                    document.reference.delete()
                }
            }
            
            dismiss()
        }
    }
    
    func fetchClientOrders() {
        isLoading = true
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
                    let clientOrderID = data["clientId"] as? String ?? ""
                    
                    if self.clientID == clientOrderID {
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
                        
                        self.order.append(MAOrderModel(id: document.documentID,
                                                       serviceType: ServiceType(rawValue: serviceType) ?? .tailored,
                                                       client: MAClientModel(userId: userId,
                                                                             id: clientOrderID,
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
                                                       hiredDate: String(hiredDate.prefix(10))))
                    }
                }
            }
        }
    }
    
}
