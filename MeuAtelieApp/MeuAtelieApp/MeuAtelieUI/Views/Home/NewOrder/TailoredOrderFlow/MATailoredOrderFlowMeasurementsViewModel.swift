//
//  MATailoredOrderFlowMeasurementsViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

final class MATailoredOrderFlowMeasurementsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    var model: MAOrderModel
    var images: [OrderImages]
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
    
    init(_ model: MAOrderModel, images: [OrderImages], path: Binding<NavigationPath>) {
        self.model = model
        self.images = images
        self.path = path
    }
    
    func uploadImages(order: MAOrderModel) {
        isLoading = true
        model = order
        
        var urls: [String] = []
        for (index, image) in images.enumerated() {
            guard let imageData = image.uiImage.jpegData(compressionQuality: 0.5) else { return }
            
            let storageRef = Storage.storage().reference()
            let fileRef = storageRef.child("\(order.client.id)/\(order.id)/\(Date.now.timeIntervalSince1970.description).jpg")
            
            DispatchQueue.main.async {
                fileRef.putData(imageData) { _, error in
                    if let error {
                        self.isLoading = false
                        self.path.wrappedValue.removeLast(self.path.wrappedValue.count)
                        
                        print("Some error while trying to upload images: \(error)")
                        return
                    }
                    
                    fileRef.downloadURL { url, error in
                        if let error {
                            self.isLoading = false
                            self.path.wrappedValue.removeLast(self.path.wrappedValue.count)
                            
                            print("Some error while trying to get the image URL: \(error)")
                            return
                        }
                        
                        guard let urlString = url?.absoluteString else { return }
                        urls.append(urlString)
                        
                        if index == self.images.count - 1 {
                            self.model.imagesURLs = urls
                            self.create(order: self.model)
                        }
                    }
                }
            }
        }
    }
    
    func create(order: MAOrderModel) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(order.id)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "status": order.status.rawValue,
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
                     "waistFix": false,
                     "lengthFix": false,
                     "hipsFix": false,
                     "barFix": false,
                     "shoulderFix": false,
                     "wristFix": false,
                     "legFix": false,
                     "totalValue": 0,
                     "hiredDate": Date.now.formatted(),
                     "imagesURLs": order.imagesURLs ?? []]
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
