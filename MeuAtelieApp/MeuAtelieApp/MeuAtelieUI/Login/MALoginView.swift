//
//  MALoginView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 26/02/23.
//

import SwiftUI

struct MALoginView: View {
    
    @Binding var userLogIn: Bool
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.MAColors.MAPinkLightStrong,
                                    .MAColors.MAPinkLight,
                                    .MAColors.MAPinkLightMedium],
                           startPoint: .leading,
                           endPoint: .trailing)
            
            VStack {
                Image.MAImages.Login.loginTextLogo
                    .padding(.top, 50)
                
                Image.MAImages.Login.loginTopImage
                    .padding(.top, 28)
                
                TextField("Login", text: $login)
                    .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill))
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .padding(.top, -8)
                
                SecureField("Senha", text: $password)
                    .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                    .textContentType(.password)
                    .padding(.top, 14)
                
                Image.MAImages.Login.loginBottomImage
                    .padding(.top, -6)
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}

struct MALoginView_Previews: PreviewProvider {
    static var previews: some View {
        MALoginView(userLogIn: .constant(false))
    }
}
