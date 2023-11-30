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
    
    let createText: String = "Adicionar"
    let newClientText: String = "novo cliente"
    let fullNameText: String = "Nome completo"
    let phoneText: String = "Telefone"
    let emailText: String = "Email"
    let createActionText: String = "CADASTRAR"
    let importClientActionText: String = "IMPORTAR CLIENTE"
    let backText: String = "Voltar"
    
    private var model: MAClientModel?
    
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
    
    func fetchContacts() async {
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
    
}
