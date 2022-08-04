//
//  ViewController.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        bar.placeholder = "Search for Rental"
        bar.directionalLayoutMargins = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        bar.backgroundColor = .lightGray
        bar.layer.borderWidth = 1
        bar.layer.borderColor = UIColor.white.cgColor
        return bar
    }()

    let tableView : UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        table.directionalLayoutMargins = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        table.register(CarCell.self, forCellReuseIdentifier: CarCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.getDataFromServer { dict in
            DataService.instance.parseJson(dict: dict) { carModels in
                print(carModels)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
   
    func setUpNavigation() {
     navigationItem.title = "Keyword Search"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font : UIFont(name: "Avenir", size: 18)!]
    }
    
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier, for: indexPath) as? CarCell else {return UITableViewCell() }
            
        return cell
    }
}

