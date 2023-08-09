//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Nicolas Hecker on 23/07/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

/**
 A test case class for testing the Calculator class functionality.
 */
final class CalculatorTestCase: XCTestCase {
    var calculator = Calculator()
    
    /**
         Helper method for testing calculations.
         
         - Parameters:
            - expression: The mathematical expression to calculate. Type : [String]
            - result: The expected result of the calculation. Type : Double
         */
    func calcul(expression: [String], result: Double) {
        var operationToReduce = expression
        var resultOfExpression: Double = 0.0
        
        while operationToReduce.count > 1 {
            
            print(operationToReduce)
            resultOfExpression = calculator.priorityCalculate(expression: operationToReduce)
            
            operationToReduce = calculator.removeElement(expression: &operationToReduce, result: resultOfExpression)
        }
        XCTAssertEqual(resultOfExpression, result)
    }
    
    func testCalculate15Plus5_WhenAdding_ThenResultIs20() {
        calcul(expression: ["15", "+", "5"], result: 20.0)
    }

    func testCalculate15Subtract5_WhenSubtracting_ThenResultIs10() {
        calcul(expression: ["15", "-", "5"], result: 10.0)
    }
    
    func testCalculate15Multiply5_WhenMultiplying_ThenResultIs75() {
        calcul(expression: ["15", "x", "5"], result: 75.0)
    }
    
    func testCalculate15Divide5_WhenDividing_ThenResultIs3() {
        calcul(expression: ["15", "÷", "5"], result: 3.0)
    }
    
    func testCalculate5Plus5Multiply5_WhenCorrectlyCalculating_ThenResultIs30() {
        calcul(expression: ["5", "+", "5", "x", "5"], result: 30.0)
    }
    
    func testCalculate5Plus5Divide5_WhenCorrectlyCalculating_ThenResultIs6() {
        calcul(expression: ["5", "+", "5", "÷", "5"], result: 6.0)
    }

    func testComplexCalculation_WhenCorrectlyCalculating_ThenResultIs22() {
        calcul(expression: ["4", "x", "2", "+", "7", "x", "2"], result: 22.0)
    }

    func testCalculationWithDivisionAndMultiplication_WhenCorrectlyCalculating_ThenResultIs20() {
        calcul(expression: ["5", "+", "6", "÷", "2", "x", "5"], result: 20.0)
    }
    
    func testExpressionIsCorrect_WhenVerifyingIsCorrect_ThenBoolIsTrue() {
        let expressionIsCorrect = calculator.expressionIsCorrect
        
        XCTAssertTrue(expressionIsCorrect)
    }
    
    func testExpressionHaveEnoughElement_WhenVerifyingIsCorrect_ThenBoolIsFalse() {
        let expressionIsCorrect = calculator.expressionHaveEnoughElement
        
        XCTAssertFalse(expressionIsCorrect)
    }

    func testExpressionHaveResult_WhenVerifyingHaveResult_ThenBoolIsFalse() {
        let expressionHaveResult = calculator.expressionHaveResult
        
        XCTAssertFalse(expressionHaveResult)
    }

    func testCanAddOperator_WhenVerifyingCanAddOperator_ThenBoolIsTrue() {
        let expressionHaveResult = calculator.canAddOperator
        
        XCTAssertTrue(expressionHaveResult)
    }
}
