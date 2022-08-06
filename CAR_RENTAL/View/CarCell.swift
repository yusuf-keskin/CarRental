//
//  carCell.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 2.08.2022.
//

import UIKit

class CarCell: UITableViewCell {
    static let identifier = "carCell"
    
    let carImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img      }()
    
    let carNameLbl:UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(carImage)
        contentView.addSubview(carNameLbl)
      
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        carImage.frame = CGRect(x: 10,
                                y: 5,
                                width: 140,
                                height: 90)
        
        carNameLbl.frame = CGRect(x: 170,
                                  y: 10,
                                  width: contentView.frame.size.width - 190,
                                  height: 90)
    }
    
    func configureCell (image : UIImage, name : String) {
        carNameLbl.text = name
        carImage.image = image
    }

}
