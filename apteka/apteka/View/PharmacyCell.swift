//
//  PharmacyCell.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 5/1/21.
//

import UIKit
import Kingfisher

class PharmacyCell: UITableViewCell {
    
    static let identifier = String(describing: PharmacyCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var imageMedicine: UIImageView!
    @IBOutlet weak var priceMedicine: UILabel!
    @IBOutlet weak var nameTextField: UILabel!
    
    
    var product: Product? {
        didSet {
            if let product = product {
//                categoryMedicine.text = product.category
//                imageMedicine.image = product.image
                let posterURL = URL(string: product.image)
                imageMedicine.kf.setImage(with: posterURL)
                nameTextField.text = product.title
                priceMedicine.text = "\(product.price) T"
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
