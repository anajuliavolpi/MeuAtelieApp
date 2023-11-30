//
//  MAClientModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import Foundation

struct MAClientModel: Identifiable {
    
    let uuid = UUID()
    let userId: String
    let id: String
    let fullName: String
    let phone: String
    let email: String
    var imageURL: String?
    
}
