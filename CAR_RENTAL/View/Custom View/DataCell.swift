//
//  DataCell.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import UIKit

import UIKit

class DataCell: UITableViewCell {
    static let identifier = "dataCell"
    
    let nameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey"
        return label
    }()
    
    let descLbl:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLbl)
        contentView.addSubview(descLbl)
      
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descLbl.text = ""
        nameLbl.text = ""
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLbl.frame = CGRect(x: 10,
                                y: 5,
                                width: contentView.frame.size.width - 20 ,
                                height: 20)
        
        descLbl.frame = CGRect(x: 10,
                                  y: 30,
                                  width: contentView.frame.size.width - 20,
                                  height: 20)
    }
    
    func configureCell (nameLbl : String, descLbl : String) {
        self.nameLbl.text = nameLbl
        self.descLbl.text = descLbl
    }

}

