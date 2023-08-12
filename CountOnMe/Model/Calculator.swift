//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Hecker on 23/07/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

// MARK: - CalculatorDelegate

/// A protocol that defines delegate methods for updating display text and displaying alerts in the Calculator module.
protocol CalculatorDelegate {
    func updateDisplay(text: String)
    func displayAlert(message: String)
}

final class Calculator {
    
    // MARK: - Properties
    
    /// The delegate that will be notified of updates and alters from the calculator.
    var delegate: CalculatorDelegate?
    
    /// The current text representing the user's input and calculated expression.
    var text: String = "" {
        didSet {
            delegate?.updateDisplay(text: text)
        }
    }
    
    /// An array of elements obtained by splitting the 'text' at spaces.
    var elements: [String] {
        text.split(separator: " ").map { "\($0)" }
    }
    
    /// Checks if the expression has enough elements to perform calculations.
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    /// Checks if an operator can be added to the expression.
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    /// Checks if the expression contains a result.
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    /// Checks if the expression is currently correct and can be evaluated.
    var expressionIsCorrect: Bool {
        return (elements.last != "+") && (elements.last != "-") && (elements.last != "x") && (elements.last != "÷")
    }
    
    // MARK: - Methods
    
    /// Handles the tap event on a number button
    func tappedNumberButton(_ number: String) {
        if expressionHaveResult {
            text = ""
        }
        text.append(number)
    }
    
    /// Handles the tap event on an operator button
    func tappedOperatorButton(_ mathOperator: String) {
        if canAddOperator {
            text.append(" \(mathOperator) ")
        } else {
            delegate?.displayAlert(message: "Un operateur est déjà mis !")
        }
    }
    
    /// Handles the tap event on the equal button
    func tappedEqualButton() {
        evaluateExpression()
    }
    
    func tappedResetButton() {
        text = ""
    }
    
    /// Evaluate the expression and updates the display
    func evaluateExpression(){
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Verification
        
        guard expressionIsCorrect else {
            delegate?.displayAlert(message: "le calcul n'est pas correct")
            return
        }
        
        guard expressionHaveEnoughElement else {
            delegate?.displayAlert(message: "le calcul n'est pas complet")
            return
        }
        
        guard !expressionHaveResult else {
            delegate?.displayAlert(message: "L'expression à deja un résultat, tappez un nouveau calcule")
            return
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            print(operationsToReduce)
            
            operationsToReduce = priorityCalculate(expression: operationsToReduce)
            if operationsToReduce.count > 2 {
                if let result = formCalculation(expression: operationsToReduce, index: 1) {
                    updateExpression(&operationsToReduce, atIndex: 1, withResult: result)
                }
            }
        }
        text.append(" = ")
        text.append(operationsToReduce[0])
    }
        
    /**
     Calculates the result of a mathematical operation between two numbers.
         
     - Parameters:
        - left: The left operand of the operation. Type : Double
        - operand: The operator indicating the type of operation. Type : String
        - right: The right operand of the operation. Type : Double
     
     - Returns: The result of the operation. Type : Double
     */
    private func calcul(left: Double, operand: String, right: Double) -> Double? {
        var result: Double
        switch operand {
        case "x": result = left * right
        case "÷": result = left / right
        case "+": result = left + right
        case "-": result = left - right
        default: return nil
        }
        return result
    }
        
    /**
    Calculates the result of the highest priority operation in the expression.
     
     - Parameter expression: The array of expression elements. Type : [String]
     - Returns: The array with the updated expression after performing the highest priority operation.
    */
    func priorityCalculate(expression: [String]) -> [String] {
        var expression = expression
        
        while expression.contains("x") || expression.contains("÷") {
            if let index = expression.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                if let result = formCalculation(expression: expression, index: index) {
                    updateExpression(&expression, atIndex: index, withResult: result)
                }
            }
        }
        return expression
    }
    
    /**
     Performs a calculation based on the elements at a specified index in the expression.
     - Parameters:
        - expression: The array of expression elements.
        - index: The index indicating the position of the operator.
     
     - Returns: The result of the calculation.
    */
    func formCalculation(expression: [String], index: Int) -> Double? {
        if let left = Double(expression[index - 1]), let right = Double(expression[index + 1]) {
            let operand = expression[index]
            let result = calcul(left: left, operand: operand, right: right)
            
            return result
        }
        return nil
    }
    
    /**
     Updates the expression array after a processed operation with the result.
     
     - Parameters:
        - expression: The INOUT array of expression elements. Type : [String]
        - index: The index indicating the position of the operator. Type : Int
        - result: The result of the processed operation. Type : Double
     */
    func updateExpression(_ expression: inout [String], atIndex index: Int, withResult result: Double) {
        expression.remove(at: index)
        expression.remove(at: index)
        expression.remove(at: index - 1)
        expression.insert("\(result)", at: index - 1)
    }
}
