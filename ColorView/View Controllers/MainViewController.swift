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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = view.backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNew(color: UIColor) {
        view.backgroundColor = color
    }
}
