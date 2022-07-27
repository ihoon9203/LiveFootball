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
    let fixtureDetailVM = FixtureDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureDetailVM.delegate = self
        if let fixtureCode = fixtureCode {
            fixtureDetailVM.getLineupList(fixtureCode)
        }
        
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
extension FixtureDetailViewController: FixtureDetailCommunicationProtocol {
    func notifyLineupDataProvided(_ lineup: LineupModelList) {
        lineupList = lineup
    }
}
