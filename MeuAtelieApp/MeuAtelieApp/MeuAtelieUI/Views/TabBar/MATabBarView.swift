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
        TabView() {
            MAHomeView()
                .tabItem {
                    Label(MATabBarViewModel.Tabs.orders.title,
                          systemImage: MATabBarViewModel.Tabs.orders.systemImage)
                }
            
            MAClientsView()
                .tabItem {
                    Label(MATabBarViewModel.Tabs.clients.title,
                          systemImage: MATabBarViewModel.Tabs.clients.systemImage)
                }
            
            MACalendarView()
                .tabItem {
                    Label(MATabBarViewModel.Tabs.calendar.title,
                          systemImage: MATabBarViewModel.Tabs.calendar.systemImage)
                }
            
            MAProfileView()
                .environmentObject(networkManager)
                .tabItem {
                    Label(MATabBarViewModel.Tabs.profile.title,
                          systemImage: MATabBarViewModel.Tabs.profile.systemImage)
                }
        }
    }
    
}

#Preview {
    MATabBarView()
}
