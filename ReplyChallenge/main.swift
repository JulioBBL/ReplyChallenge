//
//  main.swift
//  ReplyChallenge
//
//  Created by Pedro Cacique on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation


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

