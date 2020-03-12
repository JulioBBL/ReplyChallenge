//
//  Model.swift
//  ReplyChallenge
//
//  Created by Julio Brazil Bellucci Lopes on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

public class Replyer: Equatable {
    public static func == (lhs: Replyer, rhs: Replyer) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var bonus: Int
    var company: String

    init(id: Int, company: String, bonus: Int) {
        self.id = id
        self.company = company
        self.bonus = bonus
    }

    func checkCommon(replyer: Replyer) -> Int {
        return 0
    }

    func checkDiff(replyer: Replyer) -> Int {
        return 0
    }

    func workPotential(for replyer: Replyer) -> Int {
        return 0
    }

    func bonus(for replyer: Replyer) -> Int {
        return company == replyer.company ? bonus * replyer.bonus : 0
    }

    func totalScore(for replyer: Replyer) -> Int {
        return bonus(for: replyer)
    }
}

public class Dev: Replyer {
    var skills: [String]

    init(id: Int, company: String, bonus: Int, skills: [String]) {
        self.skills = skills
        super.init(id: id, company: company, bonus: bonus)
    }

    override func checkCommon(replyer: Replyer) -> Int {
        guard let dev = replyer as? Dev else { return 0 }
        var score = 0
        skills.forEach { (skill) in
            if dev.skills.contains(skill) {
                score += 1
            }
        }
        return score
    }

    override func checkDiff(replyer: Replyer) -> Int {
        guard let dev = replyer as? Dev else { return 0 }
        let common = checkCommon(replyer: dev)
        let all = Set(skills + dev.skills).count
        return all - common
    }

    override func workPotential(for replyer: Replyer) -> Int {
        return checkCommon(replyer: replyer) * checkDiff(replyer: replyer)
    }

    override func totalScore(for replyer: Replyer) -> Int {
        return workPotential(for: replyer) + bonus(for: replyer)
    }
}

public class Room: Comparable {
    var devs: [Dev]
    var managers: [Replyer]
    var floorPlan: Matrix<Seat>
    var score: Int = 0
    var isDead: Bool = false
    
    init(devs: [Dev], managers: [Replyer], floorPlan: Matrix<Seat>) {
        self.devs = devs
        self.managers = managers
        self.floorPlan = floorPlan
    }

    func updateScore() -> Int {
//        let filledGrid = fillGrid(floorPlan, with: devs, and: managers)
        return 0
    }
    
    public static func < (lhs: Room, rhs: Room) -> Bool {
        return lhs.score < rhs.score
    }
    
    public static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.devs == rhs.devs && lhs.managers == rhs.managers
    }
    
    public func dieMF() {
        self.isDead = true
    }
}

public enum Seat: Equatable {
    case unavailable
    case dev(Int)
    case manager(Int)
}
