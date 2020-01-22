//
//  ViewController.swift
//  Api Demo
//
//  Created by Mohammad Kiani on 2020-01-17.
//  Copyright © 2020 mohammadkiani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var weatherLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func selectCity(_ sender: UIButton) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityTxt.text!.replacingOccurrences(of: " ", with: "%20"))&APPID=5822f53158fdf0f22ed4fad25842783b")!
                
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let urlContent = data {
                            do {
                                let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
//                                print(jsonResult)
        //                        print(jsonResult?["name"] as! String)
                                if let description = ((jsonResult?["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                    print(description)
                                    DispatchQueue.main.async {
                                        self.weatherLbl.text = description
                                    }
                                }
                            } catch {
                                print(error)
                            } 
                        }
                    }
                }
                // start the task
                task.resume()
    }
}

