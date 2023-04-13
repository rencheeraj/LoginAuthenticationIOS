//
//  ImageListViewController.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 13/04/23.
//

import UIKit

class ImageListViewController: UIViewController {
    var token : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIManger.shareInstance.detailImageList(token: self.token!) {(result) in
            switch result{
            case .success(let json):
                print(json)
            case .failure(let err):
                print(err.localizedDescription )
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
