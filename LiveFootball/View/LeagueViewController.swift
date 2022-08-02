//
//  LeagueViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class LeagueViewController: UIViewController {

    let leaueViewModel = LeagueViewModel()
    var leagueModelList: LeagueModelList?
    var standing: StandingModelList?
    var team: TeamInfo?
    var countries: [CountryEntity]?
    var countriesForDropDown = [UIAction]()
    var selectedCountryName: String?
    
    
    @IBOutlet weak var countryList: UIButton!
    @IBOutlet weak var leagueList: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries = CoreDataManager.sharedManager.getAllCountries()
        countries?.map({ country in
            self.countriesForDropDown.append(UIAction(title: country.name ?? "", handler: {_ in self.selectedCountryName = country.name}))
        })
        countryList.titleLabel?.text = "Country"

        countryList.menu = UIMenu(title: "Country",
                                  identifier: nil,
                                  options: .displayInline,
                                  children: countriesForDropDown ?? [])
        print(countriesForDropDown)
    }
    

}
extension LeagueViewController: LeagueCommunicationProtocol , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsCell")
        return cell!
    }
    
    func notifySpecificTeamSearched(_ team: TeamInfo) {
        self.team = team
    }
    
    func notifyLeagueDataProvided(_ league: LeagueModelList) {
        leagueModelList = league
    }
    func notifyStandingDataProvided(_ standing: StandingModelList) {
        self.standing = standing
    }
}
