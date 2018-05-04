//
//  ViewController.swift
//  FindMyPosition
//
//  Created by Sunny－Joy on 2017/12/30.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import UIKit
import CoreLocation
let geocoder = CLGeocoder()

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    //let geocoder: CLGeocoder = CLGeocoder.init()
    let locationLabel = UILabel()
    let locationStrLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImageView = UIImageView(frame:self.view.bounds)
        bgImageView.image = #imageLiteral(resourceName: "phoneBg.jpeg")
        self.view.addSubview(bgImageView)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        
        locationManager.delegate = self
        
        locationLabel.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 100)
        locationLabel.textAlignment = .center
        locationLabel.textColor = UIColor.white  //设定显示经纬度的字体颜色为白色
        self.view.addSubview(locationLabel)
        
        locationStrLabel.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 200)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.white  //设定显示地址的字体颜色为白色
        self.view.addSubview(locationStrLabel)
        
        let findMyLocationBtn = UIButton(type: .custom)   //设置屏幕靠下部的button
        findMyLocationBtn.frame = CGRect(x: 50, y: self.view.bounds.height - 160, width: self.view.bounds.width - 100, height: 50)
            //y: self.view.bounds.height - 80 时button位置靠下，改为 y: self.view.bounds.height - 160 时button位置明显往上提了一些
        findMyLocationBtn.setTitle("Find My Position", for: UIControlState.normal)
        findMyLocationBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: UIControlEvents.touchUpInside)
        self.view.addSubview(findMyLocationBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func findMyLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations : NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat: \(currentLocation.coordinate.latitude) lng: \(currentLocation.coordinate.longitude)"
        locationLabel.text = locationStr            //将经纬度以字符串形式输出在locationLabel中
       // reverseGeocode(location: currentLocation)
        locationStrLabel.text = reverseGeocode(location: currentLocation)
        locationManager.stopUpdatingLocation()
      }
    
    //将经纬度转换为城市名
    func reverseGeocode(location: CLLocation) -> String{
        var finalAddress = String()
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if(error == nil) {
                let pm = CLPlacemark(placemark: placeMarks![0] as CLPlacemark)
                
                //let locality = (pm.locality != nil) ? pm.locality : ""
                //let postalCode = (pm.postalCode != nil) ? pm.postalCode : ""
                let administrativeArea = (pm.administrativeArea != nil) ? pm.administrativeArea : ""
                let country = (pm.country != nil) ? pm.country : ""
                
                //self.locationStrLabel.text = postalCode! + ", " + locality!
                //self.locationStrLabel.text = administrativeArea! + " ," + country!
                finalAddress = administrativeArea! + "," + country!
            }
        }
        print(finalAddress)
        return finalAddress
    }
}

