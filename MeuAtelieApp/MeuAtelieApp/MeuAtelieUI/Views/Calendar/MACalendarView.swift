//
//  MACalendarView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 10/09/23.
//

import SwiftUI

struct MACalendarView: View {
    
    @ObservedObject var viewModel: MACalendarViewModel = .init()
    @State var selectedDate: Date = .now
    @Binding var navigationPath: NavigationPath
    
    var ordersOnSelectedDate: [MAOrderModel] {
        return viewModel.orders.filter { order in
            if order.status == .completed {
                guard let date = viewModel.df.date(from: order.deliveryDate) else { return false }
                return date == selectedDate
            }
            
            guard let date = viewModel.df.date(from: order.estimatedDeliveryDate) else { return false }
            return date == selectedDate
        }
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading, spacing: 0) {
                CalendarView(calendar: Calendar(identifier: .gregorian),
                             selectedDate: $selectedDate,
                             dates: viewModel.ordersDate)
                
                Text("\(DateFormatter(dateFormat: "EEEE, MMM d, yyyy", calendar: .init(identifier: .gregorian)).string(from: selectedDate))")
                    .foregroundColor(.MAColors.MAPinkText)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .padding([.leading, .top], 20)
                
                List(self.ordersOnSelectedDate, id: \.id) { order in
                    MAOrderListRow(viewModel: .init(order: order))
                        .padding()
                        .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in return 0 })
                        .listRowInsets(EdgeInsets())
                        .padding(.trailing, 18)
                        .onTapGesture {
                            navigationPath.append(MANavigationRoutes.CalendarRoutes.orderDetails(order: order))
                        }
                }
                .listStyle(.plain)
                .navigationDestination(for: MANavigationRoutes.CalendarRoutes.self, destination: { routes in
                    switch routes {
                    case .orderDetails(let order):
                        MAOrderDetailsView(viewModel: .init(orderID: order.id), path: $navigationPath, isFromCalendar: true)
                    case .editOrder(let order):
                        if order.serviceType == .fixes {
                            MAFixesOrderFlowView(viewModel: .init(order, pieces: 1, path: $navigationPath, editing: true))
                                .toolbar(.hidden)
                        } else {
                            MATailoredOrderFlowView(viewModel: .init(order), path: $navigationPath)
                                .toolbar(.hidden)
                        }
                    }
                })
                .overlay {
                    if ordersOnSelectedDate.isEmpty {
                        VStack {
                            Text("OPS  ;(")
                                .foregroundColor(.MAColors.MAPinkText)
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .padding(.top, 90)
                            
                            Text("Você não possui\npedidos nesse dia")
                                .foregroundColor(.MAColors.MAPinkText)
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(.top, 30)
                            
                            Spacer(minLength: 40)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchOrders()
            }
            .addMALoading(state: viewModel.isLoading)
        }
    }
    
}

struct MACalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MACalendarView(navigationPath: Binding.constant(.init()))
    }
}
