//
//  main.swift
//  ReplyChallenge
//
//  Created by Pedro Cacique on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

extension String {
    func split() -> [String] {
        return self.components(separatedBy: " ")
    }
}

var fileName = "a_solar"
var devs = [Dev]()
var managers = [Replyer]()
var floorPlan = Matrix(rows: 0, columns: 0, values: [Seat]())

//MARK: READ FILE
func readFile() {
    let pathURL = URL(fileURLWithPath: (NSString(string:"~/Desktop/\(fileName).txt").expandingTildeInPath ))
    guard let s = StreamReader(url: pathURL) else { fatalError() }

    //get grid size
    guard let gridSize = s.nextLine()?.split() else { fatalError() }
    guard let gridWidth = Int(gridSize[0]), let gridHeight = Int(gridSize[1]) else { fatalError() }

    var gridValues = [String]()

    //MARK: GET GRID
    for _ in 1...gridHeight {
        guard let valueText = s.nextLine() else { fatalError() }
        gridValues.append(contentsOf: valueText.map(String.init))
    }
    
    var newValues = [Seat]()
    var amountOfDevs = 0
    var amountOfMans = 0
    for value in gridValues {
        switch value {
        case "#":
            newValues.append(.unavailable)
            
        case "_":
            newValues.append(.dev(amountOfDevs))
            amountOfDevs += 1
            
        case "M":
            newValues.append(.manager(amountOfDevs))
            amountOfMans += 1
            
        default:
            fatalError("não era pra ter um \(value) aqui")
        }
    }

    floorPlan = Matrix(rows: gridWidth, columns: gridHeight, values: newValues)

    guard let devAmountText = s.nextLine(), let devAmount = Int(devAmountText) else { fatalError() }

    //MARK: GET DEVS
    for i in 1...devAmount {
        guard var devValues = s.nextLine()?.split() else { fatalError() }
        
        let company = devValues.remove(at: 0)
        guard let bonus = Int(devValues.remove(at: 0)) else { fatalError() }
        devValues.remove(at: 0)
        
        devs.append(Dev(id: i, company: company, bonus: bonus, skills: devValues))
    }

    guard let managerAmountText = s.nextLine(), let managerAmount = Int(managerAmountText) else { fatalError() }

    //MARK: GET MANAGERS
    for i in 1...managerAmount {
        guard let valuetext = s.nextLine() else { fatalError() }
        
        var values = valuetext.split()
        let company = values.remove(at: 0)
        guard let bonus = Int(values.remove(at: 0)) else { fatalError() }
        
        managers.append(Replyer(id: i + devAmount, company: company, bonus: bonus))
    }
}

//MARK: MAIN CODE
func doStuff() {
    readFile()
    
    let champion = Judge(floorPlan: floorPlan, devs: devs, managers: managers).evolute()
    
    writeAnswer(champion)
}

//MARK: WRITE ANSWER
func writeAnswer(_ room: Room) {
    struct Answer {
        let id: Int
        let x: Int
        let y: Int
    }
    
    let sw = StreamWriter(path: (NSString(string:"~/Desktop/\(fileName)_output.txt").expandingTildeInPath ))
    
    var answerGrid = fillGrid(floorPlan, with: room.devs, and: room.managers)
    var answers = [Answer]()
    
    for i in 0..<answerGrid.rows {
        for j in 0..<answerGrid.columns {
            guard answerGrid.indexIsValid(row: i, column: j) else { fatalError() }
            guard let x = answerGrid[i, j] else { fatalError() }
            
            answers.append(Answer(id: x.id, x: i, y: j))
        }
    }
    
    answers.sort { (a, b) -> Bool in
        return a.id < b.id
    }
    
    for a in answers {
        sw?.writeLine(data: "\(a.x) \(a.y)")
    }
}

doStuff()



