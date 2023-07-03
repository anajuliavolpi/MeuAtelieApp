//
//  ClientDetailsServiceRow.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct ClientDetailsServiceRow: View {
    
    @State var model: MAOrderModel
    
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
                Text("Serviço: \(model.serviceType.rawValue)")
                    .font(.system(size: 16))
                
                Text("Peça: \(model.cloathesName)")
                    .font(.system(size: 16))
                
                Text("Contratado: \(model.hiredDate)")
                    .font(.system(size: 16))
                
                Text("Previsão: \(model.estimatedDeliveryDate)")
                    .font(.system(size: 16))
                
                Text("Preço: R$ \(String(format: "%.2f", model.totalValue))")
                    .font(.system(size: 16))
            }
        }
    }
    
}

struct ClientDetailsServiceRow_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailsServiceRow(model: .init(id: "",
                                             serviceType: .fixes,
                                             client: .init(id: "", fullName: "", phone: ""),
                                             cloathesName: "",
                                             cloathesDescription: "",
                                             estimatedDeliveryDate: "",
                                             shoulderMeasurement: 0,
                                             bustMeasurement: 0,
                                             lengthMeasurement: 0,
                                             waistMeasurement: 0,
                                             abdomenMeasurement: 0,
                                             hipsMeasurement: 0,
                                             waistFix: false,
                                             lengthFix: false,
                                             hipsFix: false,
                                             barFix: false,
                                             shoulderFix: false,
                                             wristFix: false,
                                             legFix: false,
                                             totalValue: 0.0,
                                             hiredDate: ""))
    }
}
