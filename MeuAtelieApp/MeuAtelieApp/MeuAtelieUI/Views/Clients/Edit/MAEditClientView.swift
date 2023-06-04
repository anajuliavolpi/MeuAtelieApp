//
//  MAEditClientView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAEditClientView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MAEditClientViewModel
    
    var body: some View {
        VStack {
            MAHeaderView(text: viewModel.editText, subtext: viewModel.clientText)
                .padding(.horizontal, -20)
            
            fieldsView
                .padding(.top, -30)
            
            Spacer()
            
            Button(viewModel.saveText) {
                viewModel.saveClient(dismiss)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 36)
        }
        .padding(.horizontal, 20)
        .addMALoading(state: viewModel.isLoading)
        .hideKeyboard()
    }
    
    var fieldsView: some View {
        VStack {
            TextField(viewModel.fullNameText, text: $viewModel.fullName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
            
            TextField(viewModel.phoneText, text: $viewModel.phone)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.phone,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .phonePad))
                .textContentType(.telephoneNumber)
                .padding(.top, 16)
        }
    }
    
}

struct MAEditClientView_Previews: PreviewProvider {
    static var previews: some View {
        MAEditClientView(viewModel: MAEditClientViewModel(clientID: ""))
    }
}
