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
    override func viewDidLoad() {
        super.viewDidLoad()

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
extension LeagueViewController: LeagueCommunicationProtocol {
    func notifyLeagueDataProvided(_ league: LeagueModelList) {
        leagueList = league
    }
    func notifyStandingDataProvided(_ standing: StandingModelList) {
        self.standing = standing
    }
    
    
}
