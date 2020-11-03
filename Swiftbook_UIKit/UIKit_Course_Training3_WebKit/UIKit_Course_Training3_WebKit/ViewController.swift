 //
//  ViewController.swift
//  UIKit_Course_Training3_WebKit
//
//  Created by Анас Бен Мустафа on 23.09.2020.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WebView: WKWebView!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ForwardButton: UIButton!
    @IBOutlet weak var AdressTF: UITextField!
    
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        if WebView.canGoBack {
            WebView.goBack()
        }
    }
    @IBAction func ForwardButtonTapped(_ sender: UIButton) {
        if WebView.canGoForward {
            WebView.goForward()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdressTF.delegate = self
        WebView.navigationDelegate = self
        
        AdressTF.text = "https://www.apple.com" // homepage
        AdressTF.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        WebView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        WebView.allowsBackForwardNavigationGestures = true
        
    }


}
 
 extension ViewController : UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text
        WebView.load(URLRequest(url: URL(string: urlString!)!))
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        AdressTF.text = WebView.url?.absoluteString
        
        BackButton.isEnabled = WebView.canGoBack
        ForwardButton.isEnabled = WebView.canGoBack
    }
    
    
 }

