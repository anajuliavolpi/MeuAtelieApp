//
//  MANewClient.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Contacts

struct MANewClient: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel = MANewClientViewModel()
    @State var clientFullName: String = ""
    @State var clientPhone: String = ""
    @State var clientEmail: String = ""
    @State var showImportClientSheet: Bool = false
    
    var body: some View {
        VStack {
            MAHeaderView(text: viewModel.createText,
                         subtext: viewModel.newClientText)
            .padding(.horizontal, -20)
            
            fieldsView
                .padding(.top, -30)
            
            Spacer()
            
            buttonsView
                .padding(.bottom, 8)
        }
        .padding(.horizontal, 20)
        .hideKeyboard()
        .addMALoading(state: viewModel.isLoading)
        .sheet(isPresented: $showImportClientSheet) {
            VStack {
                MAHeaderView(text: "Importar",
                             subtext: "CONTATO")
                
                List($viewModel.contacts, id: \.self) { contact in
                    MAClientListRow(clientName: "\(getFirstName(of: contact.wrappedValue)) \(getLastName(of: contact.wrappedValue))",
                                    clientPhone: getPhoneNumber(of: contact.wrappedValue),
                                    clientEmail: getEmailAddress(of: contact.wrappedValue))
                    .padding()
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in return 0 })
                    .listRowInsets(EdgeInsets())
                    .padding(.trailing, 18)
                    .onTapGesture {
                        self.clientFullName = "\(getFirstName(of: contact.wrappedValue)) \(getLastName(of: contact.wrappedValue))"
                        self.clientPhone = getPhoneNumber(of: contact.wrappedValue)
                        self.clientEmail = getEmailAddress(of: contact.wrappedValue)
                        
                        showImportClientSheet = false
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var fieldsView: some View {
        VStack {
            TextField(viewModel.fullNameText, text: $clientFullName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
            
            TextField(viewModel.phoneText, text: $clientPhone)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.phone,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .phonePad))
                .textContentType(.telephoneNumber)
                .padding(.top, 16)
            
            TextField(viewModel.emailText, text: $clientEmail)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.email,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .emailAddress))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, 16)
        }
    }
    
    var buttonsView: some View {
        VStack {
            Button(viewModel.importClientActionText) {
                Task {
                    await viewModel.fetchContacts()
                    self.showImportClientSheet = true
                }
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                            fontColor: .white))
            
            Button(viewModel.createActionText) {
                viewModel.createClient(with: MAClientModel(userId: "",
                                                           id: UUID().uuidString,
                                                           fullName: clientFullName,
                                                           phone: clientPhone,
                                                           email: clientEmail),
                                       dismiss)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 40)
        }
    }
    
}

// MARK: - Format contact information
extension MANewClient {
    
    func getFirstName(of contact: CNContact) -> String {
        return contact.givenName
    }
    
    func getLastName(of contact: CNContact) -> String {
        return contact.familyName
    }
    
    func getPhoneNumber(of contact: CNContact) -> String {
        return contact.phoneNumbers.first?.value.stringValue ?? "N/A"
    }
    
    func getEmailAddress(of contact: CNContact) -> String {
        return contact.emailAddresses.first?.value.lowercased ?? "N/A"
    }
    
}

struct MANewClient_Previews: PreviewProvider {
    static var previews: some View {
        MANewClient()
    }
}
