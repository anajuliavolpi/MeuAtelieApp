//
//  MARegisterView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MARegisterView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.MAColors.MAPinkLightStrong,
                                    .MAColors.MAPinkLight,
                                    .MAColors.MAPinkLightMedium],
                           startPoint: .leading,
                           endPoint: .trailing)
            
            .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Preencha seus dados")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(.MAColors.MAPinkStrong)
                        .padding(.top, 16)
                    
                    Image.MAImages.Login.loginTopImage
                        .padding(.top, 16)
                    
                    TextField("E-mail", text: $emailAddress)
                        .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill))
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled()
                        .padding(.top, -8)
                    
                    SecureField("Senha", text: $password)
                        .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                        .textContentType(.password)
                        .padding(.top, 14)
                    
                    TextField("Primeiro nome", text: $firstName)
                        .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                        .textContentType(.name)
                        .padding(.top, 14)
                    
                    TextField("Último nome", text: $lastName)
                        .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                        .textContentType(.name)
                        .padding(.top, 14)
                    
                    Image.MAImages.Login.loginBottomImage
                        .padding(.top, -6)
                    
                    Button {
                        self.signUp()
                    } label: {
                        Text("CADASTRAR")
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .tint(.MAColors.MAPinkStrong)
                            .font(.system(size: 18, weight: .semibold))
                            .background(
                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 30)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error {
                print("some error occured on user sign up: \(error)")
                return
            }
            
            let db = Firestore.firestore()
            let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            ref.setData(["name": self.firstName, "lastname": self.lastName]) { error in
                if let error {
                    print("some error occured on creating data for user: \(error)")
                    return
                }
            }
            
            networkManager.isUserLoggedIn()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        MARegisterView()
    }
}
