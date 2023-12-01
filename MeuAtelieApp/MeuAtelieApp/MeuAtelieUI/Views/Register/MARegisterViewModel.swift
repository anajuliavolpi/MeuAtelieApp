//
//  MARegisterViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

enum RegisterError: Error {
    case errorTransformingToData
    case someUploadError(error: Error)
}

final class MARegisterViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    
    let backgroundColors: [Color] = [.MAColors.MAPinkLightStrong,
                                     .MAColors.MAPinkLight,
                                     .MAColors.MAPinkLightMedium]
    let fillYourDataText: String = "Preencha seus dados"
    let emailText: String = "Email"
    let passwordText: String = "Senha"
    let firstNameText: String = "Primeiro nome"
    let lastNameText: String = "Último nome"
    let registerText: String = "CADASTRAR"
    
    private var model: MARegisterModel?
    
    @MainActor func createUser(_ networkManager: NetworkManager, model: MARegisterModel, image: UIImage) async {
        self.isLoading = true
        self.model = model
        
        do {
            self.model?.imageURL = try await upload(image)
            try await createUser()
            try await saveUserOnDB()
            
            self.isLoading = false
            networkManager.isUserLoggedIn()
        } catch RegisterError.errorTransformingToData {
            print("Error on trying to transform UIImage to Data")
            self.showError = true
            self.isLoading = false
        } catch RegisterError.someUploadError(let error) {
            print("Upload error: \(error)")
            self.showError = true
            self.isLoading = false
        } catch {
            print("Generic error: \(error)")
            self.showError = true
            self.isLoading = false
        }
    }
    
    private func upload(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            throw RegisterError.errorTransformingToData
        }
        
        let ref = Storage.storage().reference()
        let fileRef = ref.child("userImages/\(UUID().uuidString).jpg")
        
        do {
            let _ = try await fileRef.putDataAsync(imageData)
            let url = try await fileRef.downloadURL()
            return url.absoluteString
        } catch {
            print("Some error while trying to upload profile pic: \(error)")
            throw RegisterError.someUploadError(error: error)
        }
    }
    
    private func createUser() async throws {
        guard let model else { return }
        
        do {
            try await Auth.auth().createUser(withEmail: model.emailAddress, password: model.password)
        } catch {
            print("Some error when trying to create user: \(error)")
            throw RegisterError.someUploadError(error: error)
        }
    }
    
    private func saveUserOnDB() async throws {
        guard let model else { return }
        
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
        
        do {
            try await ref.setData(["name": model.firstName,
                                   "lastname": model.lastName,
                                   "imageURL": model.imageURL ?? ""])
        } catch {
            print("Some error ocurred while trying to save user to DB: \(error)")
            throw RegisterError.someUploadError(error: error)
        }
    }
    
}
