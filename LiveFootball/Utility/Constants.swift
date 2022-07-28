//
//  Constants.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

class Constants {
    static let baseURL = "https://api-football-v1.p.rapidapi.com/v3/"
    
    static let standingEndpoint = "standings"
    static let countryEndpoint = "countries"
    static let leagueEndpoint = "leagues"
    static let teamsEndpoint = "teams"
    static let playersEndpoint = "players"
    static let playerBySquadEndpoint = "players/Squad"
    static let predictionEndpoint = "predictions"
    static let fixtureEndpoint = "fixtures"
    static let lineupEndpoint = "fixtures/lineups"
    static let hthEndpoint = "fixtures/headtohead"
    
    static let paramCountryCode = "code="
    static let paramSeason = "season="
    static let paramLeagueCode = "league="
    static let paramTeamCode = "team="
    static let paramDateFrom = "from="
    static let paramDateTo = "to="
    static let paramFixtureID = "fixture="
    static let paramFixtureID2 = "id="
    static let paramPlayerID = "id="
    static let paramHTH = "h2h="
    static let paramLast = "last="
    
    static let matchesToShow = "5"
    
    static let apiKey = "X-RapidAPI-Key"
    static let key = "726f66a6c7mshc08a20e5b68b867p136a3cjsn787b6c5ccf4b"
}
