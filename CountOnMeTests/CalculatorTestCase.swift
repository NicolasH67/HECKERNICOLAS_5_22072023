//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Nicolas Hecker on 23/07/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

final class CalculatorTestCase: XCTestCase {
    var calculator = Calculator()
//    
//    func calcul(expression: String, result: String) {
//        let funcResult = calculator.evaluateExpression()
//        
//        XCTAssertEqual(funcResult, result)
//    }
    
//    func testGivenCalculate15Plus5_WhenAdd_ThenResultIs20() {
//        calculator.text = "5 + 15"
//
//        let result = calculator.tappedEqualButton()
//
//        XCTAssertEqual(result, "20.0")
//    }
//    
//    func testGivenCalculate15Substract5_WhenAdd_ThenResultIs10() {
//        calcul(expression: "15 - 5", result: "10.0")
//    }
//    
//    func testGivenCalculate15Multiply5_WhenAdd_ThenResultIs75() {
//        calcul(expression: "15 x 5", result: "75.0")
//    }
//    
//    func testGivenCalculate15Divise5_WhenAdd_ThenResultIs3() {
//        calcul(expression: "15 ÷ 5", result: "3.0")
//    }
//    
//    func testGivenCalculate5Plus5Multiply5_WhenCorrectCalculate_ThenResultIs30() {
//        calcul(expression: "5 + 5 x 5", result: "30.0")
//    }
//    
//    func testGivenCalculate5Plus5Divise5_WhenCorrectCalculate_ThenResultIs6() {
//        calcul(expression: "5 + 5 ÷ 5", result: "6.0")
//    }
//    
//    func testGivenComplexeCalcule_WhenCorrectCalculate_ThenResultIs22() {
//        calcul(expression: "4 x 2 + 7 x 2", result: "22.0")
//    }
    
    func testGivenHaveExpressionCorrect_WhenVerifyIsCorrect_ThenBoolIsTrue() {
        let expressionIsCorrect = calculator.expressionIsCorrect
        
        XCTAssertTrue(expressionIsCorrect)
    }
    
    func testGivenExpressionHaveEnoughElement_WhenVerifyIsCorrect_ThenBoolIsTrue() {
        let expressionIsCorrect = calculator.expressionHaveEnoughElement
        
        XCTAssertFalse(expressionIsCorrect)
    }

    func testGivenExpressionHaveResult_WhenVerifyHaveResult_ThenBoolIsTrue() {
        let expressionHaveResult = calculator.expressionHaveResult
        
        XCTAssertFalse(expressionHaveResult)
    }

    func testGivenCanAddOperator_WhenVerifyCanAddOperator_ThenBoolIsTrue() {
        let expressionHaveResult = calculator.canAddOperator
        
        XCTAssertTrue(expressionHaveResult)
    }
}
