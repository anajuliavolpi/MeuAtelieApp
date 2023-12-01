//
//  MATailoredOrderFlowMeasurementsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import SwiftUI

struct MATailoredOrderFlowMeasurementsView: View {
    
    @ObservedObject var viewModel: MATailoredOrderFlowMeasurementsViewModel
    
    @State var shoulder: String = ""
    @State var bust: String = ""
    @State var length: String = ""
    @State var waist: String = ""
    @State var abdomen: String = ""
    @State var hips: String = ""
    
    private var isValid: Bool {
        !shoulder.isEmpty &&
        !bust.isEmpty &&
        !length.isEmpty &&
        !waist.isEmpty &&
        !abdomen.isEmpty &&
        !hips.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack {
                MAHeaderView(text: viewModel.cloathesText,
                             subtext: viewModel.tailoredText)
                
                .padding(.horizontal, -20)
                
                HStack {
                    Text(viewModel.measurementsText)
                        .foregroundColor(.MAColors.MAWinePink)
                        .font(.system(size: 20, design: .rounded))
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                firstPartFormView
                
                secondPartFormView
                
                Button(viewModel.finishActionButtonText) {
                    let order = MAOrderModel(id: viewModel.model.id,
                                             status: .onGoing,
                                             serviceType: viewModel.model.serviceType,
                                             client: viewModel.model.client,
                                             cloathesName: viewModel.model.cloathesName,
                                             cloathesDescription: viewModel.model.cloathesDescription,
                                             estimatedDeliveryDate: viewModel.model.estimatedDeliveryDate,
                                             shoulderMeasurement: Int(self.shoulder) ?? 0,
                                             bustMeasurement: Int(self.bust) ?? 0,
                                             lengthMeasurement: Int(self.length) ?? 0,
                                             waistMeasurement: Int(self.waist) ?? 0,
                                             abdomenMeasurement: Int(self.abdomen) ?? 0,
                                             hipsMeasurement: Int(self.hips) ?? 0,
                                             waistFix: false,
                                             lengthFix: false,
                                             hipsFix: false,
                                             barFix: false,
                                             shoulderFix: false,
                                             wristFix: false,
                                             legFix: false,
                                             totalValue: 0.0, // total value 0 for now
                                             hiredDate: Date.now.formatted(),
                                             deliveryDate: "",
                                             imagesURLs: [])
                    
                    Task {
                        await viewModel.uploadDocument(with: order)
                    }
                }
                .opacity(isValid ? 1 : 0.3)
                .disabled(!isValid)
                .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                                fontColor: .white))
                .padding([.top, .bottom], 40)
            }
            .padding(.horizontal, 20)
        }
        .addMALoading(state: viewModel.isLoading)
        .hideKeyboard()
        .ignoresSafeArea(edges: .top)
    }
    
    var firstPartFormView: some View {
        VStack {
            HStack {
                Text(viewModel.shoulderText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.shoulderText, text: $shoulder)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
            
            HStack {
                Text(viewModel.bustText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.bustText, text: $bust)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
            
            HStack {
                Text(viewModel.lengthText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.lengthText, text: $length)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
        }
    }
    
    var secondPartFormView: some View {
        VStack {
            HStack {
                Text(viewModel.waistText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.waistText, text: $waist)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
            
            HStack {
                Text(viewModel.abdomenText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.abdomenText, text: $abdomen)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
            
            HStack {
                Text(viewModel.hipsText)
                    .foregroundColor(.MAColors.MAWinePink)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 30)
            
            TextField(viewModel.hipsText, text: $hips)
                .textFieldStyle(MABasicTextFieldStyle(backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .numberPad))
                .textInputAutocapitalization(.words)
        }
    }
    
}

struct MATailoredOrderFlowMeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        MATailoredOrderFlowMeasurementsView(viewModel: .init(.init(id: UUID().uuidString,
                                                                   status: .onGoing,
                                                                   serviceType: .tailored,
                                                                   client: MAClientModel(userId: "", id: "", fullName: "", phone: "", email: ""),
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
                                                                   hiredDate: "",
                                                                   deliveryDate: ""),
                                                             images: [],
                                                             path: Binding.constant(.init())))
    }
}
