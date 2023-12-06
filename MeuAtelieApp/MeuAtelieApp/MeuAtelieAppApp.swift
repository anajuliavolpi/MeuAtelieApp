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
                    MATabBarView()
                        .environmentObject(networkManager)
                } else {
                    MALoginView()
                        .environmentObject(networkManager)
                }
            }
            .animation(.linear, value: networkManager.isLoggedIn)
        }
    }
}
