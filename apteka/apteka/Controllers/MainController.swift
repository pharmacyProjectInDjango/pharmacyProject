//
//  MainController.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 4/16/21.
//

import UIKit
import Alamofire

class MainController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var catalogueArr = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    var categoriesArr = [Category]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var url: URL? {
        return URL(string: "http://127.0.0.1:8000/api/products/")
    }
    
    var categoryUrl: URL? {
        return URL(string: "http://127.0.0.1:8000/api/categories/")
    }
    
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PharmacyCell.nib, forCellReuseIdentifier: PharmacyCell.identifier)
        
        getCatalogue(page: 1) { (products) in
            self.catalogueArr += products
        }
        getCategory { (categories) in
            self.categoriesArr = categories
        }
        // Do any additional setup after loading the view.
    }
    
//    func setCategories(){
//        categoriesArr.append("Antibiotiki")
//        categoriesArr.append("Drugs")
//    }

    @IBAction func profileButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cartButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartController") as! CartController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCatalogue(page: Int,_ completion: @escaping ([Product]) -> Void) {
        var params : [String:Any] = [:]
        params["limit"] = 5
        params["offset"] = 5*page

        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(url!, method: .get, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result{
                case .success:
                    if let data = response.data {
                        DispatchQueue.global().async {
                            do {
                                let productsJSON = try JSONDecoder().decode(ProductRequest.self, from: data)
                                DispatchQueue.main.async {
                                    completion(productsJSON.products)
                                }
                            } catch let JSONerror {
                                print(JSONerror)
                            }
                        }
                    }
                case .failure:
                    print("Trending Movie failed to send JSON")
            }
        }
    }

    func getCategory(_ completion: @escaping ([Category]) -> Void) {
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(categoryUrl!, method: .get, parameters: nil, headers: headers).responseJSON { (response) in
            switch response.result{
                case .success:
                    if let data = response.data {
                        DispatchQueue.global().async {
                            do {
                                let categoriesJSON = try JSONDecoder().decode(CategoryRequest.self, from: data)
                                DispatchQueue.main.async {
                                    completion(categoriesJSON.categories)
                                }
                            } catch let JSONerror {
                                print(JSONerror)
                            }
                        }
                    }
                case .failure:
                    print("Trending Movie failed to send JSON")
            }
        }
    }
    
}

extension MainController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset >= 10 && deltaOffset < 200 {
            pageNumber += 1
            self.getCatalogue(page: pageNumber) { (products) in
                self.catalogueArr += products
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = catalogueArr[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "ProductController") as! ProductController
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogueArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PharmacyCell.identifier, for: indexPath) as! PharmacyCell
        let product = catalogueArr[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}

extension MainController: UICollectionViewDelegate {
    
}

extension MainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        let label = cell.contentView.viewWithTag(101) as! UILabel
        
        label.text = categoriesArr[indexPath.row].name
        return cell
    }
    
    
}
