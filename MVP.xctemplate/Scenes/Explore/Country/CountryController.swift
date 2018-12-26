
//
//  CountryController.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

class CountryController: BaseViewController, CountryView {
    
    
    
    var configurator = ContryConfiguratorImplementation()
    var presenter: CountryPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(countryControler: self)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initInterface() {
        self.tbCountry.dataSource = self
        self.tbCountry.delegate = self
        self.tbCountry.register(CountryTableViewCell.self)
    }
    
    func refreshCountryView() {
        tbCountry.reloadData()
    }
    
    func displayCountryRetrievalError(title: String, message: String) {
      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    @IBOutlet weak var tbCountry: UITableView!

}
extension CountryController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return presenter.numberOfCountry
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell
        presenter.configure(cell: cell!, forRow: indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}
