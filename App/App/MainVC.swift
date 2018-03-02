//
//  MainVC.swift
//  App
//
//  Created by DAMII on 2/09/17.
//  Copyright © 2017 DAMII. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var cvAutenticar: UIView!
    
    @IBOutlet weak var cvRegistrese: UIView!
    
    @IBOutlet weak var segOpciones: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func mostrarVista(_ sender: Any) {
        
        if segOpciones.selectedSegmentIndex == 0
        {
            cvAutenticar.isHidden = false
            cvRegistrese.isHidden = true
        }
        else
        {
            cvAutenticar.isHidden = true
            cvRegistrese.isHidden = false
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
