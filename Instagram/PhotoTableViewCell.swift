//
//  PhotoTableViewCell.swift
//  
//
//  Created by Nathan Ansel on 1/30/16.
//
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

  @IBOutlet weak var pictureView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
