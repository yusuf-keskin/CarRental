//
//  NotifDataVC.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import UIKit

class NotifDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Coordinating {
    
    var coordinator: Coordinator?
    
    let tableView : UITableView = {
        let tablee = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height : UIScreen.main.bounds.height))
        tablee.rowHeight = 60
        tablee.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        return tablee
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier) as? DataCell
        cell?.configureCell(nameLbl: "Merhaba", descLbl: "Naber nasılsın")
        return cell!
    }

}
 
