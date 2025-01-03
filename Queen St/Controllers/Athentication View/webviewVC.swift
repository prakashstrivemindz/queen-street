//
//  webviewVC.swift
//  Queen St
//
//  Created by iMac on 27/12/24.
//

import UIKit
import WebKit

class webviewVC: BaseVC {

    //MARK: - Outlets
    @IBOutlet weak var webview: WKWebView!
    
    
    //MARK: - Object and variables
    var strURL = ""
    
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        Initialize()
    }
    
    //MARK: - Initialize

    func Initialize()
    {
        webview.navigationDelegate = self
        webview.uiDelegate = self
        
     
//        let contentController = WKUserContentController()
//        contentController.add(self, name: "buttonActionHandler")
//        
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//        
//        // Inject JavaScript to listen for button clicks
//        let jsScript = """
//              document.addEventListener('click', function(event) {
//                  if (event.target.tagName === 'BUTTON') {
//                      window.webkit.messageHandlers.buttonActionHandler.postMessage({
//                          actionType: event.target.getAttribute('data-action'),
//                          buttonId: event.target.id
//                      });
//                  }
//              });
//              """
//        let userScript = WKUserScript(source: jsScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        contentController.addUserScript(userScript)
//        
//        webview.configuration.userContentController = contentController
        
        let urlString = strURL
        
        
        if let url = URL(string: urlString) {
            webview.load(URLRequest(url: url))
        }
    }
    
    //MARK: - button action

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    

}

//MARK: - Webview methods
extension webviewVC: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
        self.createMainLoaderInView("")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("End loading")
        self.stopLoaderAnimation()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Handle errors here
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        preferences.preferredContentMode = .recommended
        
        if (navigationAction.navigationType != .linkActivated){
            decisionHandler(.allow, preferences)
        } else {
            decisionHandler(.cancel, preferences)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message)
    }
    
}

