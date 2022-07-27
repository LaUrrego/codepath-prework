//
//  SettingsViewController.swift
//  Prework
//
//  Created by Larry Urrego on 7/25/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var percentNum: UILabel!
    @IBOutlet weak var percentSlide: UISlider!
    @IBOutlet weak var darkMode: UISwitch!
    @IBOutlet weak var backButton: UIButton!
    
    //  UserDefaults implemented to save settings data
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Keeps slider position consistent with user selection as saved in UserDefaults
        percentSlide.value = userDefaults.float(forKey: "otherPercent")
        
        //  Use slider value to alter label text
        percentNum.text = String("\(Int(percentSlide.value))%")
        
        //  Keep darkmode switch pressed if pressed by user, as determined by UserDefaults
        darkMode.isOn = userDefaults.bool(forKey: "UIChoice")
      
        //  Conditional to make .dark and .light selection stick when moving between ViewController and SettingsViewController
        let choiceUI = userDefaults.bool(forKey: "UIChoice")
        if choiceUI == true {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    //  Send switch data back via segue to ViewController by creating a conditional that modifies overrideUserInterfaceStyle to keep dark mode or light mode consistent between views in-app.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ViewController
        let choiceUI = userDefaults.bool(forKey: "UIChoice")
        if choiceUI == true {
            destVC.overrideUserInterfaceStyle = .dark
        } else {
            destVC.overrideUserInterfaceStyle = .light
        }
    }
    
    //  Storing slider selection into UserDefault key "otherPercent" for use in locking the slider and sending the choice back to ViewController for tip calculation.
    @IBAction func tipValueSliderChanged(_ sender: UISlider) {
        percentNum.text = String("\(Int(percentSlide.value))%")
        userDefaults.set(Int(percentSlide.value), forKey: "otherPercent")
    }
    
    //  Switcher to create an instant change to overrideUserInterfaceStyle which is later kept via UserDefaults above.
    @IBAction func buttonPress(_ sender: UISwitch) {
        if sender .isOn {
            overrideUserInterfaceStyle = .dark
            userDefaults.set(true, forKey: "UIChoice")
        }
        else {
            overrideUserInterfaceStyle = .light
            userDefaults.set(false, forKey: "UIChoice")
        }
    }
}

