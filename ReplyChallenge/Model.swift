//
//  Model.swift
//  ReplyChallenge
//
//  Created by Julio Brazil Bellucci Lopes on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

let MUTATION_CHANCE = 0.05

public class Replyer {
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

public struct Room {
    var devs: [Dev]
    var managers: [Replyer]
    var floorPlan: Matrix<Seat>
    var score: Int = 0
    
    func updateScore() -> Int {
        let filledGrid = fillGrid(floorPlan, with: devs, and: managers)
        return 0
    }
    
    mutating func mutate() {
        
        for index in 0...devs.count-1 {
            if Double(Float(arc4random()) / Float(UINT32_MAX)) <= MUTATION_CHANCE {
                let temp = self.devs[index]
                let randInt = Int(arc4random_uniform(UInt32(devs.count)))
                self.devs[index] = devs[randInt]
                devs[randInt] = temp
            }
        }
        
        for index in 0...managers.count-1 {
            if Double(Float(arc4random()) / Float(UINT32_MAX)) <= MUTATION_CHANCE {
                let temp = self.managers[index]
                let randInt = Int(arc4random_uniform(UInt32(managers.count)))
                self.managers[index] = managers[randInt]
                managers[randInt] = temp
            }
        }
    }
    
    func cross(_ otherIndividual: Room) -> Room {
        var individual = Room(devs: devs, managers: managers, floorPlan: floorPlan, score: score)
        
        //DIFFERENT METHODS ARE AVAILABLE:
        //single cross, multi cross, uniform cross (we are using single cross)
        var crossIndex = Int(arc4random_uniform(UInt32(devs.count)))
        for i in 0...crossIndex {
            individual.devs[i] = self.devs[i]
        }
        for i in crossIndex...devs.count-1 {
            individual.devs[i] = otherIndividual.devs[i]
        }
        
        crossIndex = Int(arc4random_uniform(UInt32(managers.count)))
        for i in 0...crossIndex {
            individual.managers[i] = self.managers[i]
        }
        for i in crossIndex...managers.count-1 {
            individual.managers[i] = otherIndividual.managers[i]
        }
        
        
        return individual
    }
    
}

public enum Seat: Equatable {
    case unavailable
    case dev(Int)
    case manager(Int)
}
