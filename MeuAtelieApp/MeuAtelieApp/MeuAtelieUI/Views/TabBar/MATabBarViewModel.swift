//
//  MATabBarViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/12/23.
//

import SwiftUI
import Combine

final class MATabBarViewModel: ObservableObject {
    
    enum Tabs {
        case orders
        case clients
        case calendar
        case profile
        
        var title: String {
            switch self {
            case .orders:
                return "Pedidos"
            case .clients:
                return "Clientes"
            case .calendar:
                return "Agenda"
            case .profile:
                return "Perfil"
            }
        }
        
        var systemImage: String {
            switch self {
            case .orders:
                return "list.dash"
            case .clients:
                return "person.3.fill"
            case .calendar:
                return "calendar"
            case .profile:
                return "person"
            }
        }
    }
    
    @Published var selectedTab: MATabBarViewModel.Tabs = .orders
    @Published var homePath: NavigationPath = .init()
    @Published var clientsPath: NavigationPath = .init()
    @Published var calendarPath: NavigationPath = .init()
    @Published var profilePath: NavigationPath = .init()
    
}
