//
//  ViewController.swift
//  KeyChain_Practice
//
//  Created by coda on 2022/01/10.
//

import UIKit

struct Query {
    func addNewPassword(account: String, newText: String) -> Bool {
        guard let data = newText.data(using: String.Encoding.utf8) else {
            return false
        }
        
        let query: [String: Any] = [kSecClass as String : kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: data]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            return false
        }
        return true
    }
    
    func queryData(account: String) -> String? {
        var item: CFTypeRef?
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecReturnAttributes as String: true,
                                    kSecAttrAccount as String: account,
                                    kSecReturnData as String: true]
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            return nil
        }
        
        guard let unwrapItem = item as? [String: Any],
              let passwordData = unwrapItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        return password
    }
}

class LogInViewController: UIViewController {
    @IBOutlet weak var pwTextField: UITextField!
    var diaryViewController: DiaryViewController?
    var changePasswordViewController: ChangePasswordViewController?
    private let account = "newAccount1"
    let query = Query()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "diary") as? DiaryViewController
        changePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "changePassword") as? ChangePasswordViewController
    }
    
    @IBAction func tapChangeButton(_ sender: UIButton) {
        guard let changePasswordViewController = changePasswordViewController else { return }
        changePasswordViewController.modalPresentationStyle = .popover
        present(changePasswordViewController, animated: true)
    }
    
    @IBAction func tapLogInButton(_ sender: Any) {
        let password = query.queryData(account: account)
        
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
        let password = query.queryData(account: account)
        
        guard password != pwTextField.text else {
            showAlert("이미 패스워드가 있습니다")
            return
        }
        
        guard let newText = pwTextField.text else {
            return
        }
        
        guard query.addNewPassword(account: account, newText: newText) else {
            showAlert("패스워드 등록 실패")
            return
        }
        
        showAlert("패스워드 등록 성공")
    }
    
    private func showAlert(_ message: String) {
            let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
        }
}

