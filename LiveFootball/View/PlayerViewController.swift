//
//  PlayerViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var att2: UILabel!
    @IBOutlet weak var att1: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    let playerInfoViewModel = PlayerInfoViewModel()
    var playerInfo: PlayerInfo?
    var playerId: Int?
    var season: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let playerId = playerId else {
            return
        }
        guard let season = season else {
            return
        }

        playerInfoViewModel.getPlayerInfoData(playerCode: playerId, seasonCode: season)
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
    func savePlayerToWatchList() {
        guard let playerInfo = playerInfo else { return }
        CoreDataManager.sharedManager.savePlayerToWatchList(info: PlayerCoreDataInfo(info: playerInfo.player))
    }
}
extension PlayerViewController: PlayerCommunicationProtocol {
    func notifyPlayerDataProvided(_ player: PlayerInfo) {
        playerInfo = player
        if let photoURLString = player.player.photo {
            if let photoURL = URL(string: photoURLString) {
                if let photoImageData = try? Data(contentsOf: photoURL){
                    DispatchQueue.main.async {
                        self.photo.image = UIImage(data: photoImageData)
                        self.name.text = player.player.name
                        self.age.text = DateParser.getAgeFromDate(birthdate: player.player.birth?.date ?? "2022-05-10")
                    }
                }
            }
        }
        
    }
    
    
}
