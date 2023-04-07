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
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.clientText)
                Text(viewModel.typeText)
                Text(viewModel.dateText)
            }
            
            Spacer()
            
            Button(viewModel.deleteText) {
                viewModel.action()
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkStrong,
                                            fontColor: .white))
            .frame(width: 90)
        }
    }
    
}

struct MAOrderListRow_Previews: PreviewProvider {
    static var previews: some View {
        MAOrderListRow(viewModel:
                        MAOrderListRowViewModel(order: MAOrderModel(id: "123456",
                                                                    clientName: "Nivaldo da Silva",
                                                                    typeName: "Calça Jeans",
                                                                    dateOfDelivery: "08/05/2023"),
                                                action: {
            print(#function)
        }))
    }
}
