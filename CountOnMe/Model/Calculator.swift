//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Hecker on 23/07/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func updateDisplay(text: String)
    func displayAlert(message: String)
}

final class Calculator {
    var delegate: CalculatorDelegate?
    
    var text: String = ""
    
    var elements: [String] {
        text.split(separator: " ").map { "\($0)" }
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    var expressionIsCorrect: Bool {
        return (elements.last != "+") && (elements.last != "-")
    }
    
    func tappedNumberButton(_ number: String) {
        if expressionHaveResult {
            text = ""
        }
        text.append(number)
        delegate?.updateDisplay(text: text)
    }
    
    func tappedOperatorButton(_ mathOperator: String) {
        if canAddOperator {
            text.append(" \(mathOperator) ")
            delegate?.updateDisplay(text: text)
        } else {
            delegate?.displayAlert(message: "Un operateur est déja mis !")
        }
    }
    
    func tappedEqualButton() {
        evaluateExpression()
    }
    
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
        
    private func priorityCalculate(expression: [String]) -> Double {
        var result: Double = 0.0
        
        if expression.contains("x") {
            if let index = expression.firstIndex(of: "x") {
                result = formCalculation(expression: expression, index: index)
            }
        } else if expression.contains("÷") {
            if let index = expression.firstIndex(of: "÷") {
                result = formCalculation(expression: expression, index: index)
            }
        } else {
            result = formCalculation(expression: expression, index: 1)
        }
        return result
    }
        
    private func removeElement(expression: inout [String], result: Double) -> [String]{
        if expression.contains("x") {
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
    
    func formCalculation(expression: [String], index: Int) -> Double {
        let left = Double(expression[index - 1])!
        let operand = expression[index]
        let right = Double(expression[index + 1])!
        let result = calcul(left: left, operand: operand, right: right)
        
        return result
    }
    
    func updateExpression(_ expression: inout [String], atIndex index: Int, withResult result: Double) {
        expression.remove(at: index)
        expression.remove(at: index)
        expression.remove(at: index - 1)
        expression.insert("\(result)", at: index - 1)
    }
}
