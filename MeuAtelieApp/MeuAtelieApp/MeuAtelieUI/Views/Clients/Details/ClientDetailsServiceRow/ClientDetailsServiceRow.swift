//
//  ClientDetailsServiceRow.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct ClientDetailsServiceRow: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.MAColors.MAImageGray)
                    .frame(width: 116, height: 113)
                
                Image.MAImages.Login.loginTopImage
                    .resizable()
                    .frame(width: 86, height: 89)
                    .padding(.top, 8)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Serviço: Roupa sob medida")
                    .font(.system(size: 16))
                
                Text("Peça: Vestido")
                    .font(.system(size: 16))
                
                Text("Contratado: 05/05/2023")
                    .font(.system(size: 16))
                
                Text("Finalizado: 15/06/2023")
                    .font(.system(size: 16))
                
                Text("Preço: R$ 767,90")
                    .font(.system(size: 16))
            }
        }
    }
    
}

struct ClientDetailsServiceRow_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailsServiceRow()
    }
}
