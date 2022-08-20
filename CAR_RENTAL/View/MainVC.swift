//
//  ViewController.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating {
    
    static let identifier = "mainVC"
    var rentalModel = RentalViewModel()
    var modelData = Observable<[CarModel]>([CarModel]())
    
    
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
        modelData.bind { [self] _ in
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
                print("tableVievReloaded")
            }
        }
        
        rentalModel.searchWord.bind { [self] _ in
            print("searchword bind")
            rentalModel.updateSearch { carModels in
                self.modelData.value = carModels
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
        
        let LogOutBtn = UIBarButtonItem()
        LogOutBtn.title = "Log Out"
        LogOutBtn.style = .plain
        LogOutBtn.target = self
        LogOutBtn.action = #selector(logOut(sender:))
        self.navigationItem.setRightBarButton(LogOutBtn, animated: true)
         
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
   
    func setUpNavigation() {
        navigationItem.title = AuthService.insance.storedUserName
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font : UIFont(name: "Avenir", size: 18)!]
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text != "" {
            rentalModel.searchWord.value = text
        }

    }
    
    @objc func logOut(sender: UIBarButtonItem) {
        print("Hey")
        AuthService.insance.logoutUser { [self] status in
            goToLogin()
        }
    }
    
    func goToLogin() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}


extension MainVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier, for: indexPath) as? CarCell else {return UITableViewCell() }
        if modelData.value.count != 0 {
            let index = modelData.value[indexPath.row]
            cell.carNameLbl.text = index.name
            cell.carImage.setCustomImage(index.imageUrl)
        }
        return cell
        
    }
}

