//
//  MAProfileView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 03/04/23.
//

import SwiftUI
import Firebase

struct MAProfileView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @State var userFirstName: String = ""
    @State var userLastName: String = ""
    
    var body: some View {
        ScrollView {
            ZStack {
                Rectangle()
                    .foregroundColor(.MAColors.MAPink)
                    .frame(height: 250)
                
                VStack {
                    HStack {
                        Text("Olá,")
                        Spacer()
                    }
                    
                    HStack {
                        Text(userFirstName)
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                        Spacer()
                    }
                }
                .font(.system(size: 48, weight: .light, design: .rounded))
                .padding(.leading, 30)
                .padding(.top, 50)
            }
            
            HStack {
                Text("Confira seus dados:")
                    .font(.system(size: 20, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 30)
            
            HStack {
                Text("E-mail:")
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 28)
            
            HStack {
                Text(Auth.auth().currentUser?.email ?? "E-mail não encontrado")
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            
            HStack {
                Text("Nome:")
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 8)
            
            HStack {
                Text("\(userFirstName) \(userLastName)")
                    .font(.system(size: 16, design: .rounded))
                    .padding(.leading, 30)
                
                Spacer()
            }
            
            Button {
//                networkManager.userHasAccount = false
            } label: {
                Text("Trocar de senha")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .tint(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            .foregroundColor(.MAColors.MAPinkMedium)
                    )
            }
            .padding(.horizontal, 30)
            .padding(.top, 50)
            
            Button {
                do {
                    try Auth.auth().signOut()
                    networkManager.signOut()
                } catch {
                    print("Some error on signing out: \(error)")
                }
            } label: {
                Text("SAIR")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .tint(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            .foregroundColor(.MAColors.MAPinkMedium)
                    )
            }
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea()
        .onAppear {
            fetchUserData()
        }
    }
    
    private func fetchUserData() {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
        
        ref.getDocument { snapshot, error in
            if let error {
                print("some error occured on fetching user data: \(error)")
                return
            }
            
            if let snapshot {
                let data = snapshot.data()
                self.userFirstName = data?["name"] as? String ?? ""
                self.userLastName = data?["lastname"] as? String ?? ""
            }
        }
    }
    
}

struct MAProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MAProfileView()
    }
}
