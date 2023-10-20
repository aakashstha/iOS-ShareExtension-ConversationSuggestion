//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Aakash Shrestha on 20/10/2023.
//

import UIKit
import Intents
import IntentsUI

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intent = self.extensionContext?.intent as? INSendMessageIntent
        if intent != nil {
            let conversationIdentifier = intent!.conversationIdentifier
            print("\nconversationIdentifier: \(conversationIdentifier as Any)")
            if(conversationIdentifier! == "sampleConversationIdentifier_ID1") {
                print("Dada")
            } else {
                print("Vai")
            }
            
            
            showSimpleAlert()

        } else {
            
//          Next view Controller
            guard let vc = storyboard?.instantiateViewController(identifier: "AppSuggShareController") else {
                print("failed to get vc from storyboard")
                return
            }
            present(vc, animated: true)
        
        }
    }
    
//    function to display pop up
    func showSimpleAlert() {
        
        let alert = UIAlertController(title: "Send to MyApp", message: "Sharing with Aakash", preferredStyle: .alert)

        let action = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)

        }
       let action2 =  UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,
                                           handler: {(_: UIAlertAction!) in
           
           self.startLoader()
           
    })

        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    func startLoader()  {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        self.stopLoader()
    }
    
    func stopLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated:true, completion: nil)
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        }
    }
}
