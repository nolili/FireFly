//
//  ViewController.swift
//  FireFly
//
//  Created by nori on 2014/06/25.
//
//

import UIKit
import CoreLocation
let beaconUuid = NSUUID(UUIDString: "31840078-6F1B-448B-A6A2-CADA828E287D")
class ViewController: UIViewController ,CLLocationManagerDelegate{
    
    // var locationManager:ImplicitlyUnwrappedOptionalType<CLLocationManager>
    // var locationManager:Optional<CLLocationManager> ...nilがはいってるかも？型
    var locationManager:CLLocationManager
    
    init(coder aDecoder: NSCoder!) {
        locationManager = CLLocationManager()
     
        super.init(coder: aDecoder)
        
        locationManager.delegate = self;
        
        let beaconRegion = CLBeaconRegion(proximityUUID: beaconUuid, identifier:"hoge")
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: AnyObject[]!, inRegion region: CLBeaconRegion!){
        
        let maxDistance:CGFloat = 1.0
        var proximity:CGFloat = 0.0
        
        let beaconArray = beacons as CLBeacon[]
        for beacon in beacons as CLBeacon[]{
            println(beacon)
        }
        
        if (beacons.count > 0){
            let nearestBeacon = beaconArray[0]
            if (nearestBeacon.proximity != .Unknown){
                proximity = CGFloat(nearestBeacon.accuracy)
                if (proximity > maxDistance){
                    proximity = maxDistance;
                }
                let brightness:CGFloat = 1.0 - (proximity / maxDistance)
                println(brightness)
                UIScreen.mainScreen().brightness = brightness
            }
        }
    }
}

