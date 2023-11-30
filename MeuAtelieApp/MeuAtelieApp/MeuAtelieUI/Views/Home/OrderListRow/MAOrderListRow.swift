//
//  MAOrderListRow.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI

struct MAOrderListRow: View {
    
    var viewModel: MAOrderListRowViewModel
    var isFromCalendar: Bool = false
    var circleColor: Color = .clear
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                if let imageURL = viewModel.order.imagesURLs?.first {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .frame(width: 116, height: 113)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } placeholder: {
                        ProgressView()
                    }

                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.MAColors.MAImageGray)
                        .frame(width: 116, height: 113)
                    
                    Image.MAImages.Login.loginTopImage
                        .resizable()
                        .frame(width: 86, height: 89)
                        .padding(.top, 8)
                }
            }
            .overlay {
                if isFromCalendar {
                    Circle()
                        .fill(circleColor)
                        .frame(width: 20, height: 20)
                        .offset(x: 55, y: -53)
                }
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
                                                     status: .onGoing,
                                                     serviceType: .tailored,
                                                     client: MAClientModel(userId: "", id: "", fullName: "Ana Júlia", phone: "", email: ""),
                                                     cloathesName: "",
                                                     cloathesDescription: "",
                                                     estimatedDeliveryDate: "30/10/2023",
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
                                                     hiredDate: "",
                                                     deliveryDate: "27/10/2023")))
    }
}
