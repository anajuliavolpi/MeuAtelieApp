//
//  Image+Ext.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 28/02/23.
//

import SwiftUI

extension Image {
    
    struct MAImages {
        
        struct SystemImages {
            static let personFill: Image = Image(systemName: "person.fill")
            static let lockFill: Image = Image(systemName: "lock.fill")
            static let pencil: Image = Image(systemName: "pencil.circle")
            static let phone: Image = Image(systemName: "phone.fill")
            static let arrowUpAndDown: Image = Image(systemName: "arrow.up.and.down.circle.fill")
            static let magnifyingGlass: Image = Image(systemName: "magnifyingglass")
        }
        
        struct Login {
            static let loginTextLogo: Image = Image("LoginTextLogo")
            static let loginTopImage: Image = Image("LoginTopImage")
            static let loginBottomImage: Image = Image("LoginBottomImage")
        }
        
        struct Helper {
            static let bigLogo: Image = Image("MABigLogo")
        }
        
    }
    
}
