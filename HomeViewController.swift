//
//  HomeViewController.swift
//  SkinCare Project
//
//  Created by TDI Student on 21.9.22.
//

import UIKit
import CoreData

class HomeViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    
    var productsArray : [Product] = []
    
    var menu = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    
    //Segue
    var options: [optionsMenu] = [
        
        optionsMenu(title: "Home", segue: "HomeSegue"),
        optionsMenu(title: "AboutUs",
               segue: "aboutUsSegue"),
        optionsMenu(title: "Contact",
               segue: "contactsSegue"),
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
        home = containerView.transform
        ProductsCollectionView.layer.cornerRadius = 25
        setUpCollectionView()
        
        if UserDefaults.standard.bool(forKey: "notFirstEntry") {
            fetchData()
        } else {
            UserDefaults.standard.set(true, forKey: "notFirstEntry")
            getProducts()
        }
    }
    
    func getProducts() {
        ProductRequests.getProducts { products, error in
            if let products = products {
                self.productsArray = products
                self.ProductsCollectionView.reloadData()
                self.saveData() 
            }
        }
    }
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context!)
        
        for product in productsArray {
            let productMO = NSManagedObject(entity: entity!, insertInto: context)
            productMO.setValue(product.name, forKey: "name")
            productMO.setValue(product.image, forKey: "image")
            productMO.setValue(product.Description, forKey: "descriptionn")
        }
        
        
        do {
            try context!.save()
            print("Data saved successfully on CoreData ")
        } catch {
             print("Products could not be saved")
        }
    }
    
    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        
        do {
            let results = try context!.fetch(request)
            for productMO in ((results as? [NSManagedObject])!) {
                let product = Product()
                product.name = (productMO.value(forKey: "name") ?? "") as? String
                product.image = (productMO.value(forKey: "image") ?? "") as? String
                product.Description = (productMO.value(forKey: "descriptionn") ?? "") as? String
                productsArray.append(product)
            }
            ProductsCollectionView.reloadData()
            print("Saved data fetched successfully.")
        } catch {
                print("Could not fetch data.")
        }
    }
    
    //Menu
    
    func showMenu(){
//        self.imgHome.layer.cornerRadius
        imgHome.clipsToBounds = true
        imgHome.layer.cornerRadius = 25
        imgHome.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        self.containerView.layer.cornerRadius = 40
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransfrom = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = scaledAndTranslatedTransfrom
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = self.home
            self.containerView.layer.cornerRadius = 0
            self.containerView.layer.cornerRadius = self.containerView.layer.cornerRadius
            self.imgHome.layer.cornerRadius = 0
        }
    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        if menu == false && swipeGesture.direction == .right
        {
            showMenu()
            menu = true
        }
    }
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            hideMenu()
            menu = false
        }
    }
    //CollectionView
    
    func setUpCollectionView(){
        ProductsCollectionView.delegate = self
        ProductsCollectionView.dataSource = self
        ProductsCollectionView.register(UINib(nibName: "ProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductsCollectionViewCell
        cell.delegate = self
        cell.setDetails(products: productsArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ProductsCollectionView.frame.width/3)-8, height: ((ProductsCollectionView.frame.width/3)-8)*1.6)
    }
    
//    func createProduct(){
//        let product1 = Products(image: "a.jpg", name: "SUEDE", Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product1)
//        let product2 = Products(image: "b.jpg", name: "LEMON BITERS",  Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product2)
//        let product3 = Products(image: "c.jpg", name: "JASMINE",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product3)
//        let product4 = Products(image: "d.jpg", name: "COSTAILOR",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product4)
//        let product5 = Products(image: "e.jpg", name: "REAL SENSATION",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product5)
//        let product6 = Products(image: "f.jpg", name: "NATURAL SUN",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product6)
//        let product7 = Products(image: "g.jpg", name: "PEARLESSENCE",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product7)
//        let product8 = Products(image: "h.jpg", name: "RITUALS",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product8)
//        let product9 = Products(image: "i.jpg", name: "GLOSSIER",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product9)
//        let product10 = Products(image: "j.jpg", name: "NÈCESSAIRE",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product10)
//        let product11 = Products(image: "k.jpg", name: "TONIK",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product11)
//        let product12 = Products(image: "l.jpg", name: "ACT+ACRE",Description: "This lightweight 100% mineral tinted face sunscreen with titanium dioxide was developed for sensitive skin. The fast-absorbing texture leaves a tinted matte finish on skin for a healthy glow. It is formulated with Cell-Ox Shield® technology: broad spectrum UVA/UVB protection with antioxidants.")
//        productsArray.append(product12)
//
//        ProductsCollectionView.reloadData()
//
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let productDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
//        productDetailsVC.product = productsArray[indexPath.item]
//        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.backgroundColor = .clear
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell


            UIView.animate(withDuration: 0.5) {
                currentCell.alpha = 0.5
                tableView.deselectRow(at: indexPath, animated: true)
            }
            self.parent?.performSegue(withIdentifier: options[indexPath.row].segue ?? "" , sender: self)
        }
     
    }
  
}

class tableViewCell: UITableViewCell {
    @IBOutlet var descriptionLabel: UILabel!
}

extension HomeViewController: ProductDelegate {
    func seeMore(product: Product) {
        let productDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productDetailsVC.product = product
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
}
