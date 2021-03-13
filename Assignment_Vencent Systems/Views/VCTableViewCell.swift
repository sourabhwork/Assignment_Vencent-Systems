//
//  VCTableViewCell.swift
//  Assignment_Vencent Systems
//
//  Created by Sourabh Kumbhar on 13/03/21.
//  Copyright © 2021 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class VCTableViewCell: UITableViewCell {
    
    // IBOutlet varibales 
    @IBOutlet weak var imgView          : UIImageView!
    @IBOutlet weak var titlLbl          : UILabel!
    @IBOutlet weak var detailsTitlLbl   : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        titlLbl.text = ""
        detailsTitlLbl.text = ""
    }
    
    func configureCell(user: User) {
        if let name = user.name {
            titlLbl.text = name
        }
        if let email = user.email {
            detailsTitlLbl.text = email
        }
        if let avtar = user.avatar {
            imgView.downloaded(from: avtar)
        } else {
            imgView.image = #imageLiteral(resourceName: "programmer")
        }
    }

}
