//
//  MANewOrder.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI

struct MANewOrder: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: MANewOrderViewModel = MANewOrderViewModel()
    
    @State var orderService: String = "Serviço"
    @State var orderClient: String = "Cliente"
    @State var showNewClientView: Bool = false
    
    var body: some View {
        VStack {
            MAHeaderView(text: viewModel.createText,
                         subtext: viewModel.newOrderText)
            .padding(.horizontal, -20)
            
            serviceTypeView

            clientSelectionView
            
            Spacer()
            
            Button(viewModel.continueActionText) {
                print("Continuar!")
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.fetchClients()
        }
        .sheet(isPresented: $showNewClientView, onDismiss: {
            viewModel.fetchClients()
        }, content: {
            MANewClient()
        })
        .addMALoading(state: viewModel.isLoading)
    }
    
    var serviceTypeView: some View {
        VStack {
            HStack {
                Text(viewModel.serviceTypeText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, -30)
            
            MADropdownMenu {
                Button(viewModel.service1Text) {
                    orderService = viewModel.service1Text
                }
                
                Button(viewModel.service2Text) {
                    orderService = viewModel.service2Text
                }
            } label: {
                HStack {
                    Text(orderService)
                        .foregroundColor(.MAColors.MAPinkText)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Image.MAImages.SystemImages.arrowUpAndDown
                        .foregroundColor(.MAColors.MAPinkMedium)
                }
            }
        }
    }
    
    var clientSelectionView: some View {
        VStack {
            HStack {
                Text(viewModel.clientSelectionText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 42)
            
            MADropdownMenu {
                ForEach(viewModel.clients, id: \.id) { client in
                    Button(client.fullName) {
                        orderClient = client.fullName
                    }
                }
                
                Button(viewModel.newClientText) {
                    showNewClientView = true
                }
            } label: {
                HStack {
                    Text(orderClient)
                        .foregroundColor(.MAColors.MAPinkText)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Image.MAImages.SystemImages.magnifyingGlass
                        .foregroundColor(.MAColors.MAPinkMedium)
                }
            }
        }
    }
    
}

struct MANewOrder_Previews: PreviewProvider {
    static var previews: some View {
        MANewOrder()
    }
}
