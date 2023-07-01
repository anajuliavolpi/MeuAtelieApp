//
//  MATailoredOrderFlowViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MATailoredOrderFlowViewModelTests: XCTestCase {
    
    var viewModel: MATailoredOrderFlowViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MATailoredOrderFlowViewModel(.init(id: "",
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
        XCTAssertEqual(viewModel.cloathesNameText, "Nome da peça")
        XCTAssertEqual(viewModel.cloathesNamePlaceholder, "Nome")
        XCTAssertEqual(viewModel.cloathesDescriptionText, "Descrição da peça")
        XCTAssertEqual(viewModel.cloathesDescriptionPlaceholder, "Descrição")
        XCTAssertEqual(viewModel.estimatedDeliveryDateText, "Data de entrega prevista")
        XCTAssertEqual(viewModel.continueActionButtonText, "CONTINUAR")
    }
    
}
