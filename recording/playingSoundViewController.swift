//
//  playingSoundViewController.swift
//  recording
//
//  Created by Siddique on 03/01/18.
//  Copyright © 2018 Siddique. All rights reserved.
//

import UIKit
import AVFoundation
class playingSoundViewController: UIViewController {
    var recordedAudioUrl: URL!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
    case .slow:
        playSound(rate: 0.5)
    case .fast:
        playSound(rate: 1.5)
    case .chipmunk:
        playSound(pitch: 1000)
    case .vader:
        playSound(pitch: -1000)
    case .echo:
        playSound(echo: true)
    case .reverb:
        playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopSoundForButton(_ sender: UIButton) {
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI(.notPlaying)
    }
  

}
