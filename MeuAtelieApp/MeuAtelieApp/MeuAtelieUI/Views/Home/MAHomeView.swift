//
//  MAHomeView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 27/02/23.
//

import SwiftUI

struct MAHomeView: View {
    
    @ObservedObject var viewModel: MAHomeViewModel = MAHomeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.orders, id: \.id) { order in
                VStack(alignment: .leading) {
                    Text("Cliente: \(order.clientName)")
                    Text("Tipo de peça: \(order.typeName)")
                    Text("Data: \(order.dateOfDelivery)")
                    
                    Button {
                        viewModel.deleteOrderWith(id: order.id)
                    } label: {
                        Text("Deletar pedido")
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .tint(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .background(
                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                    .foregroundColor(.MAColors.MAPinkMedium)
                            )
                    }
                }
            }
            .navigationTitle(viewModel.viewTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingCreateNewOrder.toggle()
                    } label: {
                        Text(viewModel.navBarText)
                    }

                }
            }
        }
        .sheet(isPresented: $viewModel.showingCreateNewOrder, onDismiss: {
            viewModel.fetchOrders()
        }) {
            MANewOrder()
        }
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView()
    }
}
