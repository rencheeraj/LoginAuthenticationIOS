//
//  ViewController.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 12/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
        guard let user = usernameText.text else {return}
        guard let password = passwordText.text else {return}
        let modelLogin = LoginModel(username:user , password: password)
        APIManger.shareInstance.loginApiCalling(login: modelLogin){(result) in
            switch result{
            case .success(let json):
                print(json as AnyObject)
            case .failure(let err):
                print(err.localizedDescription )
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

