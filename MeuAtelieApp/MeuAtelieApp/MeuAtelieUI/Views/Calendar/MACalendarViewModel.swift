//
//  MACalendarViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 10/09/23.
//

import SwiftUI
import Firebase

final class MACalendarViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var orders: [MAOrderModel] = []
    @Published var selectedDate: Date = .now
    
    @Binding var navigationPath: NavigationPath
    
    var ordersDate: [(date: Date, status: OrderStatus)] = []
    
    let viewTitle: String = "Pedidos"
    let df = DateFormatter(dateFormat: "dd/MM/yy", calendar: .init(identifier: .gregorian))
    
    init(path: Binding<NavigationPath>) {
        self._navigationPath = path
        
        Task {
            await fetch()
        }
    }
    
    func getBadgeColor(order: MAOrderModel) -> Color {
        if order.status == .onGoing {
            if let date = df.date(from: order.estimatedDeliveryDate) {
                if date < Date.now {
                    return .MAColors.MARed
                } else {
                    return .MAColors.MACalendarPink
                }
            } else {
                return .clear
            }
        } else {
            return .MAColors.MAGreen
        }
    }
    
    @MainActor func fetch() async {
        self.isLoading = true
        self.orders.removeAll()
        self.ordersDate.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        do {
            let snapshot = try await ref.getDocuments()
            self.formatOrders(snapshot: snapshot)
            self.isLoading = false
        } catch {
            print("Some error occured: \(error)")
            self.isLoading = false
        }
    }
    
    func complete(order: MAOrderModel) {
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
                     "deliveryDate": Date.now.formatted()]
        ) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            Task {
                await self.fetch()
            }
        }
    }
    
    private func formatOrders(snapshot: QuerySnapshot) {
        for document in snapshot.documents {
            let data = document.data()
            let userId = data["userId"] as? String ?? ""
            
            if userId == Auth.auth().currentUser?.uid {
                let status = data["status"] as? String ?? ""
                let serviceType = data["serviceType"] as? String ?? ""
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
                
                self.orders.append(MAOrderModel(id: document.documentID,
                                                status: OrderStatus(rawValue: status) ?? .onGoing,
                                                serviceType: ServiceType(rawValue: serviceType) ?? .tailored,
                                                client: MAClientModel(userId: "",
                                                                      id: "",
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
                                                hiredDate: hiredDate,
                                                deliveryDate: String(deliveryDate.prefix(10))))
                
                if OrderStatus(rawValue: status) == .completed {
                    guard let date = self.df.date(from: String(deliveryDate.prefix(10))) else { return }
                    self.ordersDate.append((date: date, status: .completed))
                } else {
                    guard let date = self.df.date(from: String(estimatedDeliveryDate.prefix(10))) else { return }
                    self.ordersDate.append((date: date, status: .onGoing))
                }
            }
        }
    }
    
}
