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
    
    // MARK: - Public Properties
    var color: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        getColor()
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(donePressed)
        )
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func donePressed() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else {
            showAlert(for: textField)
            setColor()
            return
        }
        guard floatValue <= 1 else {
            showAlert(for: textField)
            setColor()
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
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
        
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
    
    func showAlert(for textField: UITextField) {
        let alert = UIAlertController(
            title: "Too much Value!",
            message: "You should enter a value less than or equal to 1",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            let defaultValue: Float = 0.5
            textField.text = String(format: "%.2f", defaultValue)
            if textField == self.redValueTextField {
                self.redSlider.setValue(defaultValue, animated: true)
            } else if textField == self.greenValueTextField {
                self.greenSlider.setValue(defaultValue, animated: true)
            } else {
                self.blueSlider.setValue(defaultValue, animated: true)
            }
            textField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
