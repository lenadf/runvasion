//
//  ViewController.swift
//  TestSpeed
//
//  Created by yannis on 19/03/2015.
//  Copyright (c) 2015 yannis. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate {

    //speed
    let locationManager = CLLocationManager()
    let okPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("ok", withExtension: "mp3"), error: nil)
    let bofPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("bof", withExtension: "mp3"), error: nil)
    let deadPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("dead", withExtension: "mp3"), error: nil)
    var speedInKmh:Double = 0

    //timer
    var runBeginDate = NSDate()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        //speed
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //timer
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateLabel"), userInfo: nil, repeats: true)
     
    }
    
    
    
    
    
    //speed
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        speedInKmh = newLocation.speed * 3.6
        NSLog("%f", speedInKmh)
        
        self.okPlayer.pause()
        self.bofPlayer.pause()
        self.deadPlayer.pause()
        if (speedInKmh > 40) {
            // Dead
            self.deadPlayer.play()
        } else if (speedInKmh > 13) {
            // Bof
            self.bofPlayer.play()
        } else {
            // OK
            self.okPlayer.play()
        }
    }
    
    //timer 
    func updateLabel() {
        var elapsedTime = NSDate().timeIntervalSinceDate(runBeginDate)
        var seconds = floor(elapsedTime % 60)
        var minutes = floor((elapsedTime / 60) % 60);
        var text = NSString(format: "%02.f:%02.f", minutes, seconds)
        timerLabel.text = text
    }
    
    
}

