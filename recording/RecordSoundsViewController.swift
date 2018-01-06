//
//  ViewController.swift
//  recording
//
//  Created by Siddique on 30/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stop: UIButton!
   // slowButton.imageView?.contentMode = .aspectFit
    override func viewDidLoad() {
        super.viewDidLoad()
        stop.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        recordLabel.text = "Recording in process"
        record.isEnabled = false
        stop.isEnabled = true
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecording(_ sender: UIButton) {
        recordLabel.text = "Tap to record"
        record.isEnabled = true
        stop.isEnabled = false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Recording wasn't successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! playingSoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioUrl = recordedAudioURL
        }
    }

}

