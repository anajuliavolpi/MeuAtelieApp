//
//  MAFixesOrderFlowView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI

struct MAFixesOrderFlowView: View {
    
    @ObservedObject var viewModel: MAFixesOrderFlowViewModel
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                VStack(alignment: .leading) {
                    MAHeaderView(text: viewModel.headerText, subtext: viewModel.subheaderText)
                        .padding(.horizontal, -20)
                        .id(1)
                    
                    Text(viewModel.piecesText)
                        .font(.system(size: 28, design: .rounded))
                        .foregroundColor(.MAColors.MAPinkMedium)
                        .padding(.top, 20)
                    
                    Divider()
                        .padding(.horizontal, -20)
                    
                    cloathesFields
                        .padding(.top, 20)
                    
                    deliveryView
                    
                    Text(viewModel.selectFixesText)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.MAColors.MAWinePink)
                        .padding(.top, 30)
                    
                    fixesView
                        .padding(.top, 2)
                    
                    Button {
                        viewModel.register()
                        
                        withAnimation {
                            value.scrollTo(1)
                        }
                    } label: {
                        Text(viewModel.continueButtonText)
                    }
                    .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                    fontColor: .white))
                    .disabled(!viewModel.isValid)
                    .opacity(viewModel.isValid ? 1 : 0.3)
                    .padding([.top, .bottom], 40)
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea(edges: .top)
            .hideKeyboard()
            .addMALoading(state: viewModel.isLoading)
        }
    }
    
    var cloathesFields: some View {
        VStack(alignment: .leading) {
            Text(viewModel.pieceName)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            TextField(viewModel.pieceNamePlaceholder, text: $viewModel.cloathesName)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textInputAutocapitalization(.words)
            
            Text(viewModel.pieceDescription)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.MAColors.MAWinePink)
            
            TextField(viewModel.pieceDescriptionPlaceholder, text: $viewModel.cloathesDescription)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textInputAutocapitalization(.sentences)
        }
    }
    
    var deliveryView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.deliveryDateText)
                .foregroundColor(.MAColors.MAWinePink)
                .font(.system(size: 20, design: .rounded))
            
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
    
    var fixesView: some View {
        VStack {
            HStack {
                Text(viewModel.adjustFixText)
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(.MAColors.MAPinkMedium)
                
                Spacer()
                
                Text(viewModel.valueText)
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(.MAColors.MAPinkMedium)
            }
            
            Divider()
                .padding(.horizontal, -20)
            
            VStack {
                ForEach(viewModel.fixes.indices, id: \.self) { index in
                    HStack {
                        Toggle(isOn: $viewModel.fixes[index].toggle) {}
                            .labelsHidden()
                            .tint(.MAColors.MAPinkLightMedium)
                        
                        Text(viewModel.fixes[index].description)
                        
                        Spacer()
                        
                        Text("R$ \(String(format: "%.2f", viewModel.fixes[index].value))")
                    }
                }
            }
            .padding(.top, 8)
        }
    }
    
}

struct FixesOrderFlowView_Previews: PreviewProvider {
    
    static var previews: some View {
        MAFixesOrderFlowView(viewModel: .init(.init(id: UUID().uuidString,
                                                    serviceType: .fixes,
                                                    client: .init(id: "", fullName: "", phone: ""),
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
                                                    hiredDate: ""),
                                              pieces: 3))
    }
    
}
