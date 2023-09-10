//
//  NetworkManager.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

class NetworkManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @State var selectedTab: Int = 0
    
    init() {
        isUserLoggedIn()
    }
    
    func isUserLoggedIn() {
        isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func signOut() {
        selectedTab = 0
        isLoggedIn = Auth.auth().currentUser != nil
    }
}
