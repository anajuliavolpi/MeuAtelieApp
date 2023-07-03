//
//  MATailoredOrderFlowView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import SwiftUI

struct MATailoredOrderFlowView: View {
    
    @ObservedObject var viewModel: MATailoredOrderFlowViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                MAHeaderView(text: viewModel.cloathesText,
                             subtext: viewModel.tailoredText)
                .padding(.horizontal, -20)
                
                galleryView
                
                cloathesDetailsView
                
                deliveryView
                
                NavigationLink {
                    MATailoredOrderFlowMeasurementsView(viewModel:
                                                            MATailoredOrderFlowMeasurementsViewModel(
                                                                MAOrderModel(id: viewModel.model.id,
                                                                             serviceType: viewModel.model.serviceType,
                                                                             client: viewModel.model.client,
                                                                             cloathesName: viewModel.cloathesName,
                                                                             cloathesDescription: viewModel.cloathesDescription,
                                                                             estimatedDeliveryDate: viewModel.dateNow.formatted(),
                                                                             shoulderMeasurement: 0,
                                                                             bustMeasurement: 0,
                                                                             lengthMeasurement: 0,
                                                                             waistMeasurement: 0,
                                                                             abdomenMeasurement: 0,
                                                                             hipsMeasurement: 0,
                                                                             waistFix: false,
                                                                             lengthFix: false,
                                                                             hipsFix: false,
                                                                             barFix: false,
                                                                             shoulderFix: false,
                                                                             wristFix: false,
                                                                             legFix: false,
                                                                             totalValue: 0.0,
                                                                             hiredDate: "")))
                        .toolbar(.hidden)
                } label: {
                    Button(viewModel.continueActionButtonText) {
                        print(#function)
                    }
                    .disabled(true)
                    .opacity(viewModel.isValid ? 1 : 0.3)
                    .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                    fontColor: .white))
                }
                .disabled(!viewModel.isValid)
                .padding([.top, .bottom], 40)
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(edges: .top)
        .hideKeyboard()
    }
    
    var galleryView: some View {
        VStack {
            HStack {
                Text("Adicionar foto da peça modelo")
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
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
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
            .padding(.top, 10)
        }
    }
    
    var cloathesDetailsView: some View {
        VStack {
            HStack {
                Text(viewModel.cloathesNameText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.cloathesNamePlaceholder, text: $viewModel.cloathesName)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textInputAutocapitalization(.words)
            
            HStack {
                Text(viewModel.cloathesDescriptionText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.cloathesDescriptionPlaceholder, text: $viewModel.cloathesDescription)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textInputAutocapitalization(.sentences)
        }
    }
    
    var deliveryView: some View {
        VStack {
            HStack {
                Text(viewModel.estimatedDeliveryDateText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            HStack {
                DatePicker("", selection: $viewModel.dateNow, in: Date.now..., displayedComponents: .date)
                    .labelsHidden()
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(.MAColors.MAPinkMedium)
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.MAColors.MAPinkTextField)
            )
        }
    }
    
}

struct MATailoredOrderFlowView_Previews: PreviewProvider {
    static var previews: some View {
        MATailoredOrderFlowView(viewModel: .init(.init(id: UUID().uuidString,
                                                       serviceType: .tailored,
                                                       client: MAClientModel(userId: "", id: "", fullName: "", phone: ""),
                                                       cloathesName: "",
                                                       cloathesDescription: "",
                                                       estimatedDeliveryDate: "",
                                                       shoulderMeasurement: 0,
                                                       bustMeasurement: 0,
                                                       lengthMeasurement: 0,
                                                       waistMeasurement: 0,
                                                       abdomenMeasurement: 0,
                                                       hipsMeasurement: 0,
                                                       waistFix: false,
                                                       lengthFix: false,
                                                       hipsFix: false,
                                                       barFix: false,
                                                       shoulderFix: false,
                                                       wristFix: false,
                                                       legFix: false,
                                                       totalValue: 0.0,
                                                       hiredDate: "")))
    }
}
