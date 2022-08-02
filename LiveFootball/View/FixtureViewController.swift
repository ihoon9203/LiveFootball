//
//  FixtureViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import UIKit

class FixtureViewController: UIViewController {
    
    @IBOutlet weak var leagueBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var countriesForDropDown = [UIAction]()
    var leaguesForDropDown = [UIAction]()
    
    @IBOutlet weak var fixtureTable: UITableView!
    var countryList: [Country] = []
    var leagueList: LeagueModelList?
    var simpleFixtures: SimpleFixtureModelList?
    let fixtureViewModel = FixtureViewModel()
    var leagueButtons: [UIButton] = []
    var selectedID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureViewModel.delegate = self
        countryList = CoreDataManager.sharedManager.getAllCountries()
        if countryList.count == 0 {
            fixtureViewModel.getCountryList()
        } else {
            setCountryList(countries: countryList)
        }
        // Do any additional setup after loading the view.
    }
    
    func setCountryList(countries: [Country]) {
        self.countryList = countries.sorted(by: { country1, country2 in
            country1.name! < country2.name!
        })
        self.countryList.map({ country in
            self.countriesForDropDown.append(UIAction(title: country.name ?? "",
                                                      handler: { [weak self]_ in
                self?.countryBtn.setTitle(country.name ?? "GB" , for: .normal)
                self?.leagueBtn.setTitle("League", for: .normal)
                self?.fixtureViewModel.getLeagueList(code: country.code ?? "GB", season: "2021") }
            ))
        })

        countryBtn.menu = UIMenu(title: "Country",
                                  identifier: nil,
                                  options: .displayInline,
                                  children: countriesForDropDown )
    }
    func setLeagueList() {
        self.leaguesForDropDown = []
        guard let leagues = leagueList?.leagues else { return }
        for league in leagues {
            self.leaguesForDropDown.append(UIAction(title: league.name ?? "",
                                            handler: { [weak self] _ in
                self?.leagueBtn.setTitle(league.name ?? "" , for: .normal)
                
                self?.fixtureViewModel.getRangedFixtureData(from: self?.datePicker.date ?? Date(), range: 7, leagueCode: league.id , season: DateParser.getYearFromDate(date: self?.datePicker.date ?? Date()))
            }))
        }
        DispatchQueue.main.async {
            self.leagueBtn.menu = UIMenu(title: "League",
                    identifier: nil,
                    options: .displayInline,
                    children: self.leaguesForDropDown )
        }
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
        setLeagueList()
    }
    
    func notifyCountryDataProvided(_ countries: [Country]) {
        CoreDataManager.sharedManager.enlistCountries(countryList: countries)
        setCountryList(countries: countries)
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
        cell.homeLogo.image = UIImage(data: fixture.homeLogo)
        cell.awayLogo.image = UIImage(data: fixture.awayLogo)
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
