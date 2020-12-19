//
//  SearchResponseCell.swift
//  WAkz
//
//  Created by Almagul Musabekova on 19.12.2020.
//

import UIKit

class SearchResponseCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageResponse: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.3)
        selectedBackgroundView = view
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
