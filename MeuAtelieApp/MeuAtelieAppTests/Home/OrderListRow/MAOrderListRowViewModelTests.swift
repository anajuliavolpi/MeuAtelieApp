//
//  MAOrderListRowViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAOrderListRowViewModelTests: XCTestCase {
    
    var viewModel: MAOrderListRowViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
    }
    
    func setupViewModelWith(serviceType: ServiceType, deliveryDate: String) {
        viewModel = MAOrderListRowViewModel(order: .init(id: "",
                                                         serviceType: serviceType,
                                                         client: .init(id: "",
                                                                       fullName: "",
                                                                       phone: ""),
                                                         cloathesName: "",
                                                         cloathesDescription: "",
                                                         estimatedDeliveryDate: deliveryDate,
                                                         shoulderMeasurement: 0,
                                                         bustMeasurement: 0,
                                                         lengthMeasurement: 0,
                                                         waistMeasurement: 0,
                                                         abdomenMeasurement: 0,
                                                         hipsMeasurement: 0))
    }
    
    func testTailoredText() throws {
        setupViewModelWith(serviceType: .tailored, deliveryDate: "01/09/2000")
        
        XCTAssertEqual(viewModel.serviceType, "Serviço: Roupa sob medida")
        XCTAssertEqual(viewModel.dateText, "Entrega: 01/09/2000")
    }
    
    func testFixesText() throws {
        setupViewModelWith(serviceType: .fixes, deliveryDate: "05/05/1995")
        
        XCTAssertEqual(viewModel.serviceType, "Serviço: Ajuste/Conserto de roupa")
        XCTAssertEqual(viewModel.dateText, "Entrega: 05/05/1995")
    }

}
