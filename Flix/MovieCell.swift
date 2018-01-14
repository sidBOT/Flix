//
//  MovieCell.swift
//  Flix
//
//  Created by siddhant on 1/14/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
