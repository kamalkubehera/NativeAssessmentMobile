//
//  ViewController.swift
//  NativeAssessmentMobile
//
//  Created by KAMAL KUMAR BEHERA on 22/11/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtLocationField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func getWeatherBtnAction(_ sender: Any) {
    
        let vc = TableViewController()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableViewController = segue.destination as? TableViewController else{return}
        //tableViewController.cityName = txtLocationField.text
        TableViewController.cityName = txtLocationField.text!
    }


}

