//
//  VideoPlayer.swift
//  MusicPlayerDemo
//
//  Created by mac on 03/09/24.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayer: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var playerView: UIView!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlayPause: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playerObserver: Any?
    
    var videoEndClosure: (() -> Void)?  // Completion closure for video end
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()
        resetVideoPlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = playerView.bounds
    }
    
    deinit {
        if let observer = playerObserver {
            player?.removeTimeObserver(observer)
        }
    }
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    // Present View Controller
    func videoPlay() {
        
        if let url = Bundle.main.url(forResource: "Demo", withExtension: "mp4") {
            
            let avPlayer = AVPlayer(url: url)
            let avController = AVPlayerViewController()
            avController.player = avPlayer
            
            // Present the video player
            present(avController, animated: true) {
                // Start playing the video when the controller is presented
                avPlayer.play()
            }
        }
    }
    
    // Custom View
    func setupVideoPlayer() {
        if let url = Bundle.main.url(forResource: "Demo", withExtension: "mp4") {
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = playerView.bounds
            playerLayer?.videoGravity = .resizeAspect
            
            if let playerLayer = playerLayer {
                playerView.layer.addSublayer(playerLayer)
            }
            
            // Add observer to update UI during playback
            playerObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
                self?.updateUIForCurrentTime(time: time)
            }
            
            // Ensure video duration is available
            if let duration = player?.currentItem?.asset.duration {
                let seconds = CMTimeGetSeconds(duration)
                if !seconds.isNaN && !seconds.isInfinite {
                    lblEndTime.text = formatTime(seconds: seconds)
                    progressSlider.maximumValue = Float(seconds)
                }
            }
            
            // Start monitoring the playback status to know when the video ends
            observePlayerEnd { [weak self] in
                self?.resetVideoPlayer()
            }
        }
    }
    
    func observePlayerEnd(completion: @escaping () -> Void) {
        videoEndClosure = completion
        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            
            guard let strongSelf = self else { return }
            
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(strongSelf.player?.currentItem?.duration ?? CMTime.zero)
            
            // Check if the current time has reached the end of the video
            if currentTime >= totalTime {
                strongSelf.videoEndClosure?()
            }
        }
    }
        
    func resetVideoPlayer() {
        // Reset the player to the beginning
        player?.seek(to: .zero)
        
        // Update UI components
        btnPlayPause.setTitle("Play", for: .normal)
        progressSlider.value = 0
        lblCurrentTime.text = "00:00"
        
        // Pause the video
        player?.pause()
    }
    
    func formatTime(seconds: Float64) -> String {
        
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func updateUIForCurrentTime(time: CMTime) {
        let currentSeconds = CMTimeGetSeconds(time)
        lblCurrentTime.text = formatTime(seconds: currentSeconds)
        progressSlider.value = Float(currentSeconds)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnPresentVideoPlay(_ sender: UIButton) {
        videoPlay()
    }
    
    @IBAction func btnSameViewVideoPlay(_ sender: Any) {
        if player?.rate == 0 {  // Player is paused
            player?.play()
            btnPlayPause.setTitle("Pause", for: .normal)
        } else {  // Player is playing
            player?.pause()
            btnPlayPause.setTitle("Play", for: .normal)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let seekTime = CMTime(seconds: Double(sender.value), preferredTimescale: 600)
        player?.seek(to: seekTime)
    }
}


