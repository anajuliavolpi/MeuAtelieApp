//
//  MAClientsViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAClientsViewModelTests: XCTestCase {

    var viewModel: MAClientsViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MAClientsViewModel()
    }
    
    func testTexts() throws {
        XCTAssertEqual(viewModel.viewTitle, "Clientes")
        XCTAssertEqual(viewModel.newClientText, "+")
    }

}
