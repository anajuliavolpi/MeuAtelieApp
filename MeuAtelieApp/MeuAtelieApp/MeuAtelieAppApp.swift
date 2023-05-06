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
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if networkManager.isLoggedIn {
                    TabView {
                        MAHomeView()
                            .tabItem {
                                Label("Pedidos", systemImage: "list.dash")
                            }
                        
                        MAProfileView()
                            .environmentObject(networkManager)
                            .tabItem {
                                Label("Perfil", systemImage: "person")
                            }
                    }
                } else {
                    if networkManager.userHasAccount {
                        MALoginView()
                            .environmentObject(networkManager)
                    } else {
                        MARegisterView()
                            .environmentObject(networkManager)
                    }
                }
            }
            .animation(.default, value: networkManager.userHasAccount)
            .animation(.linear, value: networkManager.isLoggedIn)
        }
    }
}
