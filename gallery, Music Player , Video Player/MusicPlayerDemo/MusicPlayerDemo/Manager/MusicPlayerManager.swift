//
//  MusicPlayerManager.swift
//  MusicPlayerDemo
//
//  Created by mac on 02/09/24.
//

import Foundation
import AVFoundation
import UIKit

class MusicPlayerManager {
    
    static let shared = MusicPlayerManager()
    
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    var timer: Timer?
    
    func setupMusicPlayer(musicName: String, type: String) {
        if let path = Bundle.main.path(forResource: musicName, ofType: type) {
            let url = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
        }
    }
    
    // Play the music and start updating the slider
    func playMusic(updateSlider: @escaping () -> Void) {
        
        audioPlayer?.play()
        isPlaying = true
        startTimer(updateSlider: updateSlider)
    }
    
    // Pause the music
    func pauseMusic() {
        
        audioPlayer?.pause()
        isPlaying = false
        stopTimer()
    }
    
    // Start the timer to update the slider and labels
    private func startTimer(updateSlider: @escaping () -> Void) {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateSlider()
        }
    }

    // Stop the timer
    private func stopTimer() {
        
        timer?.invalidate()
        timer = nil
    }

    // Set Image from the music file
    func getMusicArtwork(from fileName: String, fileType: String) -> UIImage? {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            
            let url = URL(fileURLWithPath: path)
            let asset = AVAsset(url: url)
            
            for metadataItem in asset.commonMetadata {
                if metadataItem.commonKey == .commonKeyArtwork, let artworkData = metadataItem.value as? Data, let image = UIImage(data: artworkData) {
                    return image
                }
            }
        }
        return nil // Return nil if no artwork found
    }
    
    func getFileName(from fileName: String, fileType: String) -> String {
        return "\(fileName).\(fileType)"
    }
    
    // Get the total time of the audio in seconds
    func getTotalTime() -> TimeInterval {
        return audioPlayer?.duration ?? 0
    }
    
    // Get the current time of the audio in seconds
    func getCurrentTime() -> TimeInterval {
        return audioPlayer?.currentTime ?? 0
    }
    
    // Handle slider value change
    func sliderValueChanged(_ sender: UISlider) {
        guard let audioPlayer = audioPlayer else { return }
        
        // Set the current time of the audio to the slider's value
        audioPlayer.currentTime = TimeInterval(sender.value)
        
        // If the audio was playing before, ensure it continues playing after the slider change
        if isPlaying {
            audioPlayer.play()
        }
    }
    
    // Update the slider and labels for current and total time
    func updateSliderAndLabels(slider: UISlider, currentTimeLabel: UILabel, totalTimeLabel: UILabel) {
        
        guard let audioPlayer = audioPlayer else { return }
        
        // Update slider
        slider.maximumValue = Float(audioPlayer.duration)
        slider.value = Float(audioPlayer.currentTime)
        
        // Update labels
        currentTimeLabel.text = formatTime(time: audioPlayer.currentTime)
        totalTimeLabel.text = formatTime(time: audioPlayer.duration)
    }
    
    // Format time in minutes and seconds
    func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
