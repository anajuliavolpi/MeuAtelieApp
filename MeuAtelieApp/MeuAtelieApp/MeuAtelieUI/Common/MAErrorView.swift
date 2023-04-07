//
//  MAErrorView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI

struct MAErrorView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image.MAImages.Login.loginTextLogo
            
            Text("Ocorreu um erro:")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.MAColors.MAPinkText)
            
            Text("Info do error aqui!")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.MAColors.MAPinkText)
            
            Button("OK") {
                print(#function)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .overlay(content: {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.MAColors.MAPinkStrong, lineWidth: 5)
        })
        .padding()
    }
    
}

struct MAErrorView_Previews: PreviewProvider {
    static var previews: some View {
        MAErrorView()
    }
}
