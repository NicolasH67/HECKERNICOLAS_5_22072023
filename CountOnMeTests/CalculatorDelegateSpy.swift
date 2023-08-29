//
//  CalculatorDelegateSpy.swift
//  CountOnMeTests
//
//  Created by Nicolas Hecker on 17/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe


// MARK: - Spy

/// The CalculatorDelegateSpy class implements the CalculatorDelegate protocol and provides a way to track displayed messages for testing purposes.
class CalculatorDelegateSpy: CalculatorDelegate {
    
    private(set) var text = ""
    private(set) var message = ""
    func updateDisplay(text: String) {
        self.text = text
    }
    
    func displayAlert(message: String) {
        self.message = message
    }
}
