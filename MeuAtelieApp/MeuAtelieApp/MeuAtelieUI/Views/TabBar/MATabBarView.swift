//
//  MATabBarView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/12/23.
//

import SwiftUI

struct MATabBarView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @ObservedObject private var viewModel: MATabBarViewModel = .init()
    
    var body: some View {
        TabView(selection: createTabViewBinding()) {
            MAHomeView(viewModel: .init(path: $viewModel.homePath))
                .tabItem {
                    Label(MATabBarViewModel.Tabs.orders.title,
                          systemImage: MATabBarViewModel.Tabs.orders.systemImage)
                }
                .tag(MATabBarViewModel.Tabs.orders)
            
            MAClientsView()
                .tabItem {
                    Label(MATabBarViewModel.Tabs.clients.title,
                          systemImage: MATabBarViewModel.Tabs.clients.systemImage)
                }
                .tag(MATabBarViewModel.Tabs.clients)
            
            MACalendarView()
                .tabItem {
                    Label(MATabBarViewModel.Tabs.calendar.title,
                          systemImage: MATabBarViewModel.Tabs.calendar.systemImage)
                }
                .tag(MATabBarViewModel.Tabs.calendar)
            
            MAProfileView()
                .environmentObject(networkManager)
                .tabItem {
                    Label(MATabBarViewModel.Tabs.profile.title,
                          systemImage: MATabBarViewModel.Tabs.profile.systemImage)
                }
                .tag(MATabBarViewModel.Tabs.profile)
        }
    }
    
    private func createTabViewBinding() -> Binding<MATabBarViewModel.Tabs> {
        Binding<MATabBarViewModel.Tabs>(
            get: { viewModel.selectedTab },
            set: { selectedTab in
                if selectedTab == viewModel.selectedTab {
                    switch selectedTab {
                    case .orders:
                        withAnimation {
                            viewModel.homePath.removeLast(viewModel.homePath.count)
                        }
                    case .clients:
                        break
                    case .calendar:
                        break
                    case .profile:
                        break
                    }
                }
                
                viewModel.selectedTab = selectedTab
            }
        )
    }
    
}

#Preview {
    MATabBarView()
}
