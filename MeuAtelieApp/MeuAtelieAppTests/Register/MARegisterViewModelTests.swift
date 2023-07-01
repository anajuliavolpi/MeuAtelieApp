//
//  MARegisterViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MARegisterViewModelTests: XCTestCase {

    var viewModel: MARegisterViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MARegisterViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBackgroundColors() throws {
        XCTAssertTrue(viewModel.backgroundColors.contains(.MAColors.MAPinkLightStrong))
        XCTAssertTrue(viewModel.backgroundColors.contains(.MAColors.MAPinkLight))
        XCTAssertTrue(viewModel.backgroundColors.contains(.MAColors.MAPinkLightMedium))
    }

    func testTexts() throws {
        XCTAssertEqual(viewModel.fillYourDataText, "Preencha seus dados")
        XCTAssertEqual(viewModel.emailText, "Email")
        XCTAssertEqual(viewModel.passwordText, "Senha")
        XCTAssertEqual(viewModel.firstNameText, "Primeiro nome")
        XCTAssertEqual(viewModel.lastNameText, "Último nome")
        XCTAssertEqual(viewModel.registerText, "CADASTRAR")
    }
    
}
