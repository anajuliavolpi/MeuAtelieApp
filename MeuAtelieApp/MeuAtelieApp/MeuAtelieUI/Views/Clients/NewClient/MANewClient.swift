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
            MAImportClientsView(contacts: viewModel.contacts,
                                clientFullName: self.$clientFullName,
                                clientPhone: self.$clientPhone,
                                clientEmail: self.$clientEmail,
                                showImportClientSheet: self.$showImportClientSheet)
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

struct MANewClient_Previews: PreviewProvider {
    static var previews: some View {
        MANewClient()
    }
}
