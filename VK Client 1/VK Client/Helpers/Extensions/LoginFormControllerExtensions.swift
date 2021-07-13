//
//  LoginFormControllerExtensions.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.06.2021.
//

import UIKit
import WebKit

extension LoginFormController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment
        else {
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
        let userId = params["user_id"]

        decisionHandler(.cancel)

        user.token = token!
        user.userId = userId!

    // MARK: - Segue
        
        guard let controller = storyboard?.instantiateViewController(identifier: "TabBarViewController") else { return }
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
