//
//  Matrix.swift
//  ReplyChallenge
//
//  Created by Julio Brazil Bellucci Lopes on 12/03/20.
//  Copyright © 2020 Pedro Cacique. All rights reserved.
//

import Foundation

public struct Matrix<T>: CustomStringConvertible {
    let rows: Int, columns: Int
    var grid: [T]

    public var description: String {
        var text = ""
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                text += "\(self[i,j]) "
            }
            text += "\n"
        }
        return text
    }

    init(rows: Int, columns: Int, standardValue: T) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: standardValue, count: rows * columns)
    }

    init(rows: Int, columns: Int, values: [T]) {
        guard rows * columns == values.count else { fatalError("rows * column != values.count") }

        self.rows = rows
        self.columns = columns
        self.grid = values
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    func indexIsValid(index: Int) -> Bool {
        return index >= 0 && index < grid.count
    }

    subscript(index: Int) -> T {
        get {
            assert(indexIsValid(index: index), "Index out of range")
            return grid[index]
        }
        set {
            assert(indexIsValid(index: index), "Index out of range")
            grid[index] = newValue
        }
    }

    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

public func fillGrid(_ places: Matrix<Seat>, with devs: [Dev], and mandagers: [Replyer]) -> Matrix<Replyer?> {
    let seats = places.grid
    let enumeratedSeats = seats.enumerated()
    var values = [Replyer?](repeating: nil, count: seats.count)

    enumeratedSeats.forEach { (seatID, value) in
        switch value {
        case .dev(let id):
            values[seatID] = devs[id]

        case .manager(let id):
            values[seatID] = managers[id]

        default:
            break
        }
    }

    return Matrix(rows: places.rows, columns: places.columns, values: values)
}
