//
//  ViewController.swift
//  mapApp
//
//  Created by Harada Yuji on 2018/08/06.
//  Copyright © 2018年 Harada Yuji. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let userDefName = "pins"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPins()
    }
    
    
    @IBAction func longTapMaoView(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state != UIGestureRecognizerState.began{
            return
        }
        
        let point = sender.location(in: mapView)
        let geo = mapView.convert(point, toCoordinateFrom: mapView)
        
        let alert = UIAlertController(title: "スポット登録", message: "この場所に残すメッセージを入力してください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "登録", style: .default, handler: {(action:UIAlertAction) -> Void in
            
            let pin = Pin(geo: geo, text: alert.textFields?.first?.text)
            self.mapView.addAnnotation(pin)
            self.savePin(pin)
            
        
            }))
        
        alert.addTextField(configurationHandler:{ (textField: UITextField) in
            textField.placeholder = "メッセージ"
        })
        present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePin(_ pin: Pin) {
        let userDefaults = UserDefaults.standard
        let pinInfo = pin.toDictionary()
        
        if var savedPins = userDefaults.object(forKey: userDefName) as? [[String:Any]] {
            savedPins.append(pinInfo)
            userDefaults.set(savedPins, forKey: userDefName)
        }else{
            let newSavedPins: [[String: Any]] = [pinInfo]
            userDefaults.set(newSavedPins, forKey: userDefName)
        }
    }
    
    
    
    
    
    
    
    
    
    func loadPins() {
        let userDefaults = UserDefaults.standard
        if let savedPins = userDefaults.object(forKey: userDefName) as? [[String: Any]] {
            self.mapView.removeAnnotations(self.mapView.annotations)
            for pinInfo in savedPins {
                let newPin = Pin(dictionary: pinInfo)
                self.mapView.addAnnotation(newPin)
            }
        }
    }


}

