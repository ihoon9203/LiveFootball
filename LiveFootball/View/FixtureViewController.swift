//
//  FixtureViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import UIKit

class FixtureViewController: UIViewController {

    @IBOutlet weak var fixtureDatePicker: UIDatePicker!
    @IBOutlet weak var nationPicker: UIButton!
    @IBOutlet weak var leaguePicker: UIButton!
    
    let fixtureViewModel = FixtureViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureViewModel.delegate = self
        fixtureViewModel.getCountryList()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FixtureViewController: UITableViewDelegate, UITableViewDataSource, FixtureCommunicationProtocol {
    func notifyFixtureDataProvided(_ countries: CountryModelList) {
        nationPicker.menu?.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        return cell!
    }
    
    
}
