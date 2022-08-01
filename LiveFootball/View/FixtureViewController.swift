//
//  FixtureViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import UIKit

class FixtureViewController: UIViewController {
    
    @IBOutlet weak var league1: UIButton!
    @IBOutlet weak var league2: UIButton!
    @IBOutlet weak var league3: UIButton!
    @IBOutlet weak var league4: UIButton!
    
    
    @IBOutlet weak var countryCodeField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var fixtureTable: UITableView!
    var countryList: CountryModelList?
    var leagueList: LeagueModelList?
    var simpleFixtures: SimpleFixtureModelList?
    let fixtureViewModel = FixtureViewModel()
    var leagueButtons: [UIButton] = []
    var selectedID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureViewModel.delegate = self
        fixtureViewModel.getCountryList()
        leagueButtons = [league1, league2, league3, league4]
        // Do any additional setup after loading the view.
    }
    @IBAction func league1Selected(_ sender: Any) {
        fixtureViewModel.getRangedFixtureData(from: datePicker.date, range: 7, leagueCode: leagueList?.leagues?[0].id ?? 39, season: DateParser.getYearFromDate(date: datePicker.date))
    }
    @IBAction func league2Selected(_ sender: Any) {
        fixtureViewModel.getRangedFixtureData(from: datePicker.date, range: 7, leagueCode: leagueList?.leagues?[1].id ?? 40, season: DateParser.getYearFromDate(date: datePicker.date))
    }
    @IBAction func league3Selected(_ sender: Any) {
        fixtureViewModel.getRangedFixtureData(from: datePicker.date, range: 7, leagueCode: leagueList?.leagues?[2].id ?? 41, season: DateParser.getYearFromDate(date: datePicker.date))
    }
    @IBAction func league4Selected(_ sender: Any) {
        fixtureViewModel.getRangedFixtureData(from: datePicker.date, range: 7, leagueCode: leagueList?.leagues?[3].id ?? 42, season: DateParser.getYearFromDate(date: datePicker.date))
        
    }
    
    @IBAction func searchLeagues(_ sender: Any) {
        let season = DateParser.getYearFromDate(date: datePicker.date)
        fixtureViewModel.getLeagueList(code: countryCodeField.text ?? "GB", season: season)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.fixtureTable.indexPathForSelectedRow {
            let fixture = self.fixtureTable.cellForRow(at: index) as! SimpleFixtureTableViewCell
            let fixtureId = fixture.id
            let destinationVC = segue.destination as! FixtureDetailViewController
            destinationVC.fixtureCode = fixtureId
        } //NavigationItem.title on collectionViewController
    }
}

extension FixtureViewController: UITableViewDelegate, UITableViewDataSource, FixtureCommunicationProtocol {
    func notifySimpleFixturesProvided(_ fixtures: SimpleFixtureModelList) {
        simpleFixtures = fixtures
        DispatchQueue.main.async {
            self.fixtureTable.reloadData()
        }
    }
    
    func notifyLeagueDataProvided(_ leagues: LeagueModelList) {
        leagueList = leagues
        if (leagueList?.leagues?.count)! > 3 {
            for i in 0...3 {
                guard let name = leagueList?.leagues?[i].name else { return }
                DispatchQueue.main.async {
                    self.leagueButtons[i].titleLabel?.text = name
                }
            }
        } else {
            for i in 0..<(leagueList?.leagues?.count)! {
                guard let name = leagueList?.leagues?[i].name else { return }
                DispatchQueue.main.async {
                    self.leagueButtons[i].titleLabel?.text = name
                }
            }
        }
    }
    
    func notifyCountryDataProvided(_ countries: CountryModelList) {
        CoreDataManager.sharedManager.enlistCountries(countryList: countries)
        countryList = countries
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SimpleFixtureTableViewCell
        performSegue(withIdentifier: "viewFixtureData", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if simpleFixtures == nil {
            return 0
        }
        return (simpleFixtures?.fixtures.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleFixture") as! SimpleFixtureTableViewCell
        guard let fixture = simpleFixtures?.fixtures[indexPath.row] else { return SimpleFixtureTableViewCell() }
        if let homeLogoURL = URL(string: fixture.team?.home.logo ?? ""){
            if let homeLogoImageData = try? Data(contentsOf: homeLogoURL){
                cell.homeLogo.image = UIImage(data: homeLogoImageData)
            }
        }
        if let awayLogoURL = URL(string: fixture.team?.away.logo ?? ""){
            if let awayLogoImageData = try? Data(contentsOf: awayLogoURL){
                cell.awayLogo.image = UIImage(data: awayLogoImageData)
            }
        }
        cell.homeName.text = fixture.team?.home.name
        cell.awayName.text = fixture.team?.away.name
        if fixture.goal?.home == nil {
            cell.homeScore.text = "--"
        } else {
            cell.homeScore.text = String((fixture.goal?.home)!)
        }
        if fixture.goal?.away == nil {
            cell.awayScore.text = "--"
        } else {
            cell.awayScore.text = String((fixture.goal?.away)!)
        }
        cell.timeLabel.text = fixture.date?.split(separator: "T").map { String($0) }.first
        cell.id = fixture.fixtureId ?? 0
        return cell
    }
    
    
}
