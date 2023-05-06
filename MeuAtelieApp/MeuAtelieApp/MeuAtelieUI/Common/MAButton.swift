//
//  MAButton.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/04/23.
//

import SwiftUI

// MARK: - We use this MABUtton View just to Preview the different Button styles
struct MAButton: View {
    
    var body: some View {
        ZStack {
            Color.MAColors.MAPink
            
            VStack(spacing: 10) {
                Button("ENTRAR") {
                    print(#function)
                }
                .buttonStyle(MABasicButtonStyle())
                
                Button("ENTRAR") {
                    print(#function)
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .black))
                
                Button("ENTRAR") {
                    print(#function)
                }
                .buttonStyle(MABasicButtonStyle(fontColor: .black))
            }
        }
    }
    
}

// MARK: - Custom Buttons
struct MABasicButtonStyle: ButtonStyle {
    
    var backgroundColor: Color = .white
    var fontColor: Color = .MAColors.MAPinkStrong
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundColor(fontColor)
            .font(.system(size: 18, weight: .semibold))
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .foregroundColor(backgroundColor)
            )
    }
    
}

struct MAButton_Previews: PreviewProvider {
    static var previews: some View {
        MAButton()
    }
}
