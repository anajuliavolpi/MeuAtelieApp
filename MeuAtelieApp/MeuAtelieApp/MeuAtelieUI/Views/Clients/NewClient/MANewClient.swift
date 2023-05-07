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
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.MAColors.MAPink)
                    .frame(height: 200)
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text(viewModel.backText)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(viewModel.createText)
                        Spacer()
                    }
                    .padding(.top, 18)
                    
                    HStack {
                        Text(viewModel.newClientText)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                        Spacer()
                    }
                }
                .font(.system(size: 28, weight: .light, design: .rounded))
                .padding(.leading, 30)
                .padding(.top, 50)
            }
            .padding(.horizontal, -20)
            .ignoresSafeArea()
            
            TextField(viewModel.fullNameText, text: $clientFullName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
                .padding(.top, 18)
            
            TextField(viewModel.phoneText, text: $clientPhone)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.phone,
                                                      backgroundColor: .MAColors.MAPinkLight,
                                                      foregroundTextColor: .black,
                                                      keyboard: .phonePad))
                .textContentType(.telephoneNumber)
                .padding(.top, 16)
            
            Spacer()
            
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
    }
    
}

struct MANewClient_Previews: PreviewProvider {
    static var previews: some View {
        MANewClient()
    }
}
