//
//  OrderFrameSmallTableViewCell.swift
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

import UIKit

class OrderFrameSmallTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderFrame: OrderFrameSmall!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:[AnyHashable : Any]){
        self.orderFrame.firstProcess(data)
    }
    
}
