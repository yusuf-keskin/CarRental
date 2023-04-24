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
            guard let data = try? Data(contentsOf: URL(string: imageURLString)!) else { return }
            
            if let image = UIImage(data: data) {
                print("Using web, downloading from link : \(imageURLString)")
                let processedImage = image.resizeImageTo(size: CGSize(width: 250, height: 200.00))
                DispatchQueue.main.async {
                    self?.image = processedImage
                }

            }
        }
        
    }
    
}
    
    extension UIImage {
        
        func resizeImageTo(size: CGSize) -> UIImage? {
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return resizedImage
        }
    }

