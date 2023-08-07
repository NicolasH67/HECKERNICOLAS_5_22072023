//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
    
    func updateDisplay(text: String) {
        textView.text = text
    }
    
    func displayAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var textView: UITextView!
    
    private let calculator = Calculator()
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        
        calculator.tappedNumberButton(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let mathOperator = sender.title(for: .normal) else { return }
        
        calculator.tappedOperatorButton(mathOperator)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappedEqualButton()
    }
}

