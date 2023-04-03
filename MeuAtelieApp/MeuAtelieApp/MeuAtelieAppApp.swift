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
    
    @StateObject var isLoggedIn: NetworkManager = NetworkManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn.isLoggedIn {
                TabView {
                    MAHomeView()
                        .environmentObject(isLoggedIn)
                        .tabItem {
                            Label("Pedidos", systemImage: "list.dash")
                        }
                }
            } else {
                MALoginView()
                    .environmentObject(isLoggedIn)
            }
        }
    }
}
