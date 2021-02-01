//
//  SecondVC.swift
//  CurencyExchangeTestTask
//
//  Created by Dmitry Sachkov on 31.01.2021.
//

import UIKit
import Moya

class SecondVC: UIViewController {
    
    @IBOutlet weak var curencyLbl: UILabel!
    @IBOutlet weak var curencyRate: UITableView!
    
    var curency = ""
    var rate: [String: Double]? = nil
    let apiService = MoyaProvider<ApiService>()
    
    
    override func viewWillAppear(_ animated: Bool) {
        apiService.request(.getRate(curency: curency)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(CurencyExchangeRate.self, from: response.data)
                    self.rate = json.rates
                    print(self.rate)
                }
                catch {
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

}

extension SecondVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
