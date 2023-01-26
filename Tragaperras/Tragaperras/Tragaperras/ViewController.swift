//
//  ViewController.swift
//  Tragaperras
//
//  Created by Usuario on 17/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var imgs: [UIImageView]!
    var player: AVAudioPlayer!
    
    let faces = ["campana", "cereza", "dolar", "fresa", "limon", "siete"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        imgs = [img1, img2, img3]
        
        do {
            if let fileURL = Bundle.main.path(forResource: "tragaperras", ofType: "mp3") {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No sound file")
            }
        } catch let err {
            print("Error loading sound file \(err.localizedDescription)")
        }
    }

    @IBAction func play(_ sender: UIButton) {
        for img in imgs {
            var animationImages = [UIImage]()
            for face in faces.shuffled() { animationImages.append(UIImage(named: face)!) }
            img.animationImages = animationImages
            img.animationDuration = 0.6
            img.startAnimating()
        }
        
        if let player = player { player.play() }
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .seconds(1),
            execute: {
                for img in self.imgs { img.stopAnimating() }
                self.randomFaces()
                if let player = self.player { player.stop() }
            }
        )
    }
    
    func randomFaces() {
        for img in imgs {
            img.image = UIImage(named: faces[Int(arc4random() % 6)])
        }
    }
}

