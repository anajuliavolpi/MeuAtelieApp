//
//  MeuAtelieAppApp.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 20/02/23.
//

import SwiftUI

@main
struct MeuAtelieAppApp: App {
    
    @State var userLogIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if userLogIn {
                TabView {
                    MAHomeView()
                        .tabItem {
                            Label("Pedidos", systemImage: "list.dash")
                        }
                }
            } else {
                MALoginView(userLogIn: $userLogIn)
            }
        }
    }
}
