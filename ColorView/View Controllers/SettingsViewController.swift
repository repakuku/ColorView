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

    var color: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = color
        
        getColor()
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNew(color: color)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension SettingsViewController {
    func getColor() {
        let redComponent = Float(color.cgColor.components?[0] ?? 0.5)
        let greenComponent = Float(color.cgColor.components?[1] ?? 0.5)
        let blueComponent = Float(color.cgColor.components?[2] ?? 0.5)
        
        redSlider.setValue(redComponent, animated: true)
        greenSlider.setValue(greenComponent, animated: true)
        blueSlider.setValue(blueComponent, animated: true)
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
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
