//
//  MAHomeView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 27/02/23.
//

import SwiftUI
import Firebase

struct MAOrders: Identifiable {
    let uuid = UUID()
    let id: String
    let clientName: String
    let typeName: String
    let dateOfDelivery: String
}

struct MAHomeView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @State var orders: [MAOrders] = []
    @State private var showingCreateOrder = false
    
    var body: some View {
        NavigationView {
            List(orders, id: \.id) { order in
                VStack(alignment: .leading) {
                    Text("Cliente: \(order.clientName)")
                    Text("Tipo de peça: \(order.typeName)")
                    Text("Data: \(order.dateOfDelivery)")
                    
                    Button {
                        deleteOrder(id: order.id)
                    } label: {
                        Text("Deletar pedido")
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .tint(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .background(
                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                    .foregroundColor(.MAColors.MAPinkMedium)
                            )
                    }
                }
            }
            .onAppear {
                fetchOrders()
            }
            .navigationTitle("Pedidos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingCreateOrder.toggle()
                    } label: {
                        Text("Novo pedido")
                    }

                }
            }
        }
        .sheet(isPresented: $showingCreateOrder, onDismiss: {
            fetchOrders()
        }) {
            MANewOrder()
        }
    }
    
    private func fetchOrders() {
        orders.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        ref.getDocuments { snapshot, error in
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let clientName = data["clientName"] as? String ?? ""
                    let typeName = data["typeName"] as? String ?? ""
                    let dateOfDelivery = data["dateOfDelivery"] as? String ?? ""
                    
                    orders.append(MAOrders(id: document.documentID, clientName: clientName, typeName: typeName, dateOfDelivery: dateOfDelivery))
                }
            }
        }
    }
    
    private func deleteOrder(id: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        ref.getDocuments { snapshot, error in
            if let error {
                print("some error occured on fetching orders: \(error)")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents where document.documentID == id {
                    document.reference.delete()
                }
            }
            
            fetchOrders()
        }
    }
    
}

struct MAHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MAHomeView(orders: [MAOrders(id: "123", clientName: "Júlia", typeName: "Calça", dateOfDelivery: "05/05/1995"),
                            MAOrders(id: "456", clientName: "Ana", typeName: "Camisa", dateOfDelivery: "01/09/2000")])
    }
}
