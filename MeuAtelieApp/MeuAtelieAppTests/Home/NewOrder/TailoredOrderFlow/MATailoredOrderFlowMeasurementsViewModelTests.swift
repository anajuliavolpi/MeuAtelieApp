//
//  MATailoredOrderFlowMeasurementsViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MATailoredOrderFlowMeasurementsViewModelTests: XCTestCase {
    
    var viewModel: MATailoredOrderFlowMeasurementsViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MATailoredOrderFlowMeasurementsViewModel(.init(id: "",
                                                                   serviceType: .tailored,
                                                                   client: .init(id: "",
                                                                                 fullName: "",
                                                                                 phone: ""),
                                                                   cloathesName: "",
                                                                   cloathesDescription: "",
                                                                   estimatedDeliveryDate: "",
                                                                   shoulderMeasurement: 0,
                                                                   bustMeasurement: 0,
                                                                   lengthMeasurement: 0,
                                                                   waistMeasurement: 0,
                                                                   abdomenMeasurement: 0,
                                                                   hipsMeasurement: 0))
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.cloathesText, "Roupa")
        XCTAssertEqual(viewModel.tailoredText, "sob medida")
        XCTAssertEqual(viewModel.measurementsText, "Insira as medidas (em centímetros)")
        XCTAssertEqual(viewModel.shoulderText, "Ombro")
        XCTAssertEqual(viewModel.bustText, "Busto")
        XCTAssertEqual(viewModel.lengthText, "Comprimento")
        XCTAssertEqual(viewModel.waistText, "Cintura")
        XCTAssertEqual(viewModel.abdomenText, "Abdomên")
        XCTAssertEqual(viewModel.hipsText, "Quadril")
        XCTAssertEqual(viewModel.finishActionButtonText, "FINALIZAR")
    }

}
