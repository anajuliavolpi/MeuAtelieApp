//
//  MALoginViewModel.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/04/23.
//

import SwiftUI
import Firebase

final class MALoginViewModel: ObservableObject {
    
    struct TextFields {
        var login: String
        var password: String
    }
    
    @Published var navigationPath: NavigationPath = .init()
    @Published var isLoading: Bool = false
    @Published var isShowingError: Bool = false
    @Published var errorMessage: String = ""
    @Published var textFields: TextFields = .init(login: "",
                                                  password: "")
    
    let backgroundColors: [Color] = [.MAColors.MAPinkLightStrong,
                                     .MAColors.MAPinkLight,
                                     .MAColors.MAPinkLightMedium]
    let strings = MAStrings.Login()
    
    @MainActor func signIn(_ networkManager: NetworkManager) async {
        isLoading = true
        
        do {
            let _ = try await Auth.auth().signIn(withEmail: textFields.login, password: textFields.password)
            networkManager.isUserLoggedIn()
        } catch {
            switch AuthErrorCode.Code(rawValue: (error as NSError).code) {
            case .wrongPassword:
                self.errorMessage = "Senha incorreta, por favor tente novamente."
            case .invalidEmail:
                self.errorMessage = "Email inválido, por favor tente novamente."
            case .userNotFound:
                self.errorMessage = "Email não encontrado, por favor tente novamente."
            default:
                self.errorMessage = error.localizedDescription
            }
            
            self.isShowingError = true
            return
        }
    }
    
}
