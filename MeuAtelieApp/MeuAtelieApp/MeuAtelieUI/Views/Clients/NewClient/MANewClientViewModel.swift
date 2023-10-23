//
//  MANewClientViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Firebase
import Contacts

final class MANewClientViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var contacts: [CNContact] = []
    
    let createText: String = "Adicionar"
    let newClientText: String = "novo cliente"
    let fullNameText: String = "Nome completo"
    let phoneText: String = "Telefone"
    let emailText: String = "Email"
    let createActionText: String = "CADASTRAR"
    let importClientActionText: String = "IMPORTAR CLIENTE"
    let backText: String = "Voltar"
    
    func createClient(with client: MAClientModel, _ dismiss: DismissAction) {
        isLoading = true
        let db = Firestore.firestore()
        let ref = db.collection("Clients").document(client.id)
        
        ref.setData(["userId": Auth.auth().currentUser?.uid ?? "",
                     "fullname": client.fullName,
                     "phone": client.phone,
                     "email": client.email]) { error in
            self.isLoading = false
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
            
            dismiss()
        }
    }
    
    func fetchContacts() async {
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
