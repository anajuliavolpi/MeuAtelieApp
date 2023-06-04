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
    @State var showNewClientView: Bool = false
    @State var clientSelected: MAClientModel = MAClientModel(id: "", fullName: "", phone: "")
    
    var body: some View {
        VStack {
            MAHeaderView(text: viewModel.createText,
                         subtext: viewModel.newOrderText)
            .padding(.horizontal, -20)
            
            serviceTypeView

            clientSelectionView
            
            Spacer()
            
            NavigationLink {
                if viewModel.orderService == viewModel.service1Text {
                    MATailoredOrderFlowView(viewModel:
                                                MATailoredOrderFlowViewModel(
                                                    MAOrderModel(id: UUID().uuidString,
                                                                 serviceType: .tailored,
                                                                 client: clientSelected,
                                                                 cloathesName: "",
                                                                 cloathesDescription: "",
                                                                 estimatedDeliveryDate: "",
                                                                 shoulderMeasurement: 0,
                                                                 bustMeasurement: 0,
                                                                 lengthMeasurement: 0,
                                                                 waistMeasurement: 0,
                                                                 abdomenMeasurement: 0,
                                                                 hipsMeasurement: 0)))
                        .toolbar(.hidden)
                }
            } label: {
                Button(viewModel.continueActionText) {
                    print(#function)
                }
                .disabled(true)
                .opacity(viewModel.isValid ? 1 : 0.3)
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                fontColor: .white))
            }
            .disabled(!viewModel.isValid)
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
        .hideKeyboard()
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
                    viewModel.orderService = viewModel.service1Text
                    viewModel.validateFields()
                }
                
                Button(viewModel.service2Text) {
                    viewModel.orderService = viewModel.service2Text
                    viewModel.validateFields()
                }
            } label: {
                HStack {
                    Text(viewModel.orderService)
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
                        viewModel.orderClient = client.fullName
                        clientSelected = client
                        viewModel.validateFields()
                    }
                }
                
                Button(viewModel.newClientText) {
                    showNewClientView = true
                    viewModel.validateFields()
                }
            } label: {
                HStack {
                    Text(viewModel.orderClient)
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
