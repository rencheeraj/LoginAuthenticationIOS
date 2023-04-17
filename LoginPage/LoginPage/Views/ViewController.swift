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
    
    private var token : String?
    @IBAction func loginAction(_ sender: Any) {
        guard let user = usernameText.text else {return}
        guard let password = passwordText.text else {return}
            //        let user = "mtestuser"
            //        let password = "mtest_spark"
            let modelLogin = LoginModel(username:user , password: password)
            APICaller.shared.loginApiCalling(login: modelLogin){(result) in
                switch result{
                case .success(let json):
                    print(json)
                    self.token = (json as! ResponseModel).access
                    self.showNextView(tc: self.token)
                case .failure(let err):
                    print(err.localizedDescription )
                    self.alertShow(re: "AuthenticationFailed")
                    
                }
        }
        
    }
    func showNextView(tc : String?){
        DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ImageListViewController") as! ImageListViewController
            nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.token = tc
            self.present(nextViewController, animated:true, completion:nil)
            self.usernameText.text = ""
            self.passwordText.text = ""
        }
    }
    func alertShow(re : String?){
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Access Denied", message: "Username or Password Incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

