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
    
    //MARK: - Properties
    
    var calculator: Calculator!
    var spy: CalculatorDelegateSpy!
    
    //MARK: - Override
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
        spy = CalculatorDelegateSpy()
        calculator.delegate = spy
    }
    
    //MARK: - Methode
    
    func simpleCalcul(operand: String, result: Double) {
        calculator.tappedNumberButton("1")
        calculator.tappedNumberButton("5")
        calculator.tappedOperatorButton(operand)
        calculator.tappedNumberButton("5")
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "15 \(operand) 5 = \(result)")
    }
    
    func complexeCalcul(operand: String, result: Double) {
        calculator.tappedNumberButton("5")
        calculator.tappedOperatorButton("+")
        calculator.tappedNumberButton("5")
        calculator.tappedOperatorButton(operand)
        calculator.tappedNumberButton("5")
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "5 + 5 \(operand) 5 = \(result)")
    }
    
    func testCalculate15Plus5_WhenAdding_ThenResultIs20() {
        simpleCalcul(operand: "+", result: 20.0)
    }

    func testCalculate15Subtract5_WhenSubtracting_ThenResultIs10() {
        simpleCalcul(operand: "-", result: 10.0)
    }

    func testCalculate15Multiply5_WhenMultiplying_ThenResultIs75() {
        simpleCalcul(operand: "x", result: 75.0)
    }

    func testCalculate15Divide5_WhenDividing_ThenResultIs3() {
        simpleCalcul(operand: "÷", result: 3.0)
    }

    func testCalculate5Plus5Multiply5_WhenCorrectlyCalculating_ThenResultIs30() {
        complexeCalcul(operand: "x", result: 30.0)
    }

    func testCalculate5Plus5Divide5_WhenCorrectlyCalculating_ThenResultIs6() {
        complexeCalcul(operand: "÷", result: 6.0)
    }

    func testCalculationWithDivisionAndMultiplication_WhenCorrectlyCalculating_ThenResultIs20() {
        calculator.tappedNumberButton("5")
        calculator.tappedOperatorButton("+")
        calculator.tappedNumberButton("6")
        calculator.tappedOperatorButton("÷")
        calculator.tappedNumberButton("2")
        calculator.tappedOperatorButton("x")
        calculator.tappedNumberButton("5")
        calculator.tappedEqualButton()
    
        XCTAssertEqual(calculator.text, "5 + 6 ÷ 2 x 5 = 20.0")
    }
    
    func testGivenHaveExpression_WhenWantReset_ThenTextIsReset() {
        calculator.tappedNumberButton("2")
        calculator.tappedOperatorButton("x")
        calculator.tappedNumberButton("5")
        calculator.tappedResetButton()
        
        XCTAssertEqual(calculator.text, "")
    }

    func testGivenInvalidExpression_WhenEvaluatingExpression_ThenErrorMessageDisplayed() {
        calculator.text = "5 + 5 +"
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(spy.displayedMessages, ["le calcul n'est pas correct"])
    }

    func testGivenIncompleteExpression_WhenEvaluatingExpression_ThenIncompleteExpressionMessageDisplayed() {
        calculator.tappedNumberButton("6")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(spy.displayedMessages, ["le calcul n'est pas complet"])
    }

    func testGivenExpressionWithResult_WhenEvaluatingExpression_ThenExistingResultMessageDisplayed() {
        calculator.text = "5 + 3 = 8"
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(spy.displayedMessages, ["L'expression à deja un résultat, tappez un nouveau calcule"])
    }

    func testGivenOperatorAlreadyPresent_WhenAddingOperator_ThenErrorMessageDisplayed() {
        calculator.tappedOperatorButton("+")
        calculator.tappedOperatorButton("-")

        XCTAssertEqual(calculator.text, " + ")

        XCTAssertEqual(spy.displayedMessages, ["Un operateur est déjà mis !"])
    }
}
