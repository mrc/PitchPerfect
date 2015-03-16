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
    var receivedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
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
