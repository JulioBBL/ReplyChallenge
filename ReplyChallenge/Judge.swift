//
//  Judge.swift
//  ReplyChallenge
//
//  Created by Julio Brazil Bellucci Lopes on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

public class Judge {
    static var INITIAL_POPULATION_AMOUNT = 10
    static var GENERATIONS = 1000
    
    var rooms = [Room]()
    
    init(floorPlan: Matrix<Seat>, devs: [Dev], managers: [Replyer]) {
        generatePopulation(floorPlan: floorPlan, devs: devs, managers: managers)
    }
    
    func evolute() -> Room {
        for _ in 0...Judge.GENERATIONS {
            generation()
        }
        
        return self.rooms.sorted().first!
    }
    
    func generation() {
        self.mutate()
        self.cross()
        self.killPopulation()
    }
    
    func generatePopulation(floorPlan: Matrix<Seat>, devs: [Dev], managers: [Replyer]) {
        let x = [Int](repeating: 0, count: Judge.INITIAL_POPULATION_AMOUNT)
        
        x.forEach { _ in
            self.rooms.append(Room(devs: devs, managers: managers, floorPlan: floorPlan))
        }
    }
    
    func mutate() {
        rooms.forEach({ $0.mutate() })
    }
    
    func cross() {
        var new = self.rooms.map { (roomA) -> Room in
            let roomB = self.rooms[Int.random(in: 0..<self.rooms.count)]
            return roomA.cross(roomB)
        }
        
        self.rooms.append(contentsOf: new)
    }
    
    func killPopulation() {
        self.rooms = self.rooms.sorted().reversed()
        
        self.rooms.enumerated().forEach { (index, room) in
            guard index > Judge.INITIAL_POPULATION_AMOUNT else { return }
            
            let chance = Int.random(in: 1...10)
            
            if chance < 10 {
                room.dieMF()
            }
        }
        
        self.rooms = self.rooms.compactMap { room -> Room? in
            return room.isDead ? nil : room
        }
    }
}
