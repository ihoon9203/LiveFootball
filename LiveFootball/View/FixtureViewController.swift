//
//  FixtureViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import UIKit

class FixtureViewController: UIViewController {

    @IBOutlet weak var fixtureDatePicker: UIDatePicker!
    @IBOutlet weak var countryPicker: UITextField!
    @IBOutlet weak var leaguePicker: UIButton!
    var countryList: CountryModelList?
    var leagueList: LeagueModelList?
    var teamList: StandingModelList?
    var simpleFixtures: SimpleFixtureModelList?
    let fixtureViewModel = FixtureViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureViewModel.delegate = self
        fixtureViewModel.getCountryList()
        fixtureViewModel.getLeagueList(code: "GB", season: 2022)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchLeague(_ sender: Any) {
        guard let code = countryPicker.text else { return }
        fixtureViewModel.getLeagueList(code: code, season: 2022)
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
    func notifySimpleFixturesProvided(_ fixtures: SimpleFixtureModelList) {
        simpleFixtures = fixtures
    }
    
    func notifyStandingDataProvided(_ standing: StandingModelList) {
        teamList = standing
    }
    
    func notifyLeagueDataProvided(_ leagues: LeagueModelList) {
        leagueList = leagues
        do {
            for i in 0...4 {
                guard let name = leagueList?.leagues?[i].name else { return }
            }
        } catch {
            print("not enough leagues")
        }
    }
    
    func notifyCountryDataProvided(_ countries: CountryModelList) {
        countryList = countries
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        return cell!
    }
    
    
}
