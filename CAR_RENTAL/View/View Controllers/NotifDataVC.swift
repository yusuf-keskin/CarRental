//
//  NotifDataVC.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.08.2022.
//

import UIKit

class NotifDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let refreshTableViewNotification  = Notification.Name("RefreshTableViewNotification")
    
    var coordinator: Coordinator?
    
    let tableView : UITableView = {
        let tablee = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height : UIScreen.main.bounds.height))
        tablee.rowHeight = 60
        tablee.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        tablee.backgroundColor = .white
        return tablee
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NotifDataVC.refreshTableViewNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
    }

    
    @objc func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FileSystemStorage.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier) as? DataCell
        let indexPath = FileSystemStorage.shared.items[indexPath.row]
        cell?.configureCell(nameLbl: indexPath.title, descLbl: indexPath.body)
        cell?.backgroundColor = .white
        return cell!
    }

}
 
