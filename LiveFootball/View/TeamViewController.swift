//
//  TeamViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import UIKit
import Charts

class TeamViewController: UIViewController {
    var teamStatistics: TeamStatistic?
    var teamFixtureList: SimpleFixtureModelList?
    var teamDetailViewModel = TeamDetailViewModel()
    // these values are coming from the segue
    var teamId: Int!
    var leagueCode: Int!
    var season: Int!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailViewModel.delegate = self
        teamDetailViewModel.getTotalTeamData(leagueCode: leagueCode, teamCode: teamId, season: season)
        
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

extension TeamViewController: TeamCommunicationProtocol {
    func notifyTeamStatisticDataProvided(_ teamStat: statWithParsedLogoImage) {
        teamStatistics = teamStat.statistics
        DispatchQueue.main.async {
            self.teamLogo.image = UIImage(data: teamStat.logoData)
        }
    }
    
    func notifyNextFixtureDataProvided(_ fixture: SimpleFixtureModelList) {
        teamFixtureList = fixture
    }
}
