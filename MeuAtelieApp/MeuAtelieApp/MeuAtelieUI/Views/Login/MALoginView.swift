//
//  MALoginView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 26/02/23.
//

import SwiftUI

struct MALoginView: View {
    
    @ObservedObject var viewModel: MALoginViewModel = MALoginViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                backgroundView
                
                VStack {
                    credentialsView
                    
                    actionButtonsView
                }
                .padding(.horizontal, 30)
            }
            .navigationDestination(for: MANavigationRoutes.LoginRoutes.self) { path in
                switch path {
                case .register:
                    MARegisterView()
                        .environmentObject(networkManager)
                        .toolbar(.hidden)
                }
            }
            .addMALoading(state: viewModel.isLoading)
            .addMAError(state: viewModel.isShowingError,
                        message: viewModel.errorMessage,
                        action: {
                viewModel.isShowingError = false
            })
            .hideKeyboard()
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
            
            TextField(viewModel.strings.loginText, text: $viewModel.textFields.login)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      keyboard: .emailAddress))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, -8)
            
            SecureField(viewModel.strings.passwordText, text: $viewModel.textFields.password)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                .textContentType(.password)
                .padding(.top, 14)
            
            Image.MAImages.Login.loginBottomImage
                .padding(.top, -6)
        }
    }
    
    var actionButtonsView: some View {
        Group {
            Button(viewModel.strings.enterText) {
                Task {
                    await viewModel.signIn(networkManager)
                    viewModel.isLoading = false
                }
            }
            .buttonStyle(MABasicButtonStyle())
            .padding(.top, 20)
            
            Button(viewModel.strings.registerText) {
                viewModel.navigationPath.append(MANavigationRoutes.LoginRoutes.register)
            }
            .buttonStyle(MABasicButtonStyle())
        }
    }
    
}

struct MALoginView_Previews: PreviewProvider {
    static var previews: some View {
        MALoginView()
    }
}
