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
        NavigationView {
            VStack(alignment: .leading) {
                headerView
                    .padding(.horizontal, -30)
                
                personalDataView
                    .padding(.top, 10)
                
                Spacer()
                
                NavigationLink {
                    MANewPasswordView()
                        .toolbar(.hidden)
                } label: {
                    Button(viewModel.changePasswordText) {
                        print(#function)
                    }
                    .disabled(true)
                    .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                                    fontColor: .white))
                }
                
                Button(viewModel.exitText) {
                    viewModel.signOutWith(networkManager)
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                fontColor: .white))
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 30)
            .ignoresSafeArea(edges: .top)
            .addMALoading(state: viewModel.isLoading)
            .onAppear {
                viewModel.fetchUserData()
            }
        }
    }
    
    private var headerView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.MAColors.MAPink)
                .frame(height: 200)
            
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .foregroundColor(.MAColors.MAImageGray)
                        .frame(width: 100, height: 94)
                    
                    Image.MAImages.Login.loginTopImage
                        .resizable()
                        .frame(width: 74, height: 81)
                        .padding(.top, 8)
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.helloText)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .regular, design: .rounded))
                    
                    Text(viewModel.model?.firstName.uppercased() ?? "")
                        .foregroundColor(.MAColors.MAPinkMedium)
                        .font(.system(size: 40))
                }
            }
            .padding(.top, 40)
        }
    }
    
    private var personalDataView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.checkYourDataText)
                .foregroundColor(.MAColors.MAPinkMedium)
                .font(.system(size: 20, design: .rounded))
                .tracking(-1)
            
            Text(viewModel.nameText)
                .foregroundColor(.MAColors.MAWinePink)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 28)
            
            Divider()
                .padding(.horizontal, -30)
            
            Text("\(viewModel.model?.firstName ?? "") \(viewModel.model?.lastName ?? "")")
                .foregroundColor(.MAColors.MAPinkMedium)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 4)
            
            Text(viewModel.emailText)
                .foregroundColor(.MAColors.MAWinePink)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 40)
            
            Divider()
                .padding(.horizontal, -30)
            
            Text(viewModel.model?.emailAddress ?? "")
                .foregroundColor(.MAColors.MAPinkMedium)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.top, 4)
        }
    }
    
}

struct MAProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MAProfileView()
    }
}
