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
    var text: String = ""
    
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
        return elements.last != "+" && elements.last != "-"
    }
    
    /// Checks if the expression contains a result.
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    /// Checks if the expression is currently correct and can be evaluated.
    var expressionIsCorrect: Bool {
        return (elements.last != "+") && (elements.last != "-")
    }
    
    // MARK: - Methods
    
    /// Handles the tap event on a number button
    func tappedNumberButton(_ number: String) {
        if expressionHaveResult {
            text = ""
        }
        text.append(number)
        delegate?.updateDisplay(text: text)
    }
    
    /// Handles the tap event on an operator button
    func tappedOperatorButton(_ mathOperator: String) {
        if canAddOperator {
            text.append(" \(mathOperator) ")
            delegate?.updateDisplay(text: text)
        } else {
            delegate?.displayAlert(message: "Un operateur est déja mis !")
        }
    }
    
    /// Handles the tap event on the equal button
    func tappedEqualButton() {
        evaluateExpression()
    }
    
    /// Evaluate the expression and updates the display
    func evaluateExpression(){
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Verification
        
        guard expressionIsCorrect else {
            delegate?.displayAlert(message: "expressionIsNotCorrect")
            return
        }
        
        guard expressionHaveEnoughElement else {
            delegate?.displayAlert(message: "expressionDontHaveEnoughElement")
            return
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var result: Double = 0.0
            
            print(operationsToReduce)
            result = priorityCalculate(expression: operationsToReduce)
            
            operationsToReduce = removeElement(expression: &operationsToReduce, result: result)
        }
        text.append(" = ")
        text.append(operationsToReduce[0])
        delegate?.updateDisplay(text: text)
    }
        
    /**
     Calculates the result of a mathematical operation between two numbers.
         
     - Parameters:
        - left: The left operand of the operation. Type : Double
        - operand: The operator indicating the type of operation. Type : String
        - right: The right operand of the operation. Type : Double
     
     - Returns: The result of the operation. Type : Double
     */
    private func calcul(left: Double, operand: String, right: Double) -> Double {
        var result: Double
        switch operand {
        case "x": result = left * right
        case "÷": result = left / right
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }
        return result
    }
        
    /**
    Calculates the result of the highest priority operation in the expression.
     
     - Parameter expression: The array of expression elements. Type : [String]
     - Returns: The result of the highest priority operation. Type : Double
    */
    private func priorityCalculate(expression: [String]) -> Double {
        let result: Double = 0.0
        if !expression.contains("+") && !expression.contains("-") {
            if let result = formCalculation(expression: expression, index: 1) {
                return result
            }
        } else if expression.contains("+") || expression.contains("-") && expression.contains("x") && expression.contains("÷") {
            if let indexMultiplication = expression.firstIndex(of: "x"), let indexDivision = expression.firstIndex(of: "÷") {
                let index = min(indexMultiplication, indexDivision)
                if let result = formCalculation(expression: expression, index: index) {
                    return result
                }
            }
        } else if expression.contains("x") {
            if let index = expression.firstIndex(of: "x") {
                if let result = formCalculation(expression: expression, index: index) {
                    return result
                }
            }
        } else if expression.contains("÷") {
            if let index = expression.firstIndex(of: "÷") {
                if let result = formCalculation(expression: expression, index: index) {
                    return result
                }
            }
        } else {
            if let result = formCalculation(expression: expression, index: 1) {
                return result
            }
        }
        return result
    }
        
    /**
     Removes the elements of a processed operation and inserts the result into the expression.
     
     - Parameters:
        - expression: The inout array of expression elements. Type : [String]
        - result: The result of the processed operation. Type : Double
     - Returns: The modified expression array. Type [String]
    */
    private func removeElement(expression: inout [String], result: Double) -> [String]{
        if !expression.contains("+") && !expression.contains("-") {
            expression = Array(expression.dropFirst(3))
            expression.insert("\(result)", at: 0)
        } else if expression.contains("+") || expression.contains("-") && expression.contains("x") && expression.contains("÷") {
            if let indexMultiplication = expression.firstIndex(of: "x"), let indexDivision = expression.firstIndex(of: "÷") {
                let index = min(indexMultiplication, indexDivision)
                updateExpression(&expression, atIndex: index, withResult: result)
            }
        } else if expression.contains("x") {
            if let index = expression.firstIndex(of: "x") {
                updateExpression(&expression, atIndex: index, withResult: result)
            }
        } else if expression.contains("÷"){
            if let index = expression.firstIndex(of: "÷") {
                updateExpression(&expression, atIndex: index, withResult: result)
            }
        } else {
            expression = Array(expression.dropFirst(3))
            expression.insert("\(result)", at: 0)
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
        guard let left = Double(expression[index - 1]), let right = Double(expression[index + 1]) else {
            return nil
        }
        let operand = expression[index]
        let result = calcul(left: left, operand: operand, right: right)
        
        return result
    }
    
    /**
     Updates the expression array after a processed operation with the result.
     
     - Parameters:
        - expression: The inout array of expression elements. Type : [String]
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
