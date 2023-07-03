//
//  MAOrderDetailsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI
import Firebase

final class MAOrderDetailsViewModel: ObservableObject {
    
    let headerText: String = "Detalhes"
    let subheaderText: String = "DO PEDIDO"
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
    let totalValueText: String = "Valor total"
    let cloathesPhotos: String = "Peças modelo"
    let editText: String = "EDITAR"
    let deleteText: String = "DELETAR"
    let finishText: String = "FINALIZAR PEDIDO"
    
    @Published var isLoading: Bool = false
    @Published var order: MAOrderModel?
    @Published var fixes: [String] = []
    
    let orderID: String
    
    init(orderID: String) {
        self.orderID = orderID
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
                    
                    if userId == Auth.auth().currentUser?.uid && document.documentID == self.orderID {
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
                        
                        self.order = MAOrderModel(id: UUID().uuidString,
                                                  serviceType: ServiceType(rawValue: serviceType) ?? .tailored,
                                                  client: MAClientModel(id: "",
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
                                                  hiredDate: String(hiredDate.prefix(10)))
                        
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
                        
                    }
                }
            }
        }
    }
    
    private func setList(fixes: [String]) {
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
    
}
