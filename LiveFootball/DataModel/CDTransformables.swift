//
//  CDTransformables.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 8/1/22.
//

import Foundation

public class CDTeamData: NSObject {
    let basicTeamData: Team
    let standingTeamData: TeamWithStandingModel
    init(team: Team, standing: TeamWithStandingModel) {
        basicTeamData = team
        standingTeamData = standing
    }
}

public class CDPlayerData: NSObject {
    let playerData: PlayerInfo
    init (info: PlayerInfo) {
        playerData = info
    }
}
