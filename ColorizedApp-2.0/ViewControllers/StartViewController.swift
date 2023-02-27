//
//  StartViewController.swift
//  ColorizedApp-2.0
//
//  Created by Bektemur Mamashayev on 23/02/23.
//

import UIKit

protocol PalletViewControllerDelegate: AnyObject {
    func setNewColor(for color: UIColor)
}

final class StartViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let palletVC = segue.destination as? PalletViewController else { return }
        palletVC.color = view.backgroundColor
        palletVC.delegate = self
    }
}

//MARK: - ColorDelegate
extension StartViewController: PalletViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

