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
    
    @MainActor func uploadDocument(with order: MAOrderModel) async {
        self.model = order
        self.isLoading = true
        
        await uploadMultipleImages()
        await create()
        
        self.isLoading = false
        self.path.wrappedValue.removeLast(self.path.wrappedValue.count)
    }
    
    func uploadMultipleImages() async {
        for orderImage in self.images {
            let downloadURL = await self.upload(image: orderImage.uiImage, orderID: self.model.id)
            self.model.imagesURLs?.append(downloadURL)
        }
    }
    
    func upload(image: UIImage, orderID: String) async -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return "" }
        
        let ref = Storage.storage().reference()
        let fileRef = ref.child("\(orderID)/\(UUID().uuidString).jpg")
        
        do {
            let _ = try await fileRef.putDataAsync(imageData)
            let url = try await fileRef.downloadURL()
            return url.absoluteString
        } catch {
            print("Some error on uploading image: \(error)")
            return ""
        }
    }
    
    func create() async {
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(self.model.id)
        
        do {
            try await ref.setData(setDocumentData())
        } catch {
            print("Some error trying to create document: \(error)")
        }
    }
    
    private func setDocumentData() -> [String: Any] {
        return ["userId": Auth.auth().currentUser?.uid ?? "",
                "status": self.model.status.rawValue,
                "serviceType": self.model.serviceType.rawValue,
                "clientId": self.model.client.id,
                "clientName": self.model.client.fullName,
                "clientPhone": self.model.client.phone,
                "clientEmail": self.model.client.email,
                "cloathesName": self.model.cloathesName,
                "cloathesDescription": self.model.cloathesDescription,
                "estimatedDeliveryDate": self.model.estimatedDeliveryDate,
                "shoulderMeasurement": self.model.shoulderMeasurement,
                "bustMeasurement": self.model.bustMeasurement,
                "lengthMeasurement": self.model.lengthMeasurement,
                "waistMeasurement": self.model.waistMeasurement,
                "abdomenMeasurement": self.model.abdomenMeasurement,
                "hipsMeasurement": self.model.hipsMeasurement,
                "waistFix": false,
                "lengthFix": false,
                "hipsFix": false,
                "barFix": false,
                "shoulderFix": false,
                "wristFix": false,
                "legFix": false,
                "totalValue": 0,
                "hiredDate": Date.now.formatted(),
                "imagesURLs": self.model.imagesURLs ?? []]
    }
    
}
