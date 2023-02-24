//
//  StartViewController.swift
//  ColorizedApp-2.0
//
//  Created by Bektemur Mamashayev on 23/02/23.
//

import UIKit

protocol PalletViewControllerDelegate: AnyObject {
    func setNewColor(for color: Color)
}

final class StartViewController: UIViewController {
    
    var color = Color(red: 1, green: 1, blue: 1)
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let palletVC = segue.destination as? PalletViewController else { return }
        palletVC.color = color
        palletVC.delegate = self
    }
    
    func updateUI() {
           view.backgroundColor = UIColor(
               red: CGFloat(color.red),
               green: CGFloat(color.green),
               blue: CGFloat(color.blue),
               alpha: 1
           )
       }
}


extension StartViewController: PalletViewControllerDelegate {
    func setNewColor(for color: Color) {
        self.color = color
        updateUI()
    }
    
    
    
    
}

