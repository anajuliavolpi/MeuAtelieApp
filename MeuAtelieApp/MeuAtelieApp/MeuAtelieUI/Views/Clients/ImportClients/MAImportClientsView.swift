//
//  MAImportClientsView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 23/10/23.
//

import SwiftUI
import Contacts

struct MAImportClientsView: View {
    
    @State var contacts: [CNContact] = []
    
    @Binding var clientFullName: String
    @Binding var clientPhone: String
    @Binding var clientEmail: String
    @Binding var showImportClientSheet: Bool
    
    var body: some View {
        VStack {
            MAHeaderView(text: "Importar",
                         subtext: "CONTATO")
            
            List($contacts, id: \.self) { contact in
                MAClientListRow(clientName: "\(getFirstName(of: contact.wrappedValue)) \(getLastName(of: contact.wrappedValue))",
                                clientPhone: getPhoneNumber(of: contact.wrappedValue),
                                clientEmail: getEmailAddress(of: contact.wrappedValue))
                .padding()
                .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in return 0 })
                .listRowInsets(EdgeInsets())
                .padding(.trailing, 18)
                .onTapGesture {
                    clientFullName = "\(getFirstName(of: contact.wrappedValue)) \(getLastName(of: contact.wrappedValue))"
                    clientPhone = getPhoneNumber(of: contact.wrappedValue)
                    clientEmail = getEmailAddress(of: contact.wrappedValue)
                    
                    showImportClientSheet = false
                }
            }
            .listStyle(.plain)
        }
    }
    
}

// MARK: - Format contact information
extension MAImportClientsView {
    
    func getFirstName(of contact: CNContact) -> String {
        return contact.givenName
    }
    
    func getLastName(of contact: CNContact) -> String {
        return contact.familyName
    }
    
    func getPhoneNumber(of contact: CNContact) -> String {
        return contact.phoneNumbers.first?.value.stringValue ?? "N/A"
    }
    
    func getEmailAddress(of contact: CNContact) -> String {
        return contact.emailAddresses.first?.value.lowercased ?? "N/A"
    }
    
}

#Preview("Light Mode") {
    MAImportClientsView(clientFullName: Binding.constant("Ana"),
                        clientPhone: Binding.constant("4755999665544"),
                        clientEmail: Binding.constant("ana@julia.volpi"),
                        showImportClientSheet: Binding.constant(false))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    MAImportClientsView(clientFullName: Binding.constant("Ana"),
                        clientPhone: Binding.constant("4755999665544"),
                        clientEmail: Binding.constant("ana@julia.volpi"),
                        showImportClientSheet: Binding.constant(false))
        .preferredColorScheme(.dark)
}
