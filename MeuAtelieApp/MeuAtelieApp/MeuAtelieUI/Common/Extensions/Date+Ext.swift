//
//  Date+Ext.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 10/09/23.
//

import Foundation

extension DateFormatter {
    
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: "pt-BR")
    }
    
}
