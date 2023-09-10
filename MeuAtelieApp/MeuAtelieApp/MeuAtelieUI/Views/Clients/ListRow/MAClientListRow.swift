//
//  MAClientListRow.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAClientListRow: View {
    
    var clientImage: Image = Image.MAImages.Login.loginTopImage
    var clientName: String
    var clientPhone: String
    var clientEmail: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ZStack {
                Circle()
                    .foregroundColor(.MAColors.MAImageGray)
                    .frame(width: 70, height: 70)
                
                clientImage
                    .resizable()
                    .frame(width: 53, height: 58)
                    .padding(.top, 8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(clientName)
                    .font(.system(size: 20, weight: .semibold))
                
                Text("Telefone: \(clientPhone)")
                    .font(.system(size: 14))
                
                Text("Email: \(clientEmail)")
                    .font(.system(size: 14))
            }
        }
    }
    
}

struct MAClientListRow_Previews: PreviewProvider {
    static var previews: some View {
        MAClientListRow(clientName: "Ana Júlia Volpi",
                        clientPhone: "47 9 9603 1059",
                        clientEmail: "anajuliavolpi45@gmail.com")
    }
}
