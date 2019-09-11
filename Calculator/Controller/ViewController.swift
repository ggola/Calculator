//
//  ViewController.swift
//  Calculator
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var number: [String] = [String]()
    private var isFinishedTypingNumber: Bool = true
    var isDot = false
    
    // Computed property
    var displayValue: Double {
        // GETTER: gets the displayLabel.text! and turns into a Double
        get {
            guard let value = Double(displayLabel.text!) else { fatalError("Double casting failed. Text in display = \(displayLabel.text!)")}
            return value
        }
        // SETTER: sets display text label whenever a new value of displayValue is set
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    // MARK: - Perform calculation (non-number button is pressed)
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        isDot = false
        // Perform operations
        if let calcMethod = sender.currentTitle {
            // Tell the calculator which number we are working with (the value of displayValue is given in the GET)
            calculator.setNumber(displayValue)
            if let result = calculator.performCalculation(with: calcMethod) {
                displayLabel.text = (floor(result) == result) ? String(Int(result)) : String(Float(result))
            }
        }
    }

    // MARK: - What should happen when a number is entered into the keypad
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                if numValue == "." {
                    // If the first thing to be typed is "." then set the display text to "0."
                    displayLabel.text = "0" + numValue
                    isDot = true
                } else {
                    displayLabel.text = numValue
                }
                isFinishedTypingNumber = false
            } else {
                // Make sure that if we have an integer we can click the "." button, and if we have already inserted the "." we cannot click it anymore until we eventually erase it.
                if numValue == "." {
                    if isDot == false {
                        displayLabel.text = displayLabel.text! + numValue
                        isDot = true
                    }
                } else {
                    displayLabel.text = displayLabel.text! + numValue
                }
            }
            // Guard against some nil values when casting displyLabel.text!
            guard Double(displayLabel.text!) != nil else { fatalError("Casting to double failed.") }
        }
    }
}

