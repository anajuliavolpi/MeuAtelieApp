//
//  MATailoredOrderFlowView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 08/05/23.
//

import SwiftUI
import PhotosUI

struct MATailoredOrderFlowView: View {
    
    @ObservedObject var viewModel: MATailoredOrderFlowViewModel
    @Binding var path: NavigationPath
    
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var showingCameraPicker: Bool = false
    @State var imagePicked: PhotosPickerItem?
    
    var body: some View {
        ScrollView {
            VStack {
                MAHeaderView(text: viewModel.cloathesText,
                             subtext: viewModel.tailoredText)
                .padding(.horizontal, -20)
                
                galleryView
                
                cloathesDetailsView
                
                deliveryView
                
                Button(viewModel.continueActionButtonText) {
                    path.append(MANavigationRoutes.HomeRoutes.tailoredFlowMeasurements(order: MAOrderModel(id: viewModel.model.id,
                                                                                                           status: .onGoing,
                                                                                                           serviceType: viewModel.model.serviceType,
                                                                                                           client: viewModel.model.client,
                                                                                                           cloathesName: viewModel.cloathesName,
                                                                                                           cloathesDescription: viewModel.cloathesDescription,
                                                                                                           estimatedDeliveryDate: viewModel.dateNow.formatted(),
                                                                                                           shoulderMeasurement: viewModel.isEditing ? viewModel.model.shoulderMeasurement : 0,
                                                                                                           bustMeasurement: viewModel.isEditing ? viewModel.model.bustMeasurement : 0,
                                                                                                           lengthMeasurement: viewModel.isEditing ? viewModel.model.lengthMeasurement : 0,
                                                                                                           waistMeasurement: viewModel.isEditing ? viewModel.model.waistMeasurement : 0,
                                                                                                           abdomenMeasurement: viewModel.isEditing ? viewModel.model.abdomenMeasurement : 0,
                                                                                                           hipsMeasurement: viewModel.isEditing ? viewModel.model.hipsMeasurement : 0,
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
                                                                                       images: viewModel.images,
                                                                                       editing: viewModel.isEditing))
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
        .confirmationDialog("Tirar uma foto ou selecionar da galeria", isPresented: $showingActionSheet, actions: {
            Button("Escolher da galeria") {
                showingImagePicker = true
            }
            
            Button("Tirar foto") {
                showingCameraPicker = true
            }
        })
        .photosPicker(isPresented: $showingImagePicker, selection: $imagePicked, matching: .images)
        .fullScreenCover(isPresented: $showingCameraPicker) {
            CameraPicker(sourceType: .camera) { image in
                viewModel.images.append(.init(image: Image(uiImage: image), uiImage: image))
            }
        }
        .onChange(of: imagePicked) { _, _ in
            Task {
                if let data = try? await imagePicked?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        viewModel.images.append(.init(image: Image(uiImage: uiImage), uiImage: uiImage))
                        return
                    }
                }
                
                print("Failed to get image from imagePicker")
            }
        }
        .addMALoading(state: viewModel.isLoading)
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
                    ForEach(viewModel.images, id: \.id) { image in
                        image.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 116, height: 113)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.MAColors.MAImageGray)
                            .frame(width: 116, height: 113)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 46, height: 49)
                    }
                    .onTapGesture {
                        showingActionSheet = true
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
                                                       deliveryDate: "")),
                                path: Binding.constant(.init()))
    }
}
