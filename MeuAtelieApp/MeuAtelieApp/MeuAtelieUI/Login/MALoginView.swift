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
            Color("MAPink")
                .ignoresSafeArea()
            
            VStack {
                Image("MeuAtelieLaunchscreen")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding(.top, 100)
                
                Text("MeuAteliê")
                    .font(.system(size: 24))
                    .padding(.trailing, -50)
                    .padding(.top, -20)
                
                TextField("Login", text: $login)
                    .font(.system(size: 18, weight: .semibold))
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .padding(.top, 40)
                
                SecureField("Senha", text: $password)
                    .font(.system(size: 18, weight: .semibold))
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)
                
                Spacer()
                
                Button("Entrar") {
                    userLogIn = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 20)
        }
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
