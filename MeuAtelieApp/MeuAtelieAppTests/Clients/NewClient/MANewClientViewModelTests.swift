//
//  MANewClientViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MANewClientViewModelTests: XCTestCase {
    
    var viewModel: MANewClientViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MANewClientViewModel()
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.createText, "Adicionar")
        XCTAssertEqual(viewModel.newClientText, "novo cliente")
        XCTAssertEqual(viewModel.fullNameText, "Nome completo")
        XCTAssertEqual(viewModel.phoneText, "Telefone")
        XCTAssertEqual(viewModel.createActionText, "CADASTRAR")
        XCTAssertEqual(viewModel.importClientActionText, "IMPORTAR CLIENTE")
        XCTAssertEqual(viewModel.backText, "Voltar")
    }

}
