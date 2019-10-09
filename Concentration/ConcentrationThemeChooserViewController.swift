//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by leo  luo on 2019-09-30.
//  Copyright © 2019 tk.onebite. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private let themes: Dictionary<String,[String]> = [
        "Animals": ["🐶","🐱","🐴","🦊","🐺","🐼","🐨","🐯","🦁"],
        "Faces":   ["😆","🙃","😶","😅","🙄","😑","🤣","😷","😂"],
        "Foods":   ["🌭","🥨","🥖","🍞","🥓","🥞","🥐","🥯","🍔"]
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }

}
