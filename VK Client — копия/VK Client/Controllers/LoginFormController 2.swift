//
//  LoginFormController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.02.2021.
//

import UIKit
import WebKit
import Alamofire

class LoginFormController: LoadingViewController {
    
    let userService = UserService()
    
    let user = Session.shared
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value:
            "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68") ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollTapped))
//        scrollView.addGestureRecognizer(tap)
//
//        showLoading()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: {
//            self.hideLoading()
//        })
    }
    
    // MARK: - Scroll
    
//    @objc func scrollTapped() {
//        scrollView.endEditing(true)
//    }
//    @objc func keyboardWillShow(notification: Notification) {
//        let key = UIResponder.keyboardFrameEndUserInfoKey
//        guard let kbSize = notification.userInfo?[key] as? CGRect else { return }
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
//    }
//    @objc func ​​keyboardWillHide(notification: Notification) {
//        scrollView.contentInset = .zero
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.keyboardWillShow(notification:)),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.​​keyboardWillHide(notification:)),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(
//            self,
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil)
//        NotificationCenter.default.removeObserver(
//            self,
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil)
//    }
    
    // MARK: - Segues
    
//    func validateCredentials() -> Bool {
//        //return loginInput.text == "" && passwordInput.text == ""
//        return true
//    }
//    func showLoginErrorAlert() {
//        let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Попробовать еще", style: .cancel, handler: nil)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        guard identifier == "Друзья и группы" else { return true }
//        let isValid = validateCredentials()
//        if !isValid {
//            showLoginErrorAlert()
//        }
//        return isValid
//    }
    
    
}

extension LoginFormController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return }
        
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
        let userId = params["user_id"]
        print("Token: \(String(describing: token))\nUser ID: \(String(describing: userId))")
        
        decisionHandler(.cancel)
        
        user.token = token!
        user.userId = userId!
        
        userService.loadUserInfo()
        userService.loadFriends()
        userService.loadUserPhotos()
        userService.loadGroups()
        userService.searchByUserGroups()
    }
    
}
