//
//  ViewController.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating {

    var rentalModel = RentalViewModel()
    var modelData = [CarModel]()
    
    let searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    let tableView : UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        table.directionalLayoutMargins = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        table.register(CarCell.self, forCellReuseIdentifier: CarCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rentalModel.model.bind { _ in
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
                print("model called")
            }
        }
        
        setUpNavigation()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
   
    func setUpNavigation() {
     navigationItem.title = "Keyword Search"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font : UIFont(name: "Avenir", size: 18)!]
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        rentalModel.searchWord.value = text
        rentalModel.searchWord.bind { _ in
            print("searchword bind")
            self.rentalModel.updateSearch { [self] success in
                self.modelData = rentalModel.model.value
                print(modelData)
            }
        }
    }
}


extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier, for: indexPath) as? CarCell else {return UITableViewCell() }
        if modelData.count != 0 {
            let index = modelData[indexPath.row]
            cell.carNameLbl.text = index.name
            cell.carImage.setCustomImage(index.imageUrl)
        }
        return cell
        
    }
}

