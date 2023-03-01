//
//  MAHomeView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 27/02/23.
//

import SwiftUI

struct MAHomeView: View {
    
    var body: some View {
        NavigationView {
            List(content: {
                Text("Roupa")
                Text("Linha")
                Text("Agulha")
            })
            .navigationTitle("Pedidos")
        }
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView()
    }
}
