//
//  UIImageViewExtension.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 4.08.2022.
//

import UIKit

extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!)?.resizeImage(with: CGSize(width: 140, height: 140)) : UIImage(named: "default.png")
            }
        }
    }

}
