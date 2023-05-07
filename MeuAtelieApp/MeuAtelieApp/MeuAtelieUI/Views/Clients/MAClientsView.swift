//
//  MAClientsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 06/05/23.
//

import SwiftUI

struct MAClientsView: View {
    
    @ObservedObject private var viewModel = MAClientsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.clients, id: \.id) { client in
                NavigationLink {
                    MAClientDetailsView(viewModel: MAClientDetailsViewModel(client))
                        .navigationTitle("Dados do Cliente")
                } label: {
                    MAClientListRow(clientName: client.fullName,
                                    clientPhone: client.phone)
                    .padding()
                }
                .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in
                    return 0
                })
                .listRowInsets(EdgeInsets())
                .padding(.trailing, 18)
            }
            .navigationTitle(viewModel.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MANewClient()
                            .toolbar(.hidden)
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.MAColors.MAPinkMedium)
                    }
                }
            }
            .onAppear {
                viewModel.fetchClients()
            }
        }
        .addMALoading(state: viewModel.isLoading)
    }
}

struct MAClientsView_Previews: PreviewProvider {
    static var previews: some View {
        MAClientsView()
    }
}
