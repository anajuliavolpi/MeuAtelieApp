//
//  MAEditClientViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAEditClientViewModelTests: XCTestCase {
    
    var viewModel: MAEditClientViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MAEditClientViewModel(clientID: "")
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.editText, "Editar")
        XCTAssertEqual(viewModel.clientText, "cliente")
        XCTAssertEqual(viewModel.saveText, "SALVAR")
        XCTAssertEqual(viewModel.fullNameText, "Nome completo")
        XCTAssertEqual(viewModel.phoneText, "Telefone")
    }

}
