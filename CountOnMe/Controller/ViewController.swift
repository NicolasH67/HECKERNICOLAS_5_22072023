//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
    
    // MARK: - IBOutlet
    
    /**
     This IBOutlet is used to establish a weak connection to a UITextView in the Interface Builder.
     It allows the code to access and manipulate the properties and content of the connected UITextView.
    */
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    
    /**
     An instance of the Calculator class used for performing calculations and managing related functionality.
    */
    private let calculator = Calculator()
    
    // MARK: - IBAction
    
    /**
     IBAction triggered when a number button is tapped. It retrieves the title of the tapped button,
     representing a number, and informs the calculator instance to process the tapped number.
     
     - Parameter sender: The UIButton that triggered the action.
    */
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        
        calculator.tappedNumberButton(numberText)
    }
    
    /**
     IBAction triggered when an operator button is tapped. It retrieves the title of the tapped button,
     representing a mathematical operator, and informs the calculator instance to process the tapped operator.
     
     - Parameter sender: The UIButton that triggered the action.
    */
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let mathOperator = sender.title(for: .normal) else { return }
        
        calculator.tappedOperatorButton(mathOperator)
    }
    
    /**
     IBAction triggered when the equal button is tapped. It informs the calculator instance to perform
     the calculation based on the entered expression.
     
     - Parameter sender: The UIButton that triggered the action.
    */
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappedEqualButton()
    }
    
    @IBAction func tappedResetButton(_ sender: Any) {
        calculator.tappedResetButton()
    }
    
}

// MARK: - Delegate Pattern

extension ViewController: CalculatorDelegate {
    /**
     This method is called to update the content of the text display in a UITextView.
     
     - Parameters:
        - text: The text to be displayed in the UITextView.
    */
    func updateDisplay(text: String) {
        textView.text = text
    }
    
    /**
     This method is used to display a modal alert with a given message.
     
     - Parameters:
        - message: The message to be displayed in the alert.
    */
    func displayAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertVC, animated: true)
    }
}
