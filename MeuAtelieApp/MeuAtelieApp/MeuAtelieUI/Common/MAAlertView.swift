//
//  MAAlertView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAAlertView: View {
    
    var buttonMessage: String
    var buttonConfirmTitle: String = "SIM"
    var buttonCancelTitle: String = "Voltar"
    var confirmAction: (() -> ())? = nil
    var backAction: (() -> ())? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Image.MAImages.Login.loginTextLogo
            
            Text(buttonMessage)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.MAColors.MAPinkText)
                .multilineTextAlignment(.center)
            
            HStack {
                Button(buttonCancelTitle) {
                    backAction?()
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLightMedium,
                                                fontColor: .white))
                
                Button(buttonConfirmTitle) {
                    confirmAction?()
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                fontColor: .white))
            }
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

struct MAAlertView_Previews: PreviewProvider {
    static var previews: some View {
        MAAlertView(buttonMessage: "Deseja excluir?")
    }
}
