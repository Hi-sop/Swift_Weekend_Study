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
        var item: CFTypeRef?
        let account = "newAccount"
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecReturnAttributes as String: true,
                                    kSecAttrAccount as String: account,
                                    kSecReturnData as String: true]
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard let unwrapItem = item as? [String: Any],
              let passwordData = unwrapItem[kSecValueData as String] as? Data else {
            return
        }
        
        guard let password = String(
            data: passwordData,
            encoding: String.Encoding.utf8
        ) else {
            return
        }
        
        if password == pwTextField.text {
            guard let diaryViewController = diaryViewController else { return }
            diaryViewController.modalPresentationStyle = .fullScreen
            present(diaryViewController, animated: true)
        } else {
            showAlert("패스워드 불일치")
        }
        pwTextField.text = ""
    }
    
    @IBAction func addNewPassword(_ sender: Any) {
        let password = pwTextField.text
        let account = "newAccount"
        
        guard let password = password else {
            return
        }
        
        let data = password.data(using: String.Encoding.utf8)!
        
        var query: [String: Any] = [kSecClass as String : kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: data]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            showAlert("같은 패스워드가 존재합니다 새로운 패스워드로 교체됩니다.")
            let newData: [String: Any] = [kSecValueData as String: password]
            let updateStatus = SecItemUpdate(query as CFDictionary, newData as CFDictionary)
            
            guard updateStatus == errSecSuccess else {
                let updateStatusString = String(updateStatus)
                showAlert(updateStatusString)
                return
            }
        }
        
        pwTextField.text = ""
        showAlert("패스워드 등록성공")
        
    }
    
    private func showAlert(_ message: String) {
            let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
        }
}

