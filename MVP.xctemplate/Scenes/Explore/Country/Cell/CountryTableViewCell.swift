//
//  CountryTableViewCell.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, CountryCellView{
    
    @IBOutlet weak var lbNameCountry: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(itemRegion: ItemRegionEntity) {
        lbNameCountry.text = itemRegion.snippet!.name
    }
    
}
