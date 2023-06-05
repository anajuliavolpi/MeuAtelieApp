//
//  MAClientDetailsViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAClientDetailsViewModelTests: XCTestCase {
    
    var viewModel: MAClientDetailsViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MAClientDetailsViewModel("")
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.clientServicesText, "SERVIÇOS CONTRATADOS")
        XCTAssertEqual(viewModel.editClientText, "EDITAR CLIENTE")
        XCTAssertEqual(viewModel.deleteClientText, "DELETAR CLIENTE")
    }

}
