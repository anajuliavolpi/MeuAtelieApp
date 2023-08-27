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
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.orders, id: \.id) { order in
                MAOrderListRow(viewModel: MAOrderListRowViewModel(order: order))
                    .padding()
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in return 0 })
                    .listRowInsets(EdgeInsets())
                    .padding(.trailing, 18)
                    .onTapGesture {
                        viewModel.navigationPath.append(MANavigationRoutes.HomeRoutes.orderDetails(order: order))
                    }
            }
            .navigationTitle(viewModel.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.navigationPath.append(MANavigationRoutes.HomeRoutes.newOrder)
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
            .navigationDestination(for: MANavigationRoutes.HomeRoutes.self) { path in
                switch path {
                case .orderDetails(let order):
                    MAOrderDetailsView(viewModel: MAOrderDetailsViewModel(orderID: order.id), path: $viewModel.navigationPath)
                        .toolbar(.hidden)
                case .editOrder(let order):
                    if order.serviceType == .fixes {
                        MAFixesOrderFlowView(viewModel: .init(order, pieces: 1, path: $viewModel.navigationPath, editing: true))
                            .toolbar(.hidden)
                    } else {
                        MATailoredOrderFlowView(viewModel: .init(order), path: $viewModel.navigationPath)
                            .toolbar(.hidden)
                    }
                case .newOrder:
                    MANewOrder(path: $viewModel.navigationPath)
                        .toolbar(.hidden)
                case .newTailored(let order):
                    MATailoredOrderFlowView(viewModel: .init(order), path: $viewModel.navigationPath)
                        .toolbar(.hidden)
                case .newFixes(let order, let pieces):
                    MAFixesOrderFlowView(viewModel: .init(order, pieces: pieces, path: $viewModel.navigationPath))
                        .toolbar(.hidden)
                case .tailoredFlowMeasurements(let order):
                    MATailoredOrderFlowMeasurementsView(viewModel: .init(order, path: $viewModel.navigationPath))
                        .toolbar(.hidden)
                }
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
