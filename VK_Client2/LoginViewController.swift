//
//  ViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 09.10.2020.
//

import UIKit
import WebKit

let year = 2020
var user: [String] = [
    "",
    ""
]

final class LoginViewController: UIViewController {
    
    let session = Session.instance
    let serv = Services()
    
    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    /*@IBOutlet weak var stateLabel: UILabel!
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
    */
    
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
        
        
        log(v: session.v)
        super.viewDidLoad()
        
    }
   
    func log(v: String?){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7687002"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: v)
                ]
                
                let request = URLRequest(url: urlComponents.url!)
                
                webview.load(request)
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        print(token as Any)
        
        session.token = token
        session.userId = params["user_id"]
        
        serv.friendsList(userId: session.userId, token: session.token, v: session.v)//friends of user
        serv.photos(userId: session.userId, token: session.token, v: session.v)
        serv.groups(userId: session.userId, token: session.token, v: session.v)
        serv.groupsSearch(userId: session.userId, token: session.token, v: session.v)
        
        decisionHandler(.cancel)
    }
}
