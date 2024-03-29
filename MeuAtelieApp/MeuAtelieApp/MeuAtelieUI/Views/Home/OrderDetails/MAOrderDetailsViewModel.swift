//
//  MAOrderDetailsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI
import Firebase

final class MAOrderDetailsViewModel: ObservableObject {
    
    let clientText: String = "CLIENTE"
    let nameText: String = "Nome"
    let phoneText: String = "Telefone"
    let serviceText: String = "Serviço"
    let cloathesNameText: String = "Título da peça"
    let cloathesDescriptionText: String = "Descrição"
    let measurementsText: String = "Medidas"
    let fixesText: String = "Ajustes"
    let bustText: String = "Busto"
    let waistText: String = "Cintura"
    let hipsText: String = "Quadril"
    let lengthText: String = "Comprimento"
    let hiredText: String = "Contratado em"
    let estimatedDeliveryDateText: String = "Data de entrega prevista"
    let deliveryDateText: String = "Data efetiva da entrega"
    let totalValueText: String = "Valor total"
    let cloathesPhotos: String = "Peças modelo"
    let editText: String = "EDITAR"
    let deleteText: String = "DELETAR"
    let finishText: String = "FINALIZAR PEDIDO"
    
    @Published var isLoading: Bool = false
    @Published var order: MAOrderModel?
    @Published var fixes: [String] = []
    @Published var isCompletedOrder: Bool = false
    
    @Published var headerText: String = ""
    @Published var subheaderText: String = ""
    
    let orderID: String
    
    init(orderID: String) {
        self.orderID = orderID
    }
    
    func complete() {
        guard let order = order else { return }
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(order.id)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "status": OrderStatus.completed.rawValue,
                     "serviceType": order.serviceType.rawValue,
                     "clientId": order.client.id,
                     "clientName": order.client.fullName,
                     "clientPhone": order.client.phone,
                     "clientEmail": order.client.email,
                     "cloathesName": order.cloathesName,
                     "cloathesDescription": order.cloathesDescription,
                     "estimatedDeliveryDate": order.estimatedDeliveryDate,
                     "shoulderMeasurement": order.shoulderMeasurement,
                     "bustMeasurement": order.bustMeasurement,
                     "lengthMeasurement": order.lengthMeasurement,
                     "waistMeasurement": order.waistMeasurement,
                     "abdomenMeasurement": order.abdomenMeasurement,
                     "hipsMeasurement": order.hipsMeasurement,
                     "waistFix": order.waistFix,
                     "lengthFix": order.lengthFix,
                     "hipsFix": order.hipsFix,
                     "barFix": order.barFix,
                     "shoulderFix": order.shoulderFix,
                     "wristFix": order.wristFix,
                     "legFix": order.legFix,
                     "totalValue": order.totalValue,
                     "hiredDate": order.hiredDate,
                     "deliveryDate": Date.now.formatted(),
                     "imagesURLs": order.imagesURLs ?? []]
        ) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            self.fetchOrder()
        }
    }
    
    func deleteOrder(_ dismiss: DismissAction) {
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
                for document in snapshot.documents where document.documentID == self.orderID {
                    document.reference.delete()
                }
            }
            
            dismiss()
        }
    }
    
    func fetchOrder() {
        self.isLoading = true
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
                    
                    if document.documentID == self.orderID {
                        let status = data["status"] as? String ?? ""
                        let serviceType = data["serviceType"] as? String ?? ""
                        let clientId = data["clientId"] as? String ?? ""
                        let clientName = data["clientName"] as? String ?? ""
                        let clientPhone = data["clientPhone"] as? String ?? ""
                        let clientEmail = data["clientEmail"] as? String ?? ""
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
                        let deliveryDate = data["deliveryDate"] as? String ?? ""
                        let imagesURLs = data["imagesURLs"] as? [String]
                        
                        self.order = MAOrderModel(id: document.documentID,
                                                  status: OrderStatus(rawValue: status) ?? .onGoing,
                                                  serviceType: ServiceType(rawValue: serviceType) ?? .tailored,
                                                  client: MAClientModel(userId: userId,
                                                                        id: clientId,
                                                                        fullName: clientName,
                                                                        phone: clientPhone,
                                                                        email: clientEmail),
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
                                                  hiredDate: String(hiredDate.prefix(10)),
                                                  deliveryDate: String(deliveryDate.prefix(10)),
                                                  imagesURLs: imagesURLs)
                        
                        if self.order?.serviceType == .fixes {
                            let mirror = Mirror(reflecting: self.order!)
                            var selectedFixes: [String] = []
                            
                            for children in mirror.children {
                                if children.value as? Bool == true {
                                    selectedFixes.append(children.label ?? "")
                                }
                            }
                            
                            self.setList(fixes: selectedFixes)
                        }
                        
                        self.updateUI()
                    }
                }
            }
        }
    }
    
    private func setList(fixes: [String]) {
        self.fixes.removeAll()
        let dict: [String: String] = [
            "waistFix": "Ajuste de cintura",
            "lengthFix": "Ajuste de manga",
            "hipsFix": "Ajuste de quadril",
            "barFix": "Ajuste de barra",
            "shoulderFix": "Ajuste de ombro",
            "wristFix": "Ajuste de punho",
            "legFix": "Ajuste de perna"
        ]
        
        for (key, value) in dict {
            if fixes.contains(key) {
                self.fixes.append(value)
            }
        }
    }
    
    private func updateUI() {
        guard let order = order else { return }
        
        if order.status == .onGoing {
            self.isCompletedOrder = false
            headerText = "Detalhes"
            subheaderText = "DO PEDIDO"
        } else {
            self.isCompletedOrder = true
            headerText = "Pedido"
            subheaderText = "FINALIZADO"
        }
    }
    
}
