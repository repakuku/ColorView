import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTextField: UITextField!
    @IBOutlet var greenValueTextField: UITextField!
    @IBOutlet var blueValueTextField: UITextField!
    

    var color: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        getColor()
        
        addToolBarToKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redValueTextField.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenValueTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueValueTextField.text = string(from: blueSlider)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNew(color: color)
        dismiss(animated: true)
    }
}

// MARK: - TextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else { return }
        guard floatValue <= 1 else {
            showAlert()
            return
        }
        
        if textField == redValueTextField {
            redValueLabel.text = textField.text
            redSlider.setValue(floatValue, animated: true)
        } else if textField == greenValueTextField {
            greenValueLabel.text = textField.text
            greenSlider.setValue(floatValue, animated: true)
        } else {
            blueValueLabel.text = textField.text
            blueSlider.setValue(floatValue, animated: true)
        }
        
        setColor()
    }
}

// MARK: - Private Methods
private extension SettingsViewController {
    func getColor() {
        guard let redComponent = color.cgColor.components?[0] else { return }
        guard let greenComponent = color.cgColor.components?[1] else { return }
        guard let blueComponent = color.cgColor.components?[2] else { return }
        
        redSlider.setValue(Float(redComponent), animated: true)
        greenSlider.setValue(Float(greenComponent), animated: true)
        blueSlider.setValue(Float(blueComponent), animated: true)
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redValueTextField.text = string(from: redSlider)
        greenValueTextField.text = string(from: greenSlider)
        blueValueTextField.text = string(from: blueSlider)
        
        colorView.backgroundColor = color
    }
    
    func setColor() {
        color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = color
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func addToolBarToKeyboard() {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(donePressed)
        )
        
        toolBar.items = [doneButton]
        toolBar.sizeToFit()
        
        redValueTextField.inputAccessoryView = toolBar
        greenValueTextField.inputAccessoryView = toolBar
        blueValueTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Too much Value!",
            message: "You should enter a value less than or equal to 1",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        )
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
