//
//  MAHeaderView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    
    var text: String
    var subtext: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.MAColors.MAPink)
                .frame(height: 250)
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Voltar")
                            .foregroundColor(.MAColors.MAPinkMedium)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .light, design: .rounded))
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                HStack {
                    Text(subtext.uppercased())
                        .foregroundColor(.MAColors.MAPinkMedium)
                        .font(.system(size: 40, weight: .medium, design: .rounded))
                    
                    Spacer()
                }
            }
            .padding(.leading, 30)
            .padding(.top, 50)
        }
        .ignoresSafeArea()
    }
}

struct MAHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MAHeaderView(text: "Adicionar", subtext: "novo pedido")
    }
}
