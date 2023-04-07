//
//  MALoginView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 26/02/23.
//

import SwiftUI

struct MALoginView: View {
    
    private let viewModel: MALoginViewModel = MALoginViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                credentialsView
                
                actionButtonsView
            }
            .padding(.horizontal, 30)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var backgroundView: some View {
        LinearGradient(colors: viewModel.backgroundColors,
                       startPoint: .leading,
                       endPoint: .trailing)
        .ignoresSafeArea()
    }
    
    var credentialsView: some View {
        Group {
            Image.MAImages.Login.loginTextLogo
            
            Image.MAImages.Login.loginTopImage
                .padding(.top, 28)
            
            TextField(viewModel.loginText, text: $login)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, -8)
            
            SecureField(viewModel.passwordText, text: $password)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                .textContentType(.password)
                .padding(.top, 14)
            
            Image.MAImages.Login.loginBottomImage
                .padding(.top, -6)
        }
    }
    
    var actionButtonsView: some View {
        Group {
            Button {
                viewModel.signInWith(networkManager, login: login, password: password)
            } label: {
                Text(viewModel.enterText)
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
            
            Button {
                networkManager.userHasAccount = false
            } label: {
                Text(viewModel.registerText)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .tint(.MAColors.MAPinkStrong)
                    .font(.system(size: 18, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            .foregroundColor(.white)
                    )
            }
        }
    }
    
}

struct MALoginView_Previews: PreviewProvider {
    static var previews: some View {
        MALoginView()
    }
}
