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
var floorPlan = Matrix(rows: 0, columns: 0, values: [String]())

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

    floorPlan = Matrix(rows: gridWidth, columns: gridHeight, values: gridValues)

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
        
        managers.append(Replyer(id: i, company: company, bonus: bonus))
    }
}

//MARK: MAIN CODE
func doStuff() {
    readFile()
    writeAnswer()
}

//MARK: WRITE ANSWER
func writeAnswer() {
    let sw = StreamWriter(path: (NSString(string:"~/Desktop/\(fileName)_output.txt").expandingTildeInPath ))
    sw?.write(data: "Hello, World!")
}

doStuff()

print("grid:\n", floorPlan, "\n")
print("devs:\n", devs, "\n")
print("managers:\n", managers, "\n")

let room = Room(devs: devs, managers: managers, floorPlan: floorPlan)
