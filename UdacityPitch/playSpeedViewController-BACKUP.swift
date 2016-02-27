//
//  playSpeedViewController.swift
//  UdacityPitch
//
//  Created by HOU YADDA on 28.11.15.
//  Copyright © 2015 houyadda. All rights reserved.
//

import UIKit
import AVFoundation

class playSpeedViewController-BACKUP: UIViewController {
    //test duplicate
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    var rateTouchValue: Float!
    var pitchTouchValue: Float!
    
    @IBAction func slowSpeed(sender: UIButton) {
        playWSpeed(0.5)
    }
    
    @IBAction func fastSpeed(sender: UIButton) {
        playWSpeed(2.0)
    }
    
    @IBAction func chipMunkVoice(sender: UIButton) {
        playAudioWithChipmunkPitch(1000)
    }
    
    @IBAction func darthVaderVoice(sender: UIButton) {
        playAudioWithChipmunkPitch(-1000)
    }
    
    func playAudioWithChipmunkPitch(pitch:Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeAudioPitch = AVAudioUnitTimePitch()
        changeAudioPitch.pitch = pitch
        audioEngine.attachNode(changeAudioPitch)
        
        audioEngine.connect(audioPlayerNode, to: changeAudioPitch, format: nil)
        audioEngine.connect(changeAudioPitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    func playWSpeed(speed: Float){
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func stopPlay(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        if let soundPath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
        //            let filePathURL = NSURL(fileURLWithPath: soundPath)
        //            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathURL)
        //            audioPlayer.enableRate = true
        //        }else {
        //            print("File not found")
        //        }
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        
        rateTouchValue = Float(location.x)
        pitchTouchValue = Float(location.y)
    }
    
}
