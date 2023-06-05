//
//  MANewPasswordViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MANewPasswordViewModelTests: XCTestCase {
    
    var viewModel: MANewPasswordViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MANewPasswordViewModel()
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.changePasswordText, "Trocar")
        XCTAssertEqual(viewModel.changePasswordSubtext, "SENHA")
        XCTAssertEqual(viewModel.insertNewPasswordText, "Insira a nova senha")
        XCTAssertEqual(viewModel.newPasswordText, "Nova Senha")
        XCTAssertEqual(viewModel.cancelText, "CANCELAR")
        XCTAssertEqual(viewModel.changeText, "ATUALIZAR")
        XCTAssertEqual(viewModel.confirmationAlertText, "Tem certeza que deseja alterar sua senha?")
    }

}
