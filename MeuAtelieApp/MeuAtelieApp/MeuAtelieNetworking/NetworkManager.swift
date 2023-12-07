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
    
    init() {
        checkUserStatus()
    }
    
    func checkUserStatus() {
        isLoggedIn = Auth.auth().currentUser != nil
    }
}
