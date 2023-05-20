//
//  MainViewController.swift
//  ColorView
//
//  Created by Алексей Турулин on 5/19/23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setNew(color: UIColor)
}

final class MainViewController: UIViewController {

    private var color: UIColor = .systemMint {
        didSet {
            view.backgroundColor = color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = color
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNew(color: UIColor) {
        self.color = color
    }
}
