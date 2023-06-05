//
//  MALoginViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MALoginViewModelTests: XCTestCase {

    var viewModel: MALoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MALoginViewModel()
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
        XCTAssertEqual(viewModel.loginText, "Login")
        XCTAssertEqual(viewModel.passwordText, "Senha")
        XCTAssertEqual(viewModel.enterText, "ENTRAR")
        XCTAssertEqual(viewModel.registerText, "Não tem conta? Cadastre-se!")
    }

}
