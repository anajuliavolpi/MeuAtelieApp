//
//  MANewPasswordView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI

struct MANewPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    private let viewModel: MANewPasswordViewModel = MANewPasswordViewModel()
    @State var newPassword: String = ""
    
    var body: some View {
        VStack {
            Text(viewModel.newPasswordText)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
            
            SecureField(viewModel.insertNewPasswordText, text: $newPassword)
                .textFieldStyle(MABasicTextFieldStyle(image: Image(systemName: "lock"),
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.password)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            Button(viewModel.changeText) {
                viewModel.changePasswordWithNew(password: newPassword, dismiss)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.top, 16)
        }
        .padding(.horizontal, 30)
    }
    
}

struct MANewPassword_Previews: PreviewProvider {
    static var previews: some View {
        MANewPasswordView()
    }
}
