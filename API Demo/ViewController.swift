//
//  ViewController.swift
//  API Demo
//
//  Created by Hugo Morelli on 10/17/16.
//  Copyright © 2016 Hugo Morelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK: Properties
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: Actions
    @IBAction func submit(_ sender: AnyObject) {
        
        if  let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20")  + "&appid=30b1a971562e525d37e0d540a23cc9c7"){
        
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
            
            if error != nil {
                
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let  jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                        
                        
                        print(jsonResult)
                        
                        print(jsonResult["name"])
                        
                        if let weather = jsonResult["weather"] as? NSArray
                        {
                            let description = weather[0] as! [String: AnyObject]
                            DispatchQueue.main.sync {
                                print(description["description"])
                                self.resultLabel.text = description["description"] as! String?
                            }
                        }
                    } catch {
                        
                        print("JSON Failed")
                    }
                    
                    
                }
                
            }
        }
        
        task.resume()
        }
        else {
            resultLabel.text = "Couldn't find weather for that city - please try another."
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

