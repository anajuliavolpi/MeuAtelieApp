//
//  MANewPasswordView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI

struct MANewPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: MANewPasswordViewModel = MANewPasswordViewModel()
    @State var newPassword: String = ""
    @State var showConfirmationAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            MAHeaderView(text: viewModel.changePasswordText,
                         subtext: viewModel.changePasswordSubtext)
            .padding(.horizontal, -30)
            
            Text(viewModel.insertNewPasswordText)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            SecureField(viewModel.newPasswordText, text: $newPassword)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textContentType(.password)
                .autocorrectionDisabled()
                .padding(.top, 8)
            
            Spacer()
            
            Button(viewModel.cancelText) {
                dismiss()
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                            fontColor: .white))
            
            Button(viewModel.changeText) {
                showConfirmationAlert = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 30)
        .addMALoading(state: viewModel.isLoading)
        .hideKeyboard()
        .addMAAlert(state: showConfirmationAlert, message: viewModel.confirmationAlertText) {
            viewModel.change(password: newPassword, dismiss)
            showConfirmationAlert = false
        } backAction: {
            showConfirmationAlert = false
        }
        .addMAError(state: viewModel.showErrorAlert, message: viewModel.errorMessage) {
            viewModel.showErrorAlert = false
        }

    }
    
}

struct MANewPassword_Previews: PreviewProvider {
    static var previews: some View {
        MANewPasswordView()
    }
}
