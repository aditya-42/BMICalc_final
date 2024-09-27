//
//  ViewController.swift
//  BMICalc
//
//  Created by Aditya Sanjeev Purohit on 2024-09-20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var inchesLabel: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitSwitch: UISwitch!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightInput: UITextField!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightInput: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var BMIcategoryLabel: UILabel!
    
    
    @IBOutlet weak var metricSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heightInput.placeholder="centimeters"
        weightInput.placeholder="kilograms"
        inchesLabel.isHidden=true
        errorLabel.isHidden=true;
        
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        if unitSwitch.isOn{
            
            unitLabel.text="Metric"
            inchesLabel.isHidden=true
            
            heightInput.text=""
            weightInput.text=""
            BMILabel.text="BMI :"
            errorLabel.text=""
            BMIcategoryLabel.text="BMI Category :"
            heightInput.placeholder="centimeters"
            weightInput.placeholder="kilograms"
            
            
        }
        
        else{
            
            unitLabel.text="Imperial"
            inchesLabel.isHidden=false
            errorLabel.text=""
            heightInput.text=""
            inchesLabel.text=""
            weightInput.text=""
            BMILabel.text="BMI :"
            BMIcategoryLabel.text="BMI Category :"
            
            heightInput.placeholder="feet"
            inchesLabel.placeholder="inches"
            weightInput.placeholder="pounds"
        
            
        }

    }
    

    @IBAction func calculateBMI(_ sender: UIButton) {
        // Clear labels
        BMILabel.text="BMI :"
        BMIcategoryLabel.text="BMI Category :"
        errorLabel.isHidden=false;
        errorLabel.text = ""
        

        // Ensure all inputs are available
        guard let heightFeet = heightInput.text,
              let inches = inchesLabel.text,
              let weight = weightInput.text else {
            errorLabel.text = "Please enter all fields."
            return
        }

        // Check if inches exceed a reasonable limit (for example, 0 to 12)
        if let inchesValue = Double(inches), inchesValue < 0 || inchesValue > 12 {
            errorLabel.text = "Inches must be between 0 and 12."
            return
        }

        // Check for empty or zero input values
        if heightFeet.isEmpty || weight.isEmpty {
            errorLabel.text = "Please enter all fields."
            return
        }

        if let heightFeetValue = Double(heightFeet), heightFeetValue <= 0 {
            errorLabel.text = "Height must be greater than zero."
            return
        }

        if let weightValue = Double(weight), weightValue <= 0 {
            errorLabel.text = "Weight must be greater than zero."
            return
        }

        var result: Double = 0.0

        // Check the state of the unit switch
        if unitSwitch.isOn { // Metric units
            if let heightInCm = Double(heightFeet), let weightInKg = Double(weight) {
                let heightInMeters = heightInCm / 100
                result = weightInKg / (heightInMeters * heightInMeters)
            }
        } else { // Imperial units
            if let heightFeetValue = Double(heightFeet), let heightInchesValue = Double(inches), let weightInLbs = Double(weight) {
                // Convert height to inches and then to meters
                let totalHeightInInches = (heightFeetValue * 12) + heightInchesValue
                let heightInMeters = totalHeightInInches * 0.0254

                // Convert weight to kilograms
                let weightInKg = weightInLbs * 0.453592

                result = weightInKg / (heightInMeters * heightInMeters)
            }
        }

        // Calculate BMI category
        let res = NSString(format: "%.2f", result).doubleValue
        var categoryResult = ""

        if res < 18.5 {
            categoryResult = "Underweight"
        } else if res < 24.9 {
            categoryResult = "Normal Weight"
        } else if res < 29.9 {
            categoryResult = "Overweight"
        } else {
            categoryResult = "Obese"
        }

        // Update UI labels only after all checks and calculations
        BMILabel.text = "BMI : \(res)"
        BMIcategoryLabel.text = "BMI Category : \(categoryResult)"
    }


    
}

