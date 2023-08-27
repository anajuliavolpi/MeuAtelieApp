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
    var backgroundColor: Color = .MAColors.MAPink
    var ignoreSafeArea: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                Text("Voltar")
                    .foregroundColor(.MAColors.MAPinkMedium)
                    .font(.system(size: 14))
            }
            .padding(.top, ignoreSafeArea ? 60 : 0)
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .light, design: .rounded))
                .padding(.top, 12)
            
            HStack {
                Text(subtext.uppercased())
                    .foregroundColor(.MAColors.MAPinkMedium)
                    .font(.system(size: 40, weight: .medium, design: .rounded))
                    .padding(.bottom, 16)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
        .background(
            Rectangle()
                .foregroundColor(backgroundColor)
        )
        .ignoresSafeArea(edges: ignoreSafeArea ? .top : .bottom) // Bottom will just not ignore any Edge of the SafeArea
    }
}

struct MAHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            MAHeaderView(text: "Adicionar", subtext: "novo pedido")
            Spacer()
        }
    }
}
