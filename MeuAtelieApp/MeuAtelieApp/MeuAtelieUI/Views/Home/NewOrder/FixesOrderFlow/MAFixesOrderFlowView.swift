//
//  MAFixesOrderFlowView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 02/07/23.
//

import SwiftUI

struct MAFixesOrderFlowView: View {
    
    var viewModel: MAFixesOrderFlowViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                MAHeaderView(text: viewModel.headerText, subtext: viewModel.subheaderText)
                    .padding(.horizontal, -20)
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(edges: .top)
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
                                                    legFix: false)))
    }
    
}
