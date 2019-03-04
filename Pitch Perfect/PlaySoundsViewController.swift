//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Administrator on 8/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, highPitch, lowPitch, echo, reverb }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        //Adding the formatting code for the buttons.  '.scaleAspectFit' successfully shrinks the buttons within the stack view bounds, without changing the aspect ratio.
        
        //Solution found here: https://stackoverflow.com/questions/47607642/uibuttons-squished-on-landscape-and-smaller-devices
        
        slowButton.imageView?.contentMode = .scaleAspectFit
        slowButton.setImage(UIImage.init(named: "Slow"), for: .normal)
        
        fastButton.imageView?.contentMode = .scaleAspectFit
        fastButton.setImage(UIImage.init(named: "Fast"), for: .normal)
        
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.setImage(UIImage.init(named: "HighPitch"), for: .normal)
        
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.setImage(UIImage.init(named: "LowPitch"), for: .normal)
        
        echoButton.imageView?.contentMode = .scaleAspectFit
        echoButton.setImage(UIImage.init(named: "Echo"), for: .normal)
        
        reverbButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.setImage(UIImage.init(named: "Reverb"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
