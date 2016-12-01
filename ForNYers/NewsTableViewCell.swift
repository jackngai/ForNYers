//
//  NewsTableViewCell.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/29/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import Foundation

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsBy: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        //newsImage.image?.size = CGSize(width: 120, height: 90)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImage.image = nil
        newsTitle.text = ""
        newsDescription.text = ""
        newsDate.text = ""
        newsBy.text = ""
    }

}
