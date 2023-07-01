//
//  MAHomeViewModelTests.swift
//  MeuAtelieAppTests
//
//  Created by Ana Júlia Volpi on 05/06/23.
//

import XCTest
@testable import MeuAtelieApp

final class MAHomeViewModelTests: XCTestCase {

    var viewModel: MAHomeViewModel!
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = MAHomeViewModel()
    }
    
    func testText() throws {
        XCTAssertEqual(viewModel.viewTitle, "Pedidos")
    }

}
