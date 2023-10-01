//
//  MeuAtelieAppApp.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 20/02/23.
//

import SwiftUI
import Firebase

@main
struct MeuAtelieAppApp: App {
    
    @StateObject var networkManager: NetworkManager = NetworkManager()
    @State var homePath: NavigationPath = .init()
    
    var handler: Binding<Int> { Binding(
        get: { self.networkManager.selectedTab },
        set: {
            if $0 == self.networkManager.selectedTab {
                if $0 == 0 {
                    homePath.removeLast(homePath.count)
                }
            }
            
            self.networkManager.selectedTab = $0
        }
    )}
    
    init() {
        FirebaseApp.configure()
        
        // Restore pre-iOS 15 nav bar / tab bar look
        // by: https://www.hackingwithswift.com/forums/ios/tab-bar-transparent/10549
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if networkManager.isLoggedIn {
                    TabView(selection: handler) {
                        MAHomeView(navigationPath: $homePath)
                            .tabItem {
                                Label("Pedidos", systemImage: "list.dash")
                            }
                            .tag(0)
                        
                        MAClientsView()
                            .tabItem {
                                Label("Clientes", systemImage: "person.3.fill")
                            }
                            .tag(1)
                        
                        MACalendarView()
                            .tabItem {
                                Label("Agenda", systemImage: "calendar")
                            }
                            .tag(2)
                        
                        MAProfileView()
                            .environmentObject(networkManager)
                            .tabItem {
                                Label("Perfil", systemImage: "person")
                            }
                            .tag(3)
                    }
                } else {
                    MALoginView()
                        .environmentObject(networkManager)
                }
            }
            .animation(.linear, value: networkManager.isLoggedIn)
        }
    }
}
