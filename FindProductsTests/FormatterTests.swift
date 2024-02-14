//
//  FormatterTests.swift
//  FindProductsTests
//
//  Created by Hilario Cuervo on 12/02/2024.
//

import XCTest
@testable import FindProducts

final class FormatterTests: XCTestCase {
    
    private var sutDouble: Double!

    override func setUpWithError() throws {
        sutDouble = 19470000
    }

    override func tearDownWithError() throws {
        sutDouble = nil
    }
    
    func testDoubleToStringPrice() {
        let actual = sutDouble.toFormattedStringPrice(currency: "ARS")
        let expected = "ARS 19.470.000"
        
        XCTAssertEqual(actual, expected)
    }
}
