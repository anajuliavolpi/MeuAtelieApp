//
//  MAClientsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI

struct MAClientsView: View {
    
    @ObservedObject private var viewModel = MAClientsViewModel()
    @Binding var navigationPath: NavigationPath
    @State var textToSearch: String = ""
    
    var searchResults: [MAClientModel] {
        if textToSearch.isEmpty {
            return viewModel.clients
        } else {
            return viewModel.clients.filter(
                {
                    $0.fullName.lowercased().contains(textToSearch.lowercased()) ||
                    $0.email.lowercased().contains(textToSearch.lowercased()) ||
                    $0.phone.lowercased().contains(textToSearch.lowercased())
                }
            )
        }
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(self.searchResults, id: \.id) { client in
                Button {
                    navigationPath.append(MANavigationRoutes.ClientRoutes.client(details: client))
                } label: {
                    MAClientListRow(clientName: client.fullName,
                                    clientPhone: client.phone,
                                    clientEmail: client.email,
                                    clientImageURL: client.imageURL)
                    .padding()
                }
                .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in
                    return 0
                })
                .listRowInsets(EdgeInsets())
                .padding(.trailing, 18)
            }
            .searchable(text: $textToSearch)
            .navigationTitle(viewModel.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.navigationPath.append(MANavigationRoutes.ClientRoutes.newClient)
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.MAColors.MAPinkMedium)
                    }
                }
            }
            .overlay {
                if self.searchResults.isEmpty {
                    VStack {
                        Text("OPS  ;(")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 34, weight: .semibold, design: .rounded))
                            .padding(.top, 90)
                        
                        Text("Você não possui\nclientes cadastrados")
                            .foregroundColor(.MAColors.MAPinkText)
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 30)
                        
                        Spacer(minLength: 40)
                        
                        Image.MAImages.Login.loginTopImage
                            .resizable()
                            .opacity(0.45)
                    }
                }
            }
            .task {
                await viewModel.fetch()
            }
            .navigationDestination(for: MANavigationRoutes.ClientRoutes.self) { route in
                switch route {
                case .newClient:
                    MANewClient()
                        .toolbar(.hidden)
                case .client(let details):
                    MAClientDetailsView(viewModel: MAClientDetailsViewModel(details.id, clientUserID: details.userId))
                        .navigationTitle("Dados do Cliente")
                }
            }
        }
        .addMALoading(state: viewModel.isLoading)
    }
}

struct MAClientsView_Previews: PreviewProvider {
    static var previews: some View {
        MAClientsView(navigationPath: Binding.constant(NavigationPath()))
    }
}
