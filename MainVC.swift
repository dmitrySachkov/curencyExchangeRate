//
//  ViewController.swift
//  CurencyExchangeTestTask
//
//  Created by Dmitry Sachkov on 31.01.2021.
//

import UIKit
import Moya

class MainVC: UIViewController {

    @IBOutlet weak var Favorite: UILabel!
    @IBOutlet weak var curency: UILabel!
    @IBOutlet weak var favoriteCurencyTable: UITableView!
    @IBOutlet weak var curencyTable: UITableView!
    
    let apiService = MoyaProvider<ApiService>()
    var masterCurencyArray = ["USD"]
    var curencyArray = [String]()
    var curencyString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFavoriteTable()
        apiService.request(.getCurency) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(CurencyData.curency.self, from: response.data)
                    self.curencyArray.append(contentsOf: json.keys)
                    print(self.curencyArray)
                    self.curencyTable.reloadData()
                }
                catch {
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupFavoriteTable() {
        favoriteCurencyTable.delegate = self
        favoriteCurencyTable.dataSource = self
        curencyTable.delegate = self
        curencyTable.dataSource = self
        favoriteCurencyTable.reloadData()
        curencyTable.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        
    }
    
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case favoriteCurencyTable:
            return masterCurencyArray.count
        case curencyTable:
            return curencyArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView {
        case favoriteCurencyTable:
            cell.textLabel?.text = masterCurencyArray[indexPath.row]
            return cell
        case curencyTable:
            cell.textLabel?.text = curencyArray[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var curencyTwo = curencyArray[indexPath.row]
        var curencyOne = masterCurencyArray[indexPath.row]
        switch tableView {
        case favoriteCurencyTable:
            tableView.deselectRow(at: indexPath, animated: true)
            curencyString = curencyOne
            deletCurency()
        case curencyTable:
            tableView.deselectRow(at: indexPath, animated: true)
            curencyString = curencyTwo
            addCurency()
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Alert message
    func addCurency() {
        let alert = UIAlertController(title: "Add curency?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            self.masterCurencyArray.append(self.curencyString)
            self.favoriteCurencyTable.reloadData()
            self.curencyArray = self.curencyArray.filter() {$0 != self.curencyString}
            self.curencyTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            print("end tapped")
        }))
        present(alert, animated: true)
    }
    
    func deletCurency() {
        let alert = UIAlertController(title: "Delet curency?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delet", style: .destructive, handler: { (action) in
            self.masterCurencyArray = self.masterCurencyArray.filter() {$0 != self.curencyString}
            self.favoriteCurencyTable.reloadData()
            self.curencyArray.append(self.curencyString)
            self.curencyTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Rate", style: .default, handler: { (action) in
            let vc = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
            let curency = self.curencyString
            vc.curency = curency
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            print("end tapped")
        }))
        present(alert, animated: true)
    }
}

