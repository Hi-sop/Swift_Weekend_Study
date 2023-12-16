//
//  ViewController.swift
//  KeyChain_Practice
//
//  Created by coda on 2022/01/10.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var pwTextField: UITextField!
    var diaryViewController: DiaryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "diary") as? DiaryViewController
    }
    
    @IBAction func tapLogInButton(_ sender: Any) {
        guard let diaryViewController = diaryViewController else { return }
        diaryViewController.modalPresentationStyle = .fullScreen
        present(diaryViewController, animated: true)
    }
    
    @IBAction func addNewPassword(_ sender: Any) {
        // 키체인을 활용해 패스워드를 저장합니다.
    }
}

