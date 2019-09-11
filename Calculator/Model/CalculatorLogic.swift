//
//  CalculatorLogic.swift
//  Calculator
//

import Foundation

struct CalculatorLogic {
    
    private var number : Double?
    // Touple to store intermediate results
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
   
    // Set number
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    // Perform calculation
    mutating func performCalculation(with symbol: String) -> Double? {
        if let n = number {
            switch symbol {
                case "+/-":
                    return n * -1
                case "AC":
                    intermediateCalculation = nil
                    return 0
                case "%":
                    return n/100
                case "=":
                    return performTwoNumberCalculation(n2: n)
                // Default (+,-,x,/): save first number and calcMethod
                default:
                    let nTemp = performTwoNumberCalculation(n2: n)
                    intermediateCalculation = (nTemp != nil) ? (n1: nTemp!, calcMethod: symbol) : (n1: n, calcMethod: symbol)
                    return nTemp
            }
        }
        return nil
    }
    
    // Performs the actual calculation
    mutating func performTwoNumberCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            intermediateCalculation = nil
            switch operation {
                case "+": return n1 + n2
                case "-": return n1 - n2
                case "×": return n1 * n2
                case "÷": return n1 / n2
                default: fatalError("Operation not matching any of the case")
            }
        }
        return nil
    }
}
