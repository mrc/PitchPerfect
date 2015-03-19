//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Curtis on 11/03/2015.
//  Copyright (c) 2015 Matt Curtis. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Always use the same filename for recording, to avoid "leaking" files.
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recording.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showReadyToRecord()
    }
    
    func showReadyToRecord() {
        statusLabel.text = "Tap to record"
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
    func showRecordingInProgress() {
        statusLabel.text = "Recording in progress"
        stopButton.hidden = false
        recordButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        showRecordingInProgress()


        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            // Pass the recorded audio on to the next view.
            let url = recorder.url
            recordedAudio = RecordedAudio(title: url.lastPathComponent!, url: url)
            
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("error: did not finish recording successfully")
            showReadyToRecord()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            // Set up the PlaySoundsViewController with the recorded audio.
            let psvc = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            psvc.receivedAudio = data
        }
    }
}

