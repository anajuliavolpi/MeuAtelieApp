//
//  MANewPassword.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MANewPassword: View {
    @Environment(\.dismiss) var dismiss
    
    @State var newPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Escolher nova senha")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
            
            SecureField("Insira a nova senha", text: $newPassword)
                .textFieldStyle(MABasicTextFieldStyle(image: Image(systemName: "lock"),
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.password)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            Button {
                changePassword()
            } label: {
                Text("TROCAR")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .tint(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            .foregroundColor(.MAColors.MAPinkMedium)
                    )
            }
            .padding(.top, 16)
            
        }
        .padding(.horizontal, 30)
    }
    
    private func changePassword() {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error {
                print("some error ocurred when changing password: \(error)")
                return
            }
            
            dismiss()
        }
    }
    
}

struct MANewPassword_Previews: PreviewProvider {
    static var previews: some View {
        MANewPassword()
    }
}
