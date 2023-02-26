//
//  ViewController.swift
//  ColorizedApp-2.0
//
//  Created by Bektemur on 07/02/23.
//

import UIKit

final class PalletViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var color: UIColor!
    
    unowned var delegate: PalletViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = color
        
        showStartPallet()
        setValue(for: redLabel, greenLabel, blueLabel)
        
    }
    
    // Метод для скрытия клавиатуры тапом по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redTF.text = string(from: sender)
            setValue(for: redLabel)
        case greenSlider:
            greenTF.text = string(from: sender)
            setValue(for: greenLabel)
        default:
            blueTF.text = string(from: sender)
            setValue(for: blueLabel)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func goBack() {
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    
}

//MARK: - UITextFieldDelegate
extension PalletViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        updatTextFieldValues(newValue, textField)
    }
}


//MARK: - Private Methods
private extension PalletViewController {
    
    func updatTextFieldValues(_ newValue: String, _ textField: UITextField) {
        if let colorValue = Float(newValue) {
            switch textField {
            case redTF:
                redSlider.setValue(colorValue, animated: true)
                
                redTF.text = string(from: redSlider)
                
            case greenTF:
                greenSlider.setValue(colorValue, animated: true)
                
                greenTF.text = string(from: greenSlider)
               
            default:
                blueSlider.setValue(colorValue, animated: true)
              
                blueTF.text = string(from: blueSlider)
                
                setColor()
                
            }
        } else {
            showAlert()
            textField.text = ""
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены неправильные данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        color = colorView.backgroundColor
    }
    
    func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                addDoneButton(for: redTF)
                redTF.text = string(from: redSlider)
                redLabel.text = redTF.text
            case greenTF:
                addDoneButton(for: greenTF)
                greenTF.text = string(from: greenSlider)
                greenLabel.text = greenTF.text
            default:
                addDoneButton(for: blueTF)
                blueTF.text = string(from: blueSlider)
                blueLabel.text = blueTF.text
            }
        }
    }
    
    func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    func showStartPallet() {
        let ciColor = CIColor(color: color)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
        
        setValue(for: redTF, greenTF, blueTF)
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
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




