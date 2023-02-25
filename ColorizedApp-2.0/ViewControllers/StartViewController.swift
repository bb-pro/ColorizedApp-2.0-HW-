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
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let palletVC = segue.destination as? PalletViewController else { return }
        palletVC.color = color
        palletVC.delegate = self
    }
}

extension StartViewController: PalletViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

