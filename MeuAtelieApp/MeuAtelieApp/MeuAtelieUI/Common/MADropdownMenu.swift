//
//  MADropdownMenu.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MADropdownMenu<Content: View, Label: View>: View {
    
    var content: Content
    var label: Label
    
    init(@ViewBuilder content: () -> Content,
         @ViewBuilder label: () -> Label) {
        self.content = content()
        self.label = label()
    }
    
    var body: some View {
        Menu {
            content
        } label: {
            label
            .padding(.horizontal, 16)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.MAColors.MAPinkTextField)
            )
        }
    }
    
}

struct MADropdownMenu_Previews: PreviewProvider {
    static var previews: some View {
        MADropdownMenu(content: {}, label: {})
    }
}
