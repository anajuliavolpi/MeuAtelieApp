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
                NavigationLink {
                    MAOrderDetailsView(viewModel: MAOrderDetailsViewModel(orderID: order.id))
                        .toolbar(.hidden)
                } label: {
                    MAOrderListRow(viewModel: MAOrderListRowViewModel(order: order))
                        .padding()
                }
                .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in
                    return 0
                })
                .listRowInsets(EdgeInsets())
                .padding(.trailing, 18)
            }
            .navigationTitle(viewModel.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MANewOrder()
                            .toolbar(.hidden)
                    } label: {
                        Image(systemName: "note.text.badge.plus")
                    }
                }
            }
            .overlay {
                if viewModel.orders.isEmpty {
                    VStack {
                        Text("OPS  ;(")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 34, weight: .semibold, design: .rounded))
                            .padding(.top, 90)
                        
                        Text("Você não possui\npedidos cadastrados")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 30)
                        
                        Spacer(minLength: 40)
                        
                        Image.MAImages.Login.loginTopImage
                            .resizable()
                            .opacity(0.45)
                    }
                }
            }
            .onAppear {
                viewModel.fetchOrders()
            }
        }
        .addMALoading(state: viewModel.isLoading)
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView()
    }
}
