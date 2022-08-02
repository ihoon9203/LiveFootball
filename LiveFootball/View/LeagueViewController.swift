//
//  LeagueViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class LeagueViewController: UIViewController {

    let leagueViewModel = LeagueViewModel()
    var leagueModelList: LeagueModelList?
    var standing: [TeamWithStandingModel]?
    var team: TeamInfo?
    var countries: [Country]?
    var countriesForDropDown = [UIAction]()
    var leaguesForDropDown = [UIAction]()
    var selectedCountryCode: String?
    
    
    @IBOutlet weak var standingsTable: UITableView!
    @IBOutlet weak var countryList: UIButton!
    @IBOutlet weak var leagueList: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueViewModel.delegate = self
        countries = CoreDataManager.sharedManager.getAllCountries()
        countries = countries?.sorted(by: { country1, country2 in
            country1.name! < country2.name!
        })
        countries?.map({ country in
            self.countriesForDropDown.append(UIAction(title: country.name ?? "",
                                                      handler: { [weak self]_ in
                self?.countryList.setTitle(country.name ?? "GB" , for: .normal)
                self?.leagueList.setTitle("League", for: .normal)
                self?.leagueViewModel.getLeagueList(code: country.code ?? "GB", season: 2022) }
            ))
        })

        countryList.menu = UIMenu(title: "Country",
                                  identifier: nil,
                                  options: .displayInline,
                                  children: countriesForDropDown )
    }
    func setLeagueList() {
        self.leaguesForDropDown = []
        guard let leagues = leagueModelList?.leagues else { return }
        for league in leagues {
            self.leaguesForDropDown.append(UIAction(title: league.name ?? "",
                                            handler: { [weak self] _ in
                self?.leagueList.setTitle(league.name ?? "" , for: .normal)
                self?.leagueViewModel.getStandingList(leagueCode: league.id, season: 2021)
            }))
        }
        DispatchQueue.main.async {
            self.leagueList.menu = UIMenu(title: "League",
                    identifier: nil,
                    options: .displayInline,
                    children: self.leaguesForDropDown )
        }
    }

}
extension LeagueViewController: LeagueCommunicationProtocol, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standing?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsCell") as! StandingTableViewCell
        cell.rank.text = String((standing?[indexPath.row].rank) as! Int)
        cell.logo.image = UIImage(data: standing?[indexPath.row].teamInfo.logo ?? Data())
        cell.name.text = standing?[indexPath.row].teamInfo.name
        return cell
    }
    
    func notifySpecificTeamSearched(_ team: TeamInfo) {
        self.team = team
    }
    
    func notifyLeagueDataProvided(_ league: LeagueModelList) {
        leagueModelList = league
        setLeagueList()
    }
    func notifyStandingDataProvided(_ standing: StandingModelList) {
        self.standing = standing.teams.sorted(by: { team1, team2 in
            team1.rank! < team2.rank!
        })
        DispatchQueue.main.async {
            self.standingsTable.reloadData()
        }
    }
}
