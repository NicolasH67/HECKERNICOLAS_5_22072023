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
    //MARK: - Methode
    
    private func makeSUT() -> (sut: Calculator, spy: CalculatorDelegateSpy) {
        let spy = CalculatorDelegateSpy()
        let sut = Calculator()
        sut.delegate = spy
        return (sut, spy)
    }

    // MARK: - Test
    
    func testCalculate15Plus5_WhenAdding_ThenResultIs20() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("1")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "15 + 5 = 20.0")
    }

    func testCalculate15Subtract5_WhenSubtracting_ThenResultIs10() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("1")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("-")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "15 - 5 = 10.0")
    }

    func testCalculate15Multiply5_WhenMultiplying_ThenResultIs75() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("1")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("x")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "15 x 5 = 75.0")
    }

    func testCalculate15Divide5_WhenDividing_ThenResultIs3() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("1")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("÷")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "15 ÷ 5 = 3.0")
    }

    func testCalculate5Plus5Multiply5_WhenCorrectlyCalculating_ThenResultIs30() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("x")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "5 + 5 x 5 = 30.0")
    }

    func testCalculate5Plus5Divide5_WhenCorrectlyCalculating_ThenResultIs6() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("÷")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.text, "5 + 5 ÷ 5 = 6.0")
    }

    func testCalculationWithDivisionAndMultiplication_WhenCorrectlyCalculating_ThenResultIs20() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("6")
        sut.tappedOperatorButton("÷")
        sut.tappedNumberButton("2")
        sut.tappedOperatorButton("x")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
    
        XCTAssertEqual(spy.text, "5 + 6 ÷ 2 x 5 = 20.0")
    }
    
    func testGivenHaveExpression_WhenWantReset_ThenTextIsReset() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("2")
        sut.tappedOperatorButton("x")
        sut.tappedNumberButton("5")
        sut.tappedResetButton()
        
        XCTAssertEqual(spy.text, "")
    }

    func testGivenInvalidExpression_WhenEvaluatingExpression_ThenErrorMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.message, "le calcul n'est pas correct")
    }

    func testGivenIncompleteExpression_WhenEvaluatingExpression_ThenIncompleteExpressionMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("6")
        
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.message, "le calcul n'est pas complet")
    }

    func testGivenExpressionWithResult_WhenEvaluatingExpression_ThenExistingResultMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        sut.tappedEqualButton()
        
        XCTAssertEqual(spy.message, "L'expression a déjà un résultat. Veuillez entrer un nouveau calcul.")
    }

    func testGivenOperatorAlreadyPresent_WhenAddingOperator_ThenErrorMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedOperatorButton("-")

        XCTAssertEqual(spy.text, "5 + ")

        XCTAssertEqual(spy.message, "Un opérateur est déjà en place !")
    }
    
    func testGivenTextIsEmpty_WhenAddingOperator_ThenErrorMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedOperatorButton("x")
        
        XCTAssertEqual(spy.message, "Veuillez entrer un chiffre avant l'opérateur.")
    }
    
    func testGivenExpressionHaveResult_WhenAddingOperator_ThenErrorMessageDisplayed() {
        let (sut, spy) = makeSUT()
        sut.tappedNumberButton("1")
        sut.tappedNumberButton("5")
        sut.tappedOperatorButton("+")
        sut.tappedNumberButton("5")
        sut.tappedEqualButton()
        
        sut.tappedOperatorButton("+")
        
        XCTAssertEqual(spy.message, "L'expression a déjà un résultat. Veuillez entrer un nouveau calcul.")
    }
}
