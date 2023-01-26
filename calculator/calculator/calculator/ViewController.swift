//
//  ViewController.swift
//  calculator
//
//  Created by Usuario on 12/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    
    var op: Int = -1
    var floating: Bool = false
    var result: Float = 0
    var n1: String = ""
    var n2: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        labelResult.text = "0"
    }
    
    private func normalizeFloat(_ f: String) -> String {
        if (f.hasSuffix(".0")) { return String (f.dropLast(2)) }
        else { return f }
    }
        
    private func updateText() {
        var txt = normalizeFloat(n1)
        if (op >= 0) {
            var opTxt = ""
            switch op {
            case 0: opTxt = "+"
            case 1: opTxt = "-"
            case 2: opTxt = "*"
            case 3: opTxt = "/"
            default: opTxt = "Da fuk"
            }
            txt += "\(opTxt)" + normalizeFloat(n2)
            
        }
        labelResult.text = txt
    }

    @IBAction func onClickClear(_ sender: UIButton) {
        result = 0
        n1 = ""
        n2 = ""
        op = -1
        labelResult.text = "0"
    }
    
    @IBAction func onClickDecimal(_ sender: UIButton) {
        if (floating) { return }
        if (op == -1) { n1 += "." }
        else { n2 += "." }
        floating = true
        updateText()
    }
    
    @IBAction func onClickDigit(_ sender: UIButton) {
        if (op == -1) {
            n1 += "\(sender.tag)"
        } else {
            n2 += "\(sender.tag)"
        }
        updateText()
    }
    
    @IBAction func onClickOperation(_ sender: UIButton) {
        op = sender.tag
        floating = false
        updateText()
    }
    
    @IBAction func onClickResult(_ sender: UIButton) {
        switch op {
        case 0: result = Float (n1)! + Float (n2)!
        case 1: result = Float (n1)! - Float (n2)!
        case 2: result = Float (n1)! * Float (n2)!
        case 3: result = Float (n1)! / Float (n2)!
        default: result = 0
        }
        
        n1 = "\(result)"
        n2 = ""
        op = -1
        floating = false
        labelResult.text = normalizeFloat("\(result)")
    }
    
}
