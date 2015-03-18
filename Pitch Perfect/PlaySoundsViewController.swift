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
    
    var audioEngine: AVAudioEngine!
    var audioPlayer: AVAudioPlayer!
    var audioPlayerNode: AVAudioPlayerNode!
    var auTimePitch: AVAudioUnitTimePitch!
    var audioFile: AVAudioFile!
    var receivedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        // Set up audio engine for variable pitch playback.
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        auTimePitch = AVAudioUnitTimePitch()
        audioEngine.attachNode(auTimePitch)
        
        audioEngine.connect(audioPlayerNode, to: auTimePitch, format: nil)
        audioEngine.connect(auTimePitch, to: audioEngine.outputNode, format: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSoundWithRate(rate: Float) {
        stopAllPlayers()
        audioPlayer.rate = rate
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        playSoundWithRate(0.5)
    }
    
    @IBAction func playSoundQuickly(sender: AnyObject) {
        playSoundWithRate(1.5)
    }
    
    func playSoundWithPitch(pitch: Float) {
        stopAllPlayers()
        auTimePitch.pitch = pitch
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func playSoundHigh(sender: AnyObject) {
        playSoundWithPitch(1000)
    }
    
    @IBAction func playSoundLow(sender: AnyObject) {
        playSoundWithPitch(-1000)
    }
    
    func stopAllPlayers() {
        audioPlayer.stop()
        audioPlayerNode.stop()
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        stopAllPlayers()
    }

}
