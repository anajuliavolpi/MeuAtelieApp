//
//  MANewOrder.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MANewOrder: View {
    @Environment(\.dismiss) var dismiss
    
    @State var clientName: String = ""
    @State var typeName: String = ""
    @State var dateOfDelivery: String = ""
    
    var body: some View {
        VStack {
            Text("Criar novo pedido")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
            
            TextField("Cliente", text: $clientName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            TextField("Tipo de peça", text: $typeName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            TextField("Data de Entrega", text: $dateOfDelivery)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkMediumLight,
                                                      foregroundTextColor: .black))
                .textContentType(.dateTime)
                .autocorrectionDisabled()
                .padding(.top, 16)
            
            Button {
                create(order: MAOrderModel(id: UUID().uuidString, clientName: self.clientName, typeName: self.typeName, dateOfDelivery: self.dateOfDelivery))
            } label: {
                Text("CRIAR")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .tint(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            .foregroundColor(.MAColors.MAPinkMedium)
                    )
            }
            .padding(.top, 30)
            
        }
        .padding(.horizontal, 30)
    }
    
    private func create(order: MAOrderModel) {
        let db = Firestore.firestore()
        let ref = db.collection("Orders").document(order.id)
        ref.setData(["clientName": self.clientName, "typeName": self.typeName, "dateOfDelivery": self.dateOfDelivery]) { error in
            if let error {
                print("some error occured on creating data for order: \(error)")
                return
            }
        }
        
        dismiss()
    }
    
}

struct MANewOrder_Previews: PreviewProvider {
    static var previews: some View {
        MANewOrder()
    }
}
