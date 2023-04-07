//
//  MAProfileView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MAProfileView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @ObservedObject var viewModel: MAProfileViewModel = MAProfileViewModel()
    
    var body: some View {
        ScrollView {
            ZStack {
                Rectangle()
                    .foregroundColor(.MAColors.MAPink)
                    .frame(height: 250)
                
                VStack {
                    HStack {
                        Text(viewModel.helloText)
                        Spacer()
                    }
                    
                    HStack {
                        Text(viewModel.model?.firstName ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                        Spacer()
                    }
                }
                .font(.system(size: 48, weight: .light, design: .rounded))
                .padding(.leading, 30)
                .padding(.top, 50)
            }
            
            HStack {
                Text(viewModel.checkYourDataText)
                    .font(.system(size: 20, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 30)
            
            HStack {
                Text(viewModel.emailText)
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 28)
            
            HStack {
                Text(viewModel.model?.emailAddress ?? "")
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            
            HStack {
                Text(viewModel.nameText)
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 8)
            
            HStack {
                Text(viewModel.fullNameText)
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            
            Button(viewModel.changePasswordText) {
                viewModel.isShowingChangePassword = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.horizontal, 30)
            .padding(.top, 50)
            
            Button(viewModel.exitText) {
                viewModel.signOutWith(networkManager)
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.horizontal, 30)
        }
        .addMALoading(state: viewModel.isLoading)
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.isShowingChangePassword) {
            MANewPasswordView()
        }
    }
    
}

struct MAProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MAProfileView()
    }
}
