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
//        self.rooms = rooms.map { $0.mutate() }
    }
    
    func cross() {
        
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