//
//  MAProfileViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAProfileViewModelTests: XCTestCase {

    var viewModel: MAProfileViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MAProfileViewModel()
    }

    func testTexts() throws {
        XCTAssertEqual(viewModel.helloText, "Olá,")
        XCTAssertEqual(viewModel.checkYourDataText, "CONFIRA SEUS DADOS:")
        XCTAssertEqual(viewModel.emailText, "Email:")
        XCTAssertEqual(viewModel.nameText, "Nome:")
        XCTAssertEqual(viewModel.changePasswordText, "ALTERAR SENHA")
        XCTAssertEqual(viewModel.exitText, "Sair")
    }
    
}
