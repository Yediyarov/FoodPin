//
//  Restaurant.swift
//  FoodPin
//
//  Created by Khayal Yediyarov on 03.09.22.
//

import Foundation


struct Restaurant: Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}
