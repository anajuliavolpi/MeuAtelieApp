//
//  MAClientDetailsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAClientDetailsView: View {
    
    @ObservedObject var viewModel: MAClientDetailsViewModel
    @Binding var path: NavigationPath
    @State var showConfirmDeletion: Bool = false
    
    var body: some View {
        VStack {
            headerView
            .padding(.top, 45)
            
            HStack {
                Text(viewModel.clientServicesText)
                    .foregroundColor(.MAColors.MAPinkMedium)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Spacer()
            }
            .padding(.leading, 18)
            .padding(.top, 20)
            
            Divider()
            
            List(viewModel.order, id: \.id) { order in
                ClientDetailsServiceRow(model: order)
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in
                        return 0
                    })
                    .listRowInsets(EdgeInsets())
                    .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .overlay {
                if viewModel.order.isEmpty {
                    VStack {
                        Text("OPS  ;(")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                            .padding(.top, 10)
                        
                        Text("Esse cliente não\npossui serviços cadastrados")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 20)
                    }
                }
            }
            
            Spacer()
            
            buttonsView
                .padding(.horizontal, 20)
        }
        .addMALoading(state: viewModel.isLoading)
        .addMAAlert(state: showConfirmDeletion, message: "Deseja deletar o cliente?") {
            Task {
                await viewModel.delete()
                showConfirmDeletion = false
                self.path.removeLast(self.path.count)
            }
        } backAction: {
            showConfirmDeletion = false
        }
    }
    
    var headerView: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 4) {
                Text(viewModel.fullName)
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .padding(.top, 20)
                
                Text("Telefone: \(viewModel.phone)")
                    .foregroundColor(.MAColors.MAPinkMedium)
                    .font(.system(size: 20, design: .rounded))
                
                Text("Email: \(viewModel.email)")
                    .foregroundColor(.MAColors.MAPinkMedium)
                    .font(.system(size: 20, design: .rounded))
            }
            .frame(width: 325, height: 140)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.MAColors.MAPinkBackground)
            )
            
            if let imageURL = viewModel.clientImageURL, !imageURL.isEmpty {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .frame(width: 53, height: 58)
                        .clipShape(Circle())
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .padding(.top, -35)
            } else {
                ZStack {
                    Circle()
                        .foregroundColor(.MAColors.MAImageGray)
                        .frame(width: 70, height: 70)
                    
                    Image.MAImages.Login.loginTopImage
                        .resizable()
                        .frame(width: 53, height: 58)
                        .padding(.top, 8)
                }
                .padding(.top, -35)
            }
        }
    }
    
    var buttonsView: some View {
        VStack {
            Button(viewModel.editClientText) {
                self.path.append(MANavigationRoutes.ClientRoutes.edit(client: .init(userId: viewModel.clientUserID,
                                                                                    id: viewModel.clientID,
                                                                                    fullName: viewModel.fullName,
                                                                                    phone: viewModel.phone,
                                                                                    email: viewModel.email,
                                                                                    imageURL: viewModel.clientImageURL)))
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                            fontColor: .white))
            
            Button(viewModel.deleteClientText) {
                showConfirmDeletion = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 10)
        }
    }
    
}

struct MAClientDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MAClientDetailsView(viewModel: MAClientDetailsViewModel("", clientUserID: ""), path: Binding.constant(NavigationPath()))
    }
}
