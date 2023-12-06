//
//  MAHomeView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 27/02/23.
//

import SwiftUI
import Combine

struct MAHomeView: View {
    
    @ObservedObject var viewModel: MAHomeViewModel = .init()
    @State private var textToSearch: String = ""
    @State private var filterStatus: OrderStatus? = nil
    
    var searchResults: [MAOrderModel] {
        if textToSearch.isEmpty {
            if let status = filterStatus {
                return viewModel.orders.filter({$0.status == status})
            } else {
                return viewModel.orders
            }
        } else {
            return filteredList(with: textToSearch)
        }
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(self.searchResults, id: \.id) { order in
                MAOrderListRow(viewModel: MAOrderListRowViewModel(order: order))
                    .padding()
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in return 0 })
                    .listRowInsets(EdgeInsets())
                    .padding(.trailing, 18)
                    .onTapGesture {
                        viewModel.navigationPath.append(MANavigationRoutes.HomeRoutes.orderDetails(order: order))
                    }
            }
            .searchable(text: $textToSearch)
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("Em progresso") {
                            self.filterStatus = .onGoing
                        }
                        
                        Button("Finalizados") {
                            self.filterStatus = .completed
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .overlay {
                if searchResults.isEmpty {
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
                case .tailoredFlowMeasurements(let order, let images):
                    MATailoredOrderFlowMeasurementsView(viewModel: .init(order, images: images, path: $viewModel.navigationPath))
                        .toolbar(.hidden)
                }
            }
        }
        .addMALoading(state: viewModel.isLoading)
    }
    
}

// MARK: - Private functions
extension MAHomeView {
    
    private func filteredList(with text: String) -> [MAOrderModel] {
        return viewModel.orders.filter { order in
            order.client.fullName.lowercased().contains(text.lowercased()) ||
            order.client.email.lowercased().contains(text.lowercased()) ||
            order.client.phone.lowercased().contains(text.lowercased()) ||
            order.cloathesName.lowercased().contains(text.lowercased()) ||
            order.cloathesDescription.lowercased().contains(text.lowercased())
        }
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView()
    }
}
