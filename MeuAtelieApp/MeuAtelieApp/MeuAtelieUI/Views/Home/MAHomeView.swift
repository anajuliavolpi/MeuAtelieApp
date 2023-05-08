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
                MAOrderListRow(viewModel: MAOrderListRowViewModel(order: order, action: {
                    viewModel.deleteOrderWith(id: order.id)
                }))
            }
            .navigationTitle(viewModel.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
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
        .addMALoading(state: viewModel.isLoading)
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
