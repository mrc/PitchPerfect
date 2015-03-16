//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Curtis on 15/03/2015.
//  Copyright (c) 2015 Matt Curtis. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let url = NSURL.fileURLWithPath(path)
            
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
            AVAudioSession.sharedInstance().setActive(true, error: nil)
            
            var error: NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
            audioPlayer.enableRate = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func playSoundQuickly(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        audioPlayer.stop()
    }
}
