//
//  MANewOrder.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI

struct MANewOrder: View {
    @Environment(\.dismiss) var dismiss
    
    private let viewModel: MANewOrderViewModel = MANewOrderViewModel()
    @State var clientName: String = ""
    @State var typeName: String = ""
    @State var dateOfDelivery: String = ""
    
    var body: some View {
        VStack {
            Text(viewModel.createNewOrderText)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
            
            TextField(viewModel.clientText, text: $clientName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            TextField(viewModel.typeText, text: $typeName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            TextField(viewModel.deliveryDateText, text: $dateOfDelivery)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.dateTime)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            Button(viewModel.createText) {
                viewModel.create(order: MAOrderModel(id: UUID().uuidString,
                                                     clientName: self.clientName,
                                                     typeName: self.typeName,
                                                     dateOfDelivery: self.dateOfDelivery),
                                 dismiss)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.top, 30)
        }
        .padding(.horizontal, 30)
    }
    
}

struct MANewOrder_Previews: PreviewProvider {
    static var previews: some View {
        MANewOrder()
    }
}
