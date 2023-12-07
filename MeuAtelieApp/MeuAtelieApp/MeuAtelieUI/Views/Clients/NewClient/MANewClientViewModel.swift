//
//  MANewClientViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Firebase
import Contacts
import FirebaseStorage

final class MANewClientViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var contacts: [CNContact] = []
    @Published var showError: Bool = false
    @Published var clientFullName: String = ""
    @Published var clientPhone: String = ""
    @Published var clientEmail: String = ""
    @Published var userImage: Image?
    @Published var uiImage: UIImage?
    
    let createText: String = "Adicionar"
    let newClientText: String = "novo cliente"
    let fullNameText: String = "Nome completo"
    let phoneText: String = "Telefone"
    let emailText: String = "Email"
    var createActionText: String = "CADASTRAR"
    let importClientActionText: String = "IMPORTAR CLIENTE"
    let backText: String = "Voltar"
    
    var model: MAClientModel?
    
    init(model: MAClientModel? = nil) {
        self.model = model
        
        if let model {
            // We are in editing mode
            clientFullName = model.fullName
            clientPhone = model.phone
            clientEmail = model.email
            
            // Try to get user image
            Task {
                await getUserImage(with: model.imageURL ?? "")
            }
            
            self.createActionText = "ATUALIZAR"
        }
    }
    
    @MainActor func new(client: MAClientModel, image: UIImage) async throws {
        self.isLoading = true
        self.model = client
        
        self.model?.imageURL = await upload(image)
        
        do {
            try await create()
        } catch {
            print("Some error ocurred while trying to create new client: \(error)")
            self.showError = true
            throw error
        }
    }
    
    private func upload(_ image: UIImage) async -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return "" }
        
        let ref = Storage.storage().reference()
        let fileRef = ref.child("clients/\(UUID().uuidString).jpg")
        
        do {
            let _ = try await fileRef.putDataAsync(imageData)
            let url = try await fileRef.downloadURL()
            return url.absoluteString
        } catch {
            print("Some error occured: \(error)")
            self.showError = true
            return ""
        }
    }
    
    private func create() async throws {
        guard let model else { return }
        let db = Firestore.firestore()
        let ref = db.collection("Clients").document(model.id)
        
        do {
            try await ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                                   "fullname": model.fullName,
                                   "phone": model.phone,
                                   "email": model.email,
                                   "imageURL": model.imageURL ?? ""])
        } catch {
            throw error
        }
    }
    
    @MainActor func fetchContacts() async {
        self.contacts.removeAll()
        
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: fetchRequest) { contact, result in
                self.contacts.append(contact)
            }
        } catch {
            print("some error: \(error)")
        }
    }
    
    @MainActor private func getUserImage(with url: String) async {
        guard let url = URL(string: url) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.uiImage = UIImage(data: data)
            self.userImage = Image(uiImage: self.uiImage!) // Should not crash - at least in theory
        } catch {
            print("Some error: \(error)")
        }
    }
    
}
