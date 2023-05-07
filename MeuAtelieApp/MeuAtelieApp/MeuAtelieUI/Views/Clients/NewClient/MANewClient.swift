//
//  MANewClient.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI

struct MANewClient: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel = MANewClientViewModel()
    @State var clientFullName: String = ""
    @State var clientPhone: String = ""
    @State var showImportClientAlert: Bool = false
    
    var body: some View {
        VStack {
            MAHeaderView(text: "Adicionar",
                         subtext: "novo cliente")
            .padding(.horizontal, -20)
            
            TextField(viewModel.fullNameText, text: $clientFullName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
                .padding(.top, -30)
            
            TextField(viewModel.phoneText, text: $clientPhone)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.phone,
                                                      backgroundColor: .MAColors.MAPinkLight,
                                                      foregroundTextColor: .black,
                                                      keyboard: .phonePad))
                .textContentType(.telephoneNumber)
                .padding(.top, 16)
            
            Spacer()
            
            Button("IMPORTAR CLIENTE") {
                showImportClientAlert = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                            fontColor: .white))
            .padding(.bottom, 8)
            
            Button(viewModel.createActionText) {
                viewModel.createClient(with: MAClientModel(id: UUID().uuidString,
                                                           fullName: clientFullName,
                                                           phone: clientPhone),
                                       dismiss)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .hideKeyboard()
        .addMALoading(state: viewModel.isLoading)
        .addMAError(state: showImportClientAlert, message: "Work in progress...") {
            showImportClientAlert = false
        }
    }
    
}

struct MANewClient_Previews: PreviewProvider {
    static var previews: some View {
        MANewClient()
    }
}
