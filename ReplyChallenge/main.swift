//
//  main.swift
//  ReplyChallenge
//
//  Created by Pedro Cacique on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

let d1 = Dev(id: 0, company: "mack", bonus: 7, skills: [
    "Java",
    "Python",
    "C"
])

let d2 = Dev(id: 1, company: "mack", bonus: 4, skills: [
    "C",
    "Java",
    "C++"
])

let d3 = Dev(id: 1, company: "mack", bonus: 8, skills: [
    "AWS",
    "C#",
    "Brainfuck"
])

let m1 = Replyer(id: 2, company: "mack", bonus: 10)

print("WP: \(d1.workPotential(for: d2))")
print("B : \(d1.bonus(for: d2))")
print("TP: \(d1.totalScore(for: d2))")

//MARK: READ FILE
let pathURL = URL(fileURLWithPath: (NSString(string:"~/Desktop/_.txt").expandingTildeInPath ))
let s = StreamReader(url: pathURL)
while let line = s?.nextLine() {
    print(line)
}

//MARK: MAIN CODE


//MARK: WRITE ANSWER
let sw = StreamWriter(path: (NSString(string:"~/Desktop/_output.txt").expandingTildeInPath ))
sw?.write(data: "Hello, World!")

