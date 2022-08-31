//
//  LaunchesViewController.swift
//  Test Kontur
//
//  Created by Александр on 29.08.2022.
//

import Foundation

import UIKit

class LaunchesViewController : UIViewController {
   
   // MARK: - Properties
   
   let shipManager = ShipsManager()
   
   private let tableView: UITableView = {
      let tableView = UITableView()
      tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: "cell")

      tableView.backgroundColor = .black
      tableView.translatesAutoresizingMaskIntoConstraints = false
      return tableView
   }()
      
   private let launchesTableViewCell = LaunchesTableViewCell()
   private let cellID = "cellID"
   
   var shipID = ""
   private var shipLaunches = [Launch]()
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .black
      view.addSubview(tableView)
      tableView.delegate = self
      tableView.dataSource = self
      shipManager.requestLaunches { [weak self] result in
         switch result {
         case .success(let launches):
            self?.filterLaunches(launches: launches)
         case .failure(let error) :
            print(error.localizedDescription)
         }
      }
   }
   
   private func filterLaunches(launches: [Launch]) {
      
      print(launches)
      let filteredLaunches = launches.filter { launch in
         launch.rocket.rawValue == shipID
      }

      shipLaunches = filteredLaunches.reversed()
      tableView.reloadData()
      print(shipLaunches.count)
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      tableView.frame = CGRect(x: 0, y: 100,
                               width: view.frame.size.width,
                               height: view.frame.size.height - 100)
   }
   
   //MARK: - Setups

   
}

//MARK: - UITableViewDelegate

extension LaunchesViewController: UITableViewDelegate {
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      100
   }
}

//MARK: - UITableViewDataSource

extension LaunchesViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      shipLaunches.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LaunchesTableViewCell
      let launch = shipLaunches[indexPath.row]
      cell.configure(launch: launch)
      return cell
   }
}
