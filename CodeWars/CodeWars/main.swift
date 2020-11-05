//
//  main.swift
//  CodeWars
//
//  Created by Анас Бен Мустафа on 06.08.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import Foundation

func allNonConsecutive (_ arr: [Int]) -> [(Int, Int)] {
    var NewData = [(Int, Int)]()
    for i in 1..<arr.count {
        if arr[i] != arr[i - 1] + 1 {
            NewData.append((arr[i - 1], arr[i]))
        }
    }
    return NewData
}

print(allNonConsecutive([1,2,3,4,6,7,8,100]))
