//
//  MANewOrderViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MANewOrderViewModelTests: XCTestCase {
    
    var viewModel: MANewOrderViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MANewOrderViewModel()
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.createText, "Criar")
        XCTAssertEqual(viewModel.newOrderText, "novo pedido")
        XCTAssertEqual(viewModel.serviceTypeText, "Selecione o tipo de serviço:")
        XCTAssertEqual(viewModel.service1Text, "Roupa sob medida")
        XCTAssertEqual(viewModel.service2Text, "Ajuste/Conserto de roupa")
        XCTAssertEqual(viewModel.clientSelectionText, "Selecione o cliente:")
        XCTAssertEqual(viewModel.newClientText, "Adicionar novo cliente")
        XCTAssertEqual(viewModel.continueActionText, "CONTINUAR")
    }

}
