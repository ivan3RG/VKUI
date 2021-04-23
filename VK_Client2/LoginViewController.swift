//
//  ViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 09.10.2020.
//

import UIKit

let year = 2020
var user: [String] = [
    "",
    ""
]


final class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var vkLabel: UILabel!
    @IBOutlet weak var logReg: UISegmentedControl!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
        
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if logReg.selectedSegmentIndex == 0 && login.text == user[0] && password.text == user[1] && login.text != "" && password.text != "" {
                stateLabel.text = "Добро пожаловать!"
                return true
            } else if logReg.selectedSegmentIndex == 1 {
                user[1] = password.text ?? ""
                user[0] = login.text ?? ""
                stateLabel.text = "Пользователь зарегистрирован"
                return false
            }
            stateLabel.text = "Введены неверные данные"
            return false
        }
    
    
    @IBAction func Tap(_ sender: Any) {
        scrollView.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        guard let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = keyboardRect.height
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    override func viewDidLoad() {
        /*let VKLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        VKLabel.text = "VK©/year"
        VKLabel.textColor = UIColor.white
        
        view.backgroundColor = UIColor.blue
        
        view.addSubview(VKLabel)*/
        
        vkLabel.text = "VK©\(year)"
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
   
    


}

