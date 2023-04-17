//
//  ImageTableViewCell.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 13/04/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageListView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(url : String){
        imageListView.load(urlString: url)
    }

}
