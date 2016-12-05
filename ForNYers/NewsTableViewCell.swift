//
//  NewsTableViewCell.swift
//  ForNYers
//
//  Created by Jack Ngai on 12/1/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

// TODO: Delete the elements and start from scratch
// small changes are not working, for whatever reason

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsBy: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // old code to troubleshoot issue with image overlapping text
        // newsImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        
        
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
