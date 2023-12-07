//
//  MANewClient.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI
import Contacts
import PhotosUI

struct MANewClient: View {
    
    @ObservedObject var viewModel = MANewClientViewModel()
    @Binding var path: NavigationPath
    
    @State var clientFullName: String = ""
    @State var clientPhone: String = ""
    @State var clientEmail: String = ""
    @State var userImage: Image?
    
    @State var showImportClientSheet: Bool = false
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var showingCameraPicker: Bool = false
    @State var imagePicked: PhotosPickerItem?
    @State var uiImage: UIImage?
    
    @Binding var showNewClientView: Bool
    
    init(path: Binding<NavigationPath>, fromNewClientView: Binding<Bool> = Binding.constant(false)) {
        self._path = path
        self._showNewClientView = fromNewClientView
    }
    
    var body: some View {
        VStack {
            MAHeaderView(text: viewModel.createText,
                         subtext: viewModel.newClientText)
            .padding(.horizontal, -20)
            
            fieldsView
                .padding(.top, -30)
            
            Spacer()
            
            buttonsView
                .padding(.bottom, 8)
        }
        .padding(.horizontal, 20)
        .hideKeyboard()
        .addMAError(state: viewModel.showError,
                    message: "Cadastro incorreto", action: {
            viewModel.showError = false
        })
        .addMALoading(state: viewModel.isLoading)
        .sheet(isPresented: $showImportClientSheet) {
            MAImportClientsView(contacts: viewModel.contacts,
                                clientFullName: self.$clientFullName,
                                clientPhone: self.$clientPhone,
                                clientEmail: self.$clientEmail,
                                showImportClientSheet: self.$showImportClientSheet)
        }
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
                self.userImage = Image(uiImage: image)
                self.uiImage = image
            }
        }
        .onChange(of: imagePicked) { _, _ in
            Task {
                if let data = try? await imagePicked?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.userImage = Image(uiImage: uiImage)
                        self.uiImage = uiImage
                        return
                    }
                }
                
                print("Failed to get image from imagePicker")
            }
        }
    }
    
    var fieldsView: some View {
        VStack {
            TextField(viewModel.fullNameText, text: $clientFullName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black))
                .textContentType(.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
            
            TextField(viewModel.phoneText, text: $clientPhone)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.phone,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .phonePad))
                .textContentType(.telephoneNumber)
                .padding(.top, 16)
            
            TextField(viewModel.emailText, text: $clientEmail)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.email,
                                                      backgroundColor: .MAColors.MAPinkTextField,
                                                      foregroundTextColor: .black,
                                                      keyboard: .emailAddress))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, 16)
            
            HStack(spacing: 30) {
                if let userImage {
                    userImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 116, height: 113)
                        .padding()
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.MAColors.MAImageGray)
                            .frame(width: 116, height: 113)
                        
                        Image.MAImages.Login.loginTopImage
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 100)
                    }
                    .padding()
                }
                
                Text("Inserir foto do cliente")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.MAColors.MAPinkStrong)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 20)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.MAColors.MAImageGray.opacity(0.1))
            }
            .padding(.top, 14)
            .onTapGesture {
                showingActionSheet = true
            }
        }
    }
    
    var buttonsView: some View {
        VStack {
            Button(viewModel.importClientActionText) {
                Task {
                    await viewModel.fetchContacts()
                    self.showImportClientSheet = true
                }
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkLight,
                                            fontColor: .white))
            
            Button(viewModel.createActionText) {
                let model = MAClientModel(userId: "",
                                          id: UUID().uuidString,
                                          fullName: clientFullName,
                                          phone: clientPhone,
                                          email: clientEmail)
                
                Task {
                    do {
                        try await viewModel.new(client: model, image: uiImage ?? UIImage())
                        
                        if showNewClientView {
                            showNewClientView.toggle()
                        } else {
                            self.path.removeLast(self.path.count)
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            .buttonStyle(MABasicButtonStyle(backgroundColor: .MAColors.MAPinkMedium,
                                            fontColor: .white))
            .padding(.bottom, 40)
        }
    }
    
}

struct MANewClient_Previews: PreviewProvider {
    static var previews: some View {
        MANewClient(path: Binding.constant(NavigationPath()))
    }
}
