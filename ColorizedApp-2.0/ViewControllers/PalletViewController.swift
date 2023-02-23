//
//  ViewController.swift
//  ColorizedApp-2.0
//
//  Created by Bektemur on 07/02/23.
//

import UIKit

final class PalletViewController: UIViewController {
    
    var color: Color!
    
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    unowned var delegate: PalletViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        showStartPallet()
       
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redTF.text = string(from: sender)
            color.red = sender.value
        case greenSlider:
            greenTF.text = string(from: sender)
            color.green = sender.value
        default:
            blueTF.text = string(from: sender)
            color.blue = sender.value
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func goBack() {
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                addDoneButton(for: redTF)
                redTF.text = string(from: redSlider)
            case greenTF:
                greenTF.text = string(from: greenSlider)
            default:
                blueTF.text = string(from: blueSlider)
            }
        }
    }
    private func showStartPallet() {
        redSlider.setValue(color.red, animated: false)
        greenSlider.setValue(color.green, animated: false)
        blueSlider.setValue(color.blue, animated: false)
        setColor()
        setValue(for: redTF, greenTF, blueTF)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension PalletViewController {
    func addDoneButton(for textField: UITextField) {
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped(_:))
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        textField.inputAccessoryView = toolbar
    }
}




