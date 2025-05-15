//
//  ViewController.swift
//  MusicPlayerDemo
//
//  Created by mac on 02/09/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgMusic: UIImageView!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var lblStartTime: UILabel!
    @IBOutlet var lblTotalTime: UILabel!
    @IBOutlet var lblMusicName: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    let musicManager = MusicPlayerManager.shared
    var timer: Timer?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMusicName.text = musicManager.getFileName(from: "AayiNai-Stree2", fileType: "mp3")
       // slider.value = Float(musicManager.getCurrentTime())
        
        // Setup the music player
        musicManager.setupMusicPlayer(musicName: "AayiNai-Stree2", type: "mp3")
        
        // Display the artwork
        if let artwork = musicManager.getMusicArtwork(from: "AayiNai-Stree2", fileType: "mp3") {
            imgMusic.image = artwork
        } else {
            imgMusic.image = UIImage(named: "MusicPlaceholder") // Default image
        }
        
        // Display the total time on load
        if let duration = musicManager.audioPlayer?.duration {
            lblTotalTime.text = musicManager.formatTime(time: duration)
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    // Update the slider and labels while playing
    func updateUI() {
        musicManager.updateSliderAndLabels(slider: slider, currentTimeLabel: lblStartTime, totalTimeLabel: lblTotalTime)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if musicManager.isPlaying {
            musicManager.pauseMusic()
            sender.setTitle("Play", for: .normal)
        } else {
            musicManager.playMusic {
                self.updateUI()
            }
            sender.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        musicManager.sliderValueChanged(sender)
        musicManager.updateSliderAndLabels(slider: slider, currentTimeLabel: lblStartTime, totalTimeLabel: lblTotalTime)
    }
    
    
}

