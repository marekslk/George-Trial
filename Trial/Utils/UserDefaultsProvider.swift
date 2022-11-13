//
//  UserDefaultsProvider.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

enum UserDefaultsProvider {
    enum Key: String {
        case userWasOnboarded
    }

    @UserDefaultWrapper(.userWasOnboarded, defaultValue: false)
    static var userWasOnboarded: Bool
}
