//
//  AuthViewController.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/18/21.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = UserDefaults.standard.string(forKey: "vkToken") {
            print(Storage.shared.token)
            toMainView()
        }
        
        
        authorization()
        
    }
    
    private func authorization() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7978275"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "friends,wall,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
            
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String : String] ()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"] {
            UserDefaults.standard.set(token, forKey: "vkToken")
            Storage.shared.token = token
            toMainView()
        }
        
        decisionHandler(.cancel)
        
    }
    
    private func toMainView() {
        if let newController = storyboard?.instantiateViewController(identifier: "MainTabBar") as? MainTabBarController {
            newController.modalTransitionStyle = .coverVertical
            newController.modalPresentationStyle = .overCurrentContext
            self.present(newController, animated: true, completion: nil)
        }
    }
}

