//
//  MAOrderDetailsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI
import Firebase

struct MAOrderDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var viewModel: MAOrderDetailsViewModel
    @State private var showDeletionAlert: Bool = false
    @State private var showCompletionAlert: Bool = false
    @State private var isBarHidden = false
    @State private var showImageSheet = false
    @State private var selectedImage: Image?
    @Binding var path: NavigationPath
    var isFromCalendar: Bool = false
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                VStack(alignment: .leading) {
                    MAHeaderView(text: viewModel.headerText, subtext: viewModel.subheaderText)
                        .padding(.horizontal, -40)
                        .id(1)
                    
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
                    
                    if !viewModel.isCompletedOrder {
                        bottomButtonsView
                            .padding([.top, .bottom], 30)
                    } else {
                        shareButtons
                            .padding([.top, .bottom], 30)
                    }
                }
                .padding(.horizontal, 40)
            }
            .toolbar(isBarHidden ? .hidden : .visible)
            .onAppear {
                isBarHidden = true
                viewModel.fetchOrder()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    viewModel.fetchOrder()
                }
            }
            .ignoresSafeArea(edges: .top)
            .addMALoading(state: viewModel.isLoading)
            .addMAAlert(state: showDeletionAlert, message: "Deseja deletar o pedido?") {
                viewModel.deleteOrder(dismiss)
                showDeletionAlert = false
            } backAction: {
                showDeletionAlert = false
            }
            .addMAAlert(state: showCompletionAlert, message: "Deseja finalizar o pedido?") {
                viewModel.complete()
                showCompletionAlert = false
                
                withAnimation {
                    value.scrollTo(1)
                }
            } backAction: {
                showCompletionAlert = false
            }
            .sheet(isPresented: $showImageSheet) {
                selectedImage?
                    .resizable()
                    .scaledToFit()
            }
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
            
            if viewModel.isCompletedOrder {
                Text(viewModel.deliveryDateText)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.top, 10)
                
                Text(viewModel.order?.deliveryDate ?? "")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.MAColors.MAWinePink)
            }
            
            if viewModel.order?.serviceType == .tailored {
                Text(viewModel.cloathesPhotos)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.top, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.order?.imagesURLs ?? [""], id: \.self) { url in
                            AsyncImage(url: URL(string: url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        self.selectedImage = image
                                        self.showImageSheet = true
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 116, height: 113)
                            .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.horizontal, -40)
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
                Button(viewModel.editText) {
                    if let model = viewModel.order {
                        if isFromCalendar {
                            path.append(MANavigationRoutes.CalendarRoutes.editOrder(order: model))
                        } else {
                            path.append(MANavigationRoutes.HomeRoutes.editOrder(order: model))
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
                showCompletionAlert = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
        }
    }
    
    var shareButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Compartilhar no WhatsApp!") {
                let phone = viewModel.order?.client.phone ?? ""
                let text = """
                            O seu pedido está pronto:
                                Pedido: \(viewModel.order?.cloathesDescription ?? "")
                                Tipo: \(viewModel.order?.serviceType.rawValue ?? "")
                                Data prevista: \(viewModel.order?.estimatedDeliveryDate ?? "")
                                Data de entrega: \(viewModel.order?.deliveryDate ?? "")
                            Esperamos sua visita!
                            """
                
                var urlComponents = URLComponents(string: "https://wa.me/55\(phone)")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "text", value: text)
                ]
                
                if let url = urlComponents?.url {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkStrong,
                                            fontColor: .white))
            
            Button("Compartilhar via Email") {
                let email = viewModel.order?.client.email ?? ""
                let text = """
                            O seu pedido está pronto:
                                Pedido: \(viewModel.order?.cloathesDescription ?? "")
                                Tipo: \(viewModel.order?.serviceType.rawValue ?? "")
                                Data prevista: \(viewModel.order?.estimatedDeliveryDate ?? "")
                                Data de entrega: \(viewModel.order?.deliveryDate ?? "")
                            Esperamos sua visita!
                            """
                
                var urlComponents = URLComponents(string: "mailto:\(email)")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "subject", value: "Seu pedido está pronto - Meu AteliêApp"),
                    URLQueryItem(name: "body", value: text)
                ]
                
                if let url = urlComponents?.url {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkStrong,
                                            fontColor: .white))
            
            Button(viewModel.deleteText) {
                showDeletionAlert = true
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPink,
                                            fontColor: .white))
        }
    }
    
}

struct MAOrderDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        MAOrderDetailsView(viewModel: .init(orderID: ""), path: Binding.constant(.init()))
    }
    
}
