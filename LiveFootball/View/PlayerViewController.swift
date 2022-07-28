//
//  PlayerViewController.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let playerInfoViewModel = PlayerInfoViewModel()
    var playerInfo: PlayerInfo?
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
extension PlayerViewController: PlayerCommunicationProtocol {
    func notifyPlayerDataProvided(_ player: PlayerInfo) {
        playerInfo = player
    }
    
    
}
