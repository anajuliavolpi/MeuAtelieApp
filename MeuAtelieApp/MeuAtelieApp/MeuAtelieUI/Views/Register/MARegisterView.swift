//
//  MARegisterView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MARegisterView: View {
    
    private let viewModel: MARegisterViewModel = MARegisterViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    var body: some View {
        ZStack {
            backgroundView
            
            ScrollView {
                VStack {
                    Text(viewModel.fillYourDataText)
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(.MAColors.MAPinkStrong)
                        .padding(.top, 16)
                    
                    Image.MAImages.Login.loginTopImage
                        .padding(.top, 16)
                    
                    formView
                    
                    Image.MAImages.Login.loginBottomImage
                        .padding(.top, -6)
                    
                    actionButtonView
                        .padding(.vertical, 20)
                }
                .padding(.horizontal, 30)
            }
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
    
    var formView: some View {
        Group {
            TextField(viewModel.emailText, text: $emailAddress)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill))
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
        Button {
            let model = MARegisterModel(emailAddress: self.emailAddress,
                                        password: self.password,
                                        firstName: self.firstName,
                                        lastName: self.lastName)
            viewModel.signUpWith(networkManager, and: model)
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        MARegisterView()
    }
}
