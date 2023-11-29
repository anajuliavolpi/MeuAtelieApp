//
//  MARegisterView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import PhotosUI

struct MARegisterView: View {
    @ObservedObject var viewModel: MARegisterViewModel = MARegisterViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var userImage: Image?
    
    @State var showingActionSheet: Bool = false
    @State var showingImagePicker: Bool = false
    @State var showingCameraPicker: Bool = false
    @State var imagePicked: PhotosPickerItem?
    @State var uiImage: UIImage?
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                ScrollView {
                    VStack {
                        MAHeaderView(text: "Preencha",
                                     subtext: "SEUS DADOS",
                                     backgroundColor: .clear,
                                     ignoreSafeArea: false)
                            .padding(.horizontal, -30)
                        
                        Image.MAImages.Login.loginTopImage
                        
                        formView
                        
                        Image.MAImages.Login.loginBottomImage
                            .padding(.top, -6)
                        
                        actionButtonView
                            .padding(.vertical, 20)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .addMALoading(state: viewModel.isLoading)
        .addMAError(state: viewModel.showError,
                    message: "Cadastro incorreto", action: {
            viewModel.showError = false
        })
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
    
    var backgroundView: some View {
        LinearGradient(colors: viewModel.backgroundColors,
                       startPoint: .leading,
                       endPoint: .trailing)
        
        .ignoresSafeArea()
    }
    
    var formView: some View {
        Group {
            TextField(viewModel.emailText, text: $emailAddress)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.personFill,
                                                      keyboard: .emailAddress))
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.top, -8)
            
            SecureField(viewModel.passwordText, text: $password)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.lockFill))
                .textContentType(.password)
                .padding(.top, 14)
            
            TextField(viewModel.firstNameText, text: $firstName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 14)
            
            TextField(viewModel.lastNameText, text: $lastName)
                .textFieldStyle(MABasicTextFieldStyle(image: .MAImages.SystemImages.pencil))
                .textContentType(.name)
                .autocorrectionDisabled()
                .padding(.top, 14)
            
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
                
                Text("Inserir foto de perfil")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.MAColors.MAPinkStrong)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 20)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
            }
            .padding(.top, 14)
            .onTapGesture {
                showingActionSheet = true
            }
        }
    }
    
    var actionButtonView: some View {
        Button(viewModel.registerText) {
            let model = MARegisterModel(emailAddress: self.emailAddress,
                                        password: self.password,
                                        firstName: self.firstName,
                                        lastName: self.lastName)
            
            Task {
                await viewModel.createUser(networkManager, model: model, image: uiImage ?? UIImage())
            }
        }
        .buttonStyle(MABasicButtonStyle())
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        MARegisterView()
    }
}
