//
//  MAOrderListRow.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI

struct MAOrderListRow: View {
    
    var viewModel: MAOrderListRowViewModel
    
    var body: some View {
        HStack(spacing: 20) {
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
                Text(viewModel.order.client.fullName)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                Text(viewModel.serviceType)
                    .font(.system(size: 18, design: .rounded))
                
                Text(viewModel.dateText)
                    .font(.system(size: 18, design: .rounded))
            }
        }
    }
    
}

struct MAOrderListRow_Previews: PreviewProvider {
    static var previews: some View {
        MAOrderListRow(viewModel: .init(order: .init(id: UUID().uuidString,
                                                     serviceType: .tailored,
                                                     client: MAClientModel(id: "", fullName: "", phone: ""),
                                                     cloathesName: "",
                                                     cloathesDescription: "",
                                                     estimatedDeliveryDate: "",
                                                     shoulderMeasurement: 0,
                                                     bustMeasurement: 0,
                                                     lengthMeasurement: 0,
                                                     waistMeasurement: 0,
                                                     abdomenMeasurement: 0,
                                                     hipsMeasurement: 0)))
    }
}
