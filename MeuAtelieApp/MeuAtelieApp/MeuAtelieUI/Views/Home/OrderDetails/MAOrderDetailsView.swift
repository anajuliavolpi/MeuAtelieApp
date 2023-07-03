//
//  MAOrderDetailsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI

struct MAOrderDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MAOrderDetailsViewModel
    @State var showDeletionAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MAHeaderView(text: viewModel.headerText, subtext: viewModel.subheaderText)
                    .padding(.horizontal, -40)
                
                clientView
                    .padding(.top, 30)
                
                serviceView
                    .padding(.top, 30)
                
                if viewModel.order?.serviceType == .fixes && !viewModel.fixes.isEmpty {
                    fixesView
                        .padding(.top, 10)
                } else if viewModel.order?.serviceType == .tailored {
                    measurementsView
                        .padding(.top, 10)
                }
                
                moreInfoView
                    .padding(.top, 10)
                
                bottomButtonsView
                    .padding([.top, .bottom], 30)
            }
            .padding(.horizontal, 40)
        }
        .onAppear {
            viewModel.fetchOrder()
        }
        .ignoresSafeArea(edges: .top)
        .addMALoading(state: viewModel.isLoading)
        .addMAAlert(state: showDeletionAlert, message: "Deseja deletar o pedido?") {
            viewModel.deleteOrder(dismiss)
            showDeletionAlert = false
        } backAction: {
            showDeletionAlert = false
        }

    }
    
    var clientView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.clientText)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.MAColors.MAPinkMedium)
            
            Divider()
                .padding(.horizontal, -40)
            
            Text(viewModel.nameText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.client.fullName ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            Text(viewModel.phoneText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.client.phone ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
        }
    }
    
    var serviceView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.serviceText.uppercased())
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.MAColors.MAPinkMedium)
            
            Divider()
                .padding(.horizontal, -40)
            
            Text(viewModel.serviceText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.serviceType.rawValue ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            Text(viewModel.cloathesNameText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.cloathesName ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            Text(viewModel.cloathesDescriptionText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.cloathesDescription ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
        }
    }
    
    var measurementsView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.measurementsText)
                .font(.system(size: 18, design: .rounded))
            
            HStack {
                Text(viewModel.bustText)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 4)
                    .opacity(0.15)

                Text("\(viewModel.order?.bustMeasurement ?? 0)cm")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
            
            HStack {
                Text(viewModel.waistText)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 4)
                    .opacity(0.15)
                
                Text("\(viewModel.order?.waistMeasurement ?? 0)cm")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
            
            HStack {
                Text(viewModel.hipsText)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 4)
                    .opacity(0.15)
                
                Text("\(viewModel.order?.hipsMeasurement ?? 0)cm")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
            
            HStack {
                Text(viewModel.lengthText)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 4)
                    .opacity(0.15)
                
                Text("\(viewModel.order?.lengthMeasurement ?? 0)cm")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
        }
    }
    
    var fixesView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.fixesText)
                .font(.system(size: 18, design: .rounded))
            
            ForEach(viewModel.fixes, id: \.self) { fix in
                Text(fix)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
        }
    }
    
    var moreInfoView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.hiredText)
                .font(.system(size: 18, design: .rounded))
            
            Text(viewModel.order?.hiredDate ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            Text(viewModel.estimatedDeliveryDateText)
                .font(.system(size: 18, design: .rounded))
                .padding(.top, 10)
            
            Text(viewModel.order?.estimatedDeliveryDate ?? "")
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            if viewModel.order?.serviceType == .tailored {
                Text(viewModel.cloathesPhotos)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.top, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(1..<6) { _ in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.MAColors.MAImageGray)
                                    .frame(width: 116, height: 113)
                                
                                Image.MAImages.Login.loginTopImage
                                    .resizable()
                                    .frame(width: 86, height: 89)
                                    .padding(.top, 8)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.horizontal, -40)
                .padding(.bottom, 20)
            } else {
                Text(viewModel.totalValueText)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.top, 10)
                
                Text("R$ \(String(format: "%.2f", viewModel.order?.totalValue ?? 0.0))")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
        }
    }
    
    var bottomButtonsView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                NavigationLink(viewModel.editText) {
                    if let model = viewModel.order {
                        if viewModel.order?.serviceType == .fixes {
                            MAFixesOrderFlowView(viewModel: .init(model, pieces: 1, editing: true))
                                .toolbar(.hidden)
                        } else {
                            MATailoredOrderFlowView(viewModel: .init(model))
                                .toolbar(.hidden)
                        }
                    }
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPink,
                                                fontColor: .white))
                
                Button(viewModel.deleteText) {
                    showDeletionAlert = true
                }
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPink,
                                                fontColor: .white))
            }
            
            Button(viewModel.finishText) {
                print("tapped finalizar")
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
        }
    }
    
}

struct MAOrderDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        MAOrderDetailsView(viewModel: .init(orderID: ""))
    }
    
}
