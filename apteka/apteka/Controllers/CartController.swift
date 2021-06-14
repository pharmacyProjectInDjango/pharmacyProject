//
//  CartController.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 5/1/21.
//

import UIKit

class CartController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    static var cart = [Product]()
    var sumTotal = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.calcTotal()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PharmacyCell.nib, forCellReuseIdentifier: PharmacyCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressPay(_ sender: Any) {
    }
    
    func calcTotal(){
        for item in CartController.cart {
            let num = Double(item.price)
            sumTotal += num ?? 0
        }
        totalLabel.text = "\(sumTotal) $"
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

extension CartController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CartController.cart.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension CartController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartController.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PharmacyCell.identifier, for: indexPath) as! PharmacyCell
        let product = CartController.cart[indexPath.row]
        cell.product = product
//        cell.categoryMedicine.text = product.category
//        cell.imageMedicine.image = product.image
//        cell.nameMedicine.text = product.title
//        cell.priceMedicine.text = "\(product.price) T"
        return cell
    }
    
    
}
