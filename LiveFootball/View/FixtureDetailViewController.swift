//
//  FixtureDetailViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class FixtureDetailViewController: UIViewController {
    
    var fixtureCode: Int?
    var lineupList: LineupModelList?
    var matchModel: MatchModel?
    var predictionModel: PredictionModel?
    var headtoheadModelList: HeadToHeadModelList?
    let fixtureDetailVM = FixtureDetailViewModel()
    
    @IBOutlet weak var awaySquadTable: UITableView!
    @IBOutlet weak var homeSquadTable: UITableView!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureDetailVM.delegate = self
        if let fixtureCode = fixtureCode {
            fixtureDetailVM.getMatchData(fixtureCode)
            fixtureDetailVM.getPredictionData(fixtureCode)
            fixtureDetailVM.getLineupList(fixtureCode)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedHomeRow = self.homeSquadTable.indexPathForSelectedRow {
            let player = self.homeSquadTable.cellForRow(at: selectedHomeRow) as! SquadTableViewCell
            let playerId = player.playerID
            let destinationVC = segue.destination as! PlayerViewController
            destinationVC.playerId = playerId
            guard let thisDate = matchModel?.date else { return }
            destinationVC.season = DateParser.getYearFromString(date: thisDate)
        }
        if let selectedAwayRow = self.awaySquadTable.indexPathForSelectedRow {
            let player = self.awaySquadTable.cellForRow(at: selectedAwayRow) as! SquadTableViewCell
            let playerId = player.playerID
            let destinationVC = segue.destination as! PlayerViewController
            destinationVC.playerId = playerId
            guard let thisDate = matchModel?.date else { return }
            destinationVC.season = DateParser.getYearFromString(date: thisDate)
        }
    }
}
extension FixtureDetailViewController: FixtureDetailCommunicationProtocol, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SquadTableViewCell
        performSegue(withIdentifier: "viewPlayerData", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == homeSquadTable {
            return (lineupList?.home?.startXI.count ?? 0) + (lineupList?.home?.substitutes.count ?? 0)
        } else {
            return (lineupList?.away?.startXI.count ?? 0) + (lineupList?.away?.substitutes.count ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadCell") as! SquadTableViewCell
        if tableView == homeSquadTable {
            if indexPath.row < 11 {
                cell.name.text = lineupList?.home?.startXI[indexPath.row].player.name
                cell.number.text = String((lineupList?.home?.startXI[indexPath.row].player.number) ?? 0)
                cell.playerID = lineupList?.home?.startXI[indexPath.row].player.id
                cell.pos.text = lineupList?.home?.startXI[indexPath.row].player.pos
            } else {
                cell.name.text = lineupList?.home?.substitutes[indexPath.row - 11].player.name
                cell.number.text = String((lineupList?.home?.substitutes[indexPath.row - 11].player.number) ?? 0)
                cell.playerID = lineupList?.home?.substitutes[indexPath.row - 11].player.id
                cell.pos.text = lineupList?.home?.substitutes[indexPath.row - 11].player.pos
            }
            return cell
        } else {
            if indexPath.row < 11 {
                cell.name.text = lineupList?.away?.startXI[indexPath.row].player.name
                cell.number.text = String((lineupList?.away?.startXI[indexPath.row].player.number) ?? 0)
                cell.playerID = lineupList?.away?.startXI[indexPath.row].player.id
                cell.pos.text = lineupList?.away?.startXI[indexPath.row].player.pos
            } else {
                cell.name.text = lineupList?.away?.substitutes[indexPath.row - 11].player.name
                cell.number.text = String((lineupList?.away?.substitutes[indexPath.row - 11].player.number) ?? 0)
                cell.playerID = lineupList?.away?.substitutes[indexPath.row - 11].player.id
                cell.pos.text = lineupList?.away?.substitutes[indexPath.row - 11].player.pos
            }
            
            return cell
        }
    }
    
    func notifyHTHDataProvided(_ records: HeadToHeadModelList) {
        headtoheadModelList = records
    }
    
    func notifyPredicitonDataProvided(_ prediction: PredictionModel) {
        predictionModel = prediction
        fixtureDetailVM.getHeadToHeadData(homeCode:
                                            predictionModel?.teams?.home.id ?? 0, awayCode:
                                            predictionModel?.teams?.away.id ?? 0)
    }
    
    func notifyFixtureDataProvided(_ fixture: MatchModel) {
        matchModel = fixture
    }
    
    func notifyLineupDataProvided(_ lineup: LineupModelList) { // optional (not for future fixture)
        lineupList = lineup
        DispatchQueue.main.async {
            self.homeSquadTable.reloadData()
            self.awaySquadTable.reloadData()
        }
    }
    
}
