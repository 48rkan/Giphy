//
//  Sound+ ext.swift
//  Giphy
//
//  Created by Erkan Emir on 03.06.23.
//

import Foundation
import AVFoundation

class SoundHandler {
    static var player: AVAudioPlayer?

    static func playSound(name: String, type: String) {
        guard let path = Bundle.main.path(forResource: name,
                                          ofType: type) else { return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
