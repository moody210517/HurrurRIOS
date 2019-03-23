//
//  OrderFrameExpandTableViewCell.swift
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

import UIKit

class OrderFrameExpandTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var orderFrame: OrderFrameExpand!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:[AnyHashable:Any]){
        self.orderFrame.firstProcess(data)
    }
}
