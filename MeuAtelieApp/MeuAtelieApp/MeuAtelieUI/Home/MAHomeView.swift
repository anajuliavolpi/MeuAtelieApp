//
//  MAHomeView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 27/02/23.
//

import SwiftUI
import Firebase

struct MAHomeView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        NavigationView {
            List(content: {
                Text("Roupa")
                Text("Linha")
                Text("Agulha")
            })
            .navigationTitle("Pedidos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        do {
                            try Auth.auth().signOut()
                            networkManager.isUserLoggedIn()
                        } catch {
                            print("Some error on signing out: \(error)")
                        }
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .tint(.black)
                    }

                }
            }
        }
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView()
    }
}
