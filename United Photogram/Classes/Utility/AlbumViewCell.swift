//
//  AlbumViewCell.swift
//  United Photogram
//
//  Created by 山浦功 on 2016/11/03.
//  Copyright © 2016年 山浦功. All rights reserved.
//

import UIKit

class AlbumViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


/*
 *機能拡張-----
 */
extension AlbumViewCell{
    func setCell(imageName: String, titleText: String, DescriptionText: String){
        photoImage.image = UIImage(named: imageName)
        photoTitle.text = titleText
        photoDescription.text = DescriptionText
    }
}
