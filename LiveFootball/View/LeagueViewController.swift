//
//  LeagueViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class LeagueViewController: UIViewController {

    let leaueViewModel = LeagueViewModel()
    var leagueList: LeagueModelList?
    var standing: StandingModelList?
    var team: TeamInfo?
    
    
    @IBOutlet weak var league1: UIButton!
    @IBOutlet weak var league2: UIButton!
    @IBOutlet weak var league3: UIButton!
    @IBOutlet weak var league4: UIButton!
    
    @IBOutlet weak var searchLeagues: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var countryCodeEditor: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func league1selected(_ sender: Any) {
    }
    @IBAction func league2selected(_ sender: Any) {
    }
    @IBAction func league3selected(_ sender: Any) {
    }
    @IBAction func league4selected(_ sender: Any) {
    }
    

}
extension LeagueViewController: LeagueCommunicationProtocol {// , UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    func notifySpecificTeamSearched(_ team: TeamInfo) {
        self.team = team
    }
    
    func notifyLeagueDataProvided(_ league: LeagueModelList) {
        leagueList = league
    }
    func notifyStandingDataProvided(_ standing: StandingModelList) {
        self.standing = standing
    }
}
