//
//  ViewController.swift
//  aniTest
//
//  Created by hyunMac on 1/6/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var yagom: UIImageView!
    
    @IBAction func errorMeetYagomButtonTapped(_ sender: UIButton) {
        let duration = 0.005
        
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.yagom.transform = CGAffineTransform(translationX: -5, y: 0)
        })
    }
    
    @IBAction func newMacBookbuyYagomTapped(_ sender: UIButton) {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [.autoreverse, .repeat], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.yagom.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
                    
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.yagom.transform = CGAffineTransform(scaleX: 1.2, y: 1.0)
            })

        })
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0, animations: { [self] in
            self.yagom.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
    

