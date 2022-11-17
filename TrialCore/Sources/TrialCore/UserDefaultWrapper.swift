//
//  UserDefaultWrapper.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefaultWrapper<T> {
    public let key: String
    public let defaultValue: T
    public let userDefaults: UserDefaults

    public init(_ key: UserDefaultsProvider.Key, defaultValue: T, userDefaults: UserDefaults = UserDefaults.standard) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    public var wrappedValue: T {
        get {
            guard let value = userDefaults.object(forKey: key) else {
                return defaultValue
            }
            return value as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
