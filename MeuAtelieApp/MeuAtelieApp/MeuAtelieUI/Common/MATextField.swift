//
//  MATextField.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 28/02/23.
//

import SwiftUI

// MARK: - We use this MATextField View just to Preview the different TextField styles
struct MATextField: View {
    
    @State private var login: String = ""
    
    var body: some View {
        ZStack {
            Color.MAColors.MAPink
            
            VStack(spacing: 10) {
                TextField("Login", text: $login)
                    .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill))
                    .padding()
                
                SecureField("Password", text: $login)
                    .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                    .padding()
                
                TextField("RandomText", text: $login)
                    .textFieldStyle(MABasicTextFieldStyle())
                    .padding()
            }
        }
        .ignoresSafeArea()
    }
    
}

// MARK: - Custom TextFields
struct MABasicTextFieldStyle: TextFieldStyle {
    
    var image: Image? = nil
    var backgroundColor: Color = .white
    var foregroundTextColor: Color = .MAColors.MAPinkText
    var keyboard: UIKeyboardType = .default
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            configuration
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(foregroundTextColor)
                .keyboardType(keyboard)
                .padding()
            
            image
                .padding()
                .foregroundColor(Color.MAColors.MAPinkText)
        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(height: 50)
    }
    
}

struct MATextField_Previews: PreviewProvider {
    static var previews: some View {
        MATextField()
    }
}
