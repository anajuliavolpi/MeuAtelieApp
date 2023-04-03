//
//  MALoginView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 26/02/23.
//

import SwiftUI
import Firebase

struct MALoginView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
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
                
                Button {
                    self.signIn()
                } label: {
                    Text("ENTRAR")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .tint(.MAColors.MAPinkStrong)
                        .font(.system(size: 18, weight: .semibold))
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                .foregroundColor(.white)
                        )
                }
                .padding(.top, 20)
                                
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
    
    private func signIn() {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if let error {
                print(error)
                return
            }
            
            networkManager.isUserLoggedIn()
        }
    }
    
}

struct MALoginView_Previews: PreviewProvider {
    static var previews: some View {
        MALoginView()
    }
}
