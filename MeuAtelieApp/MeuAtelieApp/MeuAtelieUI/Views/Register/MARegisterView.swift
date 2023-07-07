//
//  MARegisterView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI

struct MARegisterView: View {
    
    @ObservedObject var viewModel: MARegisterViewModel = MARegisterViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                ScrollView {
                    VStack {
                        MAHeaderView(text: "Preencha",
                                     subtext: "SEUS DADOS",
                                     backgroundColor: .clear,
                                     ignoreSafeArea: false)
                            .padding(.horizontal, -30)
                        
                        Image.MAImages.Login.loginTopImage
                        
                        formView
                        
                        Image.MAImages.Login.loginBottomImage
                            .padding(.top, -6)
                        
                        actionButtonView
                            .padding(.vertical, 20)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .addMALoading(state: viewModel.isLoading)
        .hideKeyboard()
    }
    
    var backgroundView: some View {
        LinearGradient(colors: viewModel.backgroundColors,
                       startPoint: .leading,
                       endPoint: .trailing)
        
        .ignoresSafeArea()
    }
    
    var formView: some View {
        Group {
            TextField(viewModel.emailText, text: $emailAddress)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      keyboard: .emailAddress))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, -8)
            
            SecureField(viewModel.passwordText, text: $password)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                .textContentType(.password)
                .padding(.top, 14)
            
            TextField(viewModel.firstNameText, text: $firstName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 14)
            
            TextField(viewModel.lastNameText, text: $lastName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 14)
        }
    }
    
    var actionButtonView: some View {
        Button(viewModel.registerText) {
            let model = MARegisterModel(emailAddress: self.emailAddress,
                                        password: self.password,
                                        firstName: self.firstName,
                                        lastName: self.lastName)
            viewModel.signUpWith(networkManager, and: model)
        }
        .buttonStyle(MABasicButtonStyle())
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        MARegisterView()
    }
}
