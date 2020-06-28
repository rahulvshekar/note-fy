//
//  UtternaceManager.swift
//  note-fy
//
//  Created by Rahul V. Shekar on 28/06/20.
//  Copyright © 2020 Rahul V. Shekar. All rights reserved.
//

import Foundation
import AVFoundation

class UtternaceManager {
    
    static let shared = UtternaceManager()
    
    private init() {
    }
    
    let synthesizer = AVSpeechSynthesizer()
    
    func utter(_ text: String) {
        guard !synthesizer.isSpeaking else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
    
}
