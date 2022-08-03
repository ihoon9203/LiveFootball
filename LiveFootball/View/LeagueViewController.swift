//
//  LeagueViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class LeagueViewController: UIViewController {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var matchPlayedLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var gdLabel: UILabel!
    @IBOutlet weak var ptsLabel: UILabel!
    let leagueViewModel = LeagueViewModel()
    var leagueModelList: LeagueModelList?
    var standing: [TeamWithStandingModel]?
    var team: TeamInfo?
    var countries: [Country]?
    var countriesForDropDown = [UIAction]()
    var leaguesForDropDown = [UIAction]()
    var selectedCountryCode: Int?
    var selectedLeagueCode: Int?
    let selectedSeason = Calendar.current.component(.year, from: Date())
    var labels: [UILabel]!
    
    @IBOutlet weak var standingsTable: UITableView!
    @IBOutlet weak var countryList: UIButton!
    @IBOutlet weak var leagueList: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labels = [rankLabel, matchPlayedLabel, winLabel, drawLabel, loseLabel, gdLabel, ptsLabel]
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
                self?.leagueViewModel.getLeagueList(code: country.code ?? "GB", season: self?.selectedSeason ?? 2022) }
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
                self?.selectedLeagueCode = league.id
                self?.leagueViewModel.getStandingList(leagueCode: league.id, season: self?.selectedSeason ?? 2022)
            }))
        }
        DispatchQueue.main.async {
            self.leagueList.menu = UIMenu(title: "League",
                    identifier: nil,
                    options: .displayInline,
                    children: self.leaguesForDropDown )
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.standingsTable.indexPathForSelectedRow {
            let team = self.standingsTable.cellForRow(at: index) as! StandingTableViewCell
            let teamId = team.teamId
            let destinationVC = segue.destination as! TeamViewController
            destinationVC.teamId = teamId
            destinationVC.leagueCode = selectedLeagueCode
            destinationVC.season = selectedSeason
        } //NavigationItem.title on collectionViewController
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
        cell.matchPlayed.text = String(standing?[indexPath.row].played ?? 0)
        cell.win.text = String(standing?[indexPath.row].win ?? 0)
        cell.draw.text = String(standing?[indexPath.row].draw ?? 0)
        cell.lose.text = String(standing?[indexPath.row].lose ?? 0)
        cell.goalDiff.text = String(standing?[indexPath.row].goalsDiff ?? 0)
        cell.pts.text = String(standing?[indexPath.row].points ?? 0)
        cell.teamId = standing?[indexPath.row].teamInfo.id
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StandingTableViewCell
        performSegue(withIdentifier: "teamViewSegue", sender: self)
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
            for label in self.labels {
                label.isHidden = false
            }
        }
    }
}
