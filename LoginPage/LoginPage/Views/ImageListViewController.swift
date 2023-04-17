//
//  ImageListViewController.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 13/04/23.
//

import UIKit
import Kingfisher

class ImageListViewController: UIViewController {
    @IBOutlet weak var imageListingTableView: UITableView!
    var token : String?
    var imageData : [ImageListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APICaller.shared.detailImageList(token: self.token!) {(result) in
            switch result{
            case .success(let json):
                print(json)
                self.imageData = json as! [ImageListModel]
                DispatchQueue.main.async {
                        self.imageListingTableView.reloadData()
                                }
            case .failure(let err):
                print(err.localizedDescription )
            }
        }
        imageListingTableView.dataSource = self
        imageListingTableView.delegate = self
        self.imageListingTableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
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
extension ImageListViewController : UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageData?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ImageTableViewCell", for: indexPath) as?
                        ImageTableViewCell else {
                    fatalError("Unable to downcast the cell in cellForRowAt to ItemTableViewCell")
                }
        
            let url = URL(string: imageData![indexPath.row].image_link ?? "")
            cell.imageListView.kf.setImage(with: url)
            return cell
    }
    
    
}
extension ImageListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
