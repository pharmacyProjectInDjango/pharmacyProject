//
//  ProductController.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 5/1/21.
//

import UIKit
import Kingfisher

class ProductController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let product = product {
//                categoryMedicine.text = product.category
//                imageMedicine.image = product.image
            let posterURL = URL(string: "\(product.image)")
            if let posterURL = posterURL {
                    imageView.kf.setImage(with: posterURL)
            }
            titleLabel.text = product.title
            priceLabel.text = "\(product.price) T"
            descriptionLabel.text = product.description
        }
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if let product = product {
            let vc = storyboard?.instantiateViewController(identifier: "CartController") as! CartController
            CartController.cart.append(product)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
