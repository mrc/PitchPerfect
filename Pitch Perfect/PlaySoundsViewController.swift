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
    var auDelay: AVAudioUnitDelay!
    var audioFile: AVAudioFile!
    var receivedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        // Set up audio engine for effect playback.
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // Set up pitch effect
        auTimePitch = AVAudioUnitTimePitch()
        audioEngine.attachNode(auTimePitch)

        // set up delay effect
        auDelay = AVAudioUnitDelay()
        audioEngine.attachNode(auDelay)

        audioEngine.connect(audioPlayerNode, to: auTimePitch, format: nil)
        audioEngine.connect(auTimePitch, to: auDelay, format: nil)
        audioEngine.connect(auDelay, to: audioEngine.outputNode, format: nil)

        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSoundWithRate(rate: Float) {
        stopAllPlayers()
        audioPlayer.rate = rate
        audioPlayer.prepareToPlay()
        audioPlayer.currentTime = 0
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
        
        // Play sound with pitch effect
        auTimePitch.bypass = false
        auDelay.bypass = true
        
        auTimePitch.pitch = pitch
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playSoundWithEcho(delayTime: NSTimeInterval, feedback: Float) {
        stopAllPlayers()
        
        // Play sound with delay effect
        auTimePitch.bypass = true
        auDelay.bypass = false
        
        auDelay.delayTime = delayTime
        auDelay.feedback = feedback
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
    
    @IBAction func playSoundWithLongEcho(sender: AnyObject) {
        playSoundWithEcho(1.0, feedback: 50)
    }
    
    @IBAction func playSoundWithShortEcho(sender: AnyObject) {
        playSoundWithEcho(0.15, feedback: 85)
    }
    
    func stopAllPlayers() {
        audioPlayer.stop()
        audioPlayerNode.stop()
        auTimePitch.reset()
        auDelay.reset()
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        stopAllPlayers()
    }

}
