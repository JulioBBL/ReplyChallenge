//
//  Genetica.swift
//  ReplyChallenge
//
//  Created by Felipe Petersen on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

let TOURNAMENT_SIZE = 10

class Genetica {
    
    func tournament(rooms: [Room]) -> Room? {
        var tempRooms = [Room]()
        
        for _ in 0...TOURNAMENT_SIZE {
            tempRooms.append(rooms[Int(arc4random_uniform(UInt32(rooms.count)))])
        }
        if let max = tempRooms.max(by: { (r1, r2) -> Bool in
            r1.score > r2.score
        }) {
            return max
        }
        return nil
    }

    
}
