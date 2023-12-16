//
//  ChangePasswordViewController.swift
//  KeyChain_Practice
//
//  Created by Hisop on 2023/12/16.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    private let query = Query()
    private let account = "newAccount1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resetTextField() {
        oldPassword.text = ""
        newPassword.text = ""
    }
    
    @IBAction func tapChangePasswordButton(_ sender: UIButton) {
        guard let keyPassword = query.queryData(account: account) else {
            resetTextField()
            showAlert("패스워드가 설정되지 않았습니다")
            return
        }
        
        guard keyPassword == oldPassword.text else {
            resetTextField()
            showAlert("패스워드가 일치하지 않습니다")
            return
        }
        
        guard let data = newPassword.text?.data(using: String.Encoding.utf8) else {
            return
        }
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                                kSecAttrAccount as String: account]
        let newValueData: [String: Any] = [kSecValueData as String: data]
        
        
        let status = SecItemUpdate(query as CFDictionary, newValueData as CFDictionary)
        
        guard status == errSecSuccess else {
            showAlert("패스워드 등록실패")
            return
        }
        showAlert("패스워드 등록성공")
        resetTextField()
    }
    
    private func showAlert(_ message: String) {
            let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
        }
}
