import UIKit

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
    
        updateColor()
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderAction() {
        updateColor()
    }
    
    // MARK: - UpdateColor
    
    private func updateColor() {
        let redColor = CGFloat(redSlider.value)
        let greenColor = CGFloat(greenSlider.value)
        let blueColor = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1
        )
        
        redValueLabel.text = String(
            format: "%.2f",
            (redColor * 100).rounded() / 100
        )
        greenValueLabel.text = String(
            format: "%.2f",
            (greenColor * 100).rounded() / 100
        )
        blueValueLabel.text = String(
            format: "%.2f",
            (blueColor * 100).rounded() / 100
        )
    }
        
}

