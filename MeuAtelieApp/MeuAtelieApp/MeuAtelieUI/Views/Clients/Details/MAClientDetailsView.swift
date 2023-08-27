//
//  MAClientDetailsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 07/05/23.
//

import SwiftUI

struct MAClientDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MAClientDetailsViewModel
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
            
            Spacer()
            
            buttonsView
                .padding(.horizontal, 20)
        }
        .addMALoading(state: viewModel.isLoading)
        .addMAAlert(state: showConfirmDeletion, message: "Deseja deletar o cliente?") {
            viewModel.deleteClient(dismiss)
            showConfirmDeletion = false
        } backAction: {
            showConfirmDeletion = false
        }
        .onAppear {
            viewModel.fetchClient()
            viewModel.fetchClientOrders()
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
    
    var buttonsView: some View {
        VStack {
            NavigationLink {
                MAEditClientView(viewModel: MAEditClientViewModel(clientID: viewModel.clientID))
                    .toolbar(.hidden)
            } label: {
                Button(viewModel.editClientText) {
                    print(#function)
                }
                .disabled(true)
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                                fontColor: .white))
            }
            
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
        MAClientDetailsView(viewModel: MAClientDetailsViewModel("", clientUserID: ""))
    }
}
