//
//  ViewController.swift
//  Prework
//
//  Created by Larry Urrego on 7/24/22.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var stepperBut: UIStepper!
    @IBOutlet weak var stepperLabel1: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var reCalculateButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    //  Instance of UserDefaults created to use system-wide keys originally made in SettingsViewController
    let userDefaults = UserDefaults.standard
    
    //  Created instance of TipCalculator from tipCalculator.swift to make use of calculation and variables.
    var tipCalculator = TipCalculator(preTipBill: 0, tipPercentage: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Removed title from navigation bar to remove it or "Back" from appearing in the autonatically generated back button from segue.
        title = " "
        
        //  billAmountTextField the first responder so that the cursor is immediately there when app starts up, and keyboard is deployed.
        billAmountTextField.becomeFirstResponder()
        
        // Makes UIStepper work faster when held-pressed, reducing the need to manually tap in larger splits.
        stepperBut.autorepeat = true
        
        //  Added to round the corners of stepperLabel1 background. Had to make since I couldn't properly implement the textfield for both display and modification of split additions.
        stepperLabel1.layer.masksToBounds = true
        stepperLabel1.layer.cornerRadius = 4.0
    }
    
    //  Created an updater function to refresh totalLabel text and splitAmountLabel text so that any changes were captured and re-run in the calculation, providing instant results.
    func updateUI() {
        totalLabel.text = String(format: "$%.2f", tipCalculator.billTotal)
        let numberOfPeople: Int = Int(stepperBut.value)
        splitAmountLabel.text = String(format: "$%0.2f", tipCalculator.billTotal / Double(numberOfPeople))
    }
    
    //  Unwind segue used for exit from SettingsViewController
    @IBAction func unwindtoOrigin(_ sender: UIStoryboardSegue) {
    }
    
    //  Put integer from stepperBut into stepperLabel1 text, and run updateUI() to refresh calculation.
    @IBAction func stepperChange(_ sender: UIStepper) {
        stepperLabel1.text = Int(sender.value).description
        //calculateBill()
        updateUI()
    }
    
    //  Run calculation whenever the segmented control button is pressed.
    @IBAction func tipPercentageButton(_ sender: Any) {
        calculateBill()
    }
    
    //  Initial bill calculation function that concurrently defines the default segment values for tipControl.
    func calculateBill() {
        
        let tipPresets = [0.15, 0.18, 0.2]
        
        //  Update tipPercentage and capture preTipBill from billAmountTextField.text. All run into calculateTotal()
        tipCalculator.tipPercentage = tipPresets[tipControl.selectedSegmentIndex]
        tipCalculator.preTipBill = Double(billAmountTextField.text!) ?? 0
        tipCalculator.calculateTotal()
    
        // Update Tip Amount Label and refresh all via updateUI().
        tipAmountLabel.text = String(format: "$%.2f", tipCalculator.tipTotal)
        updateUI()
    }
    
    //  Real-time calculation update whenever numbers are entered into the text field.
    @IBAction func billAmountTextFieldChange(_ sender: UITextField) {
        calculateBill()
        }
    
    //  Created because I was having trouble update the tipPercentage using the slider value from SettingsViewControl, so this one imports it via UserDefaults and reruns the same calculation as calculateBill(). Afterwards re-refreshes everything via updateUI().
    @IBAction func reCalculateTotal(_ sender: UIButton) {
        tipCalculator.tipPercentage = Double(userDefaults.float(forKey: "otherPercent") / 100.0)
        tipCalculator.preTipBill = Double(billAmountTextField.text!) ?? 0
        tipCalculator.calculateTotal()
        tipAmountLabel.text = String(format: "$%.2f", tipCalculator.tipTotal)
        updateUI()
    }
}

