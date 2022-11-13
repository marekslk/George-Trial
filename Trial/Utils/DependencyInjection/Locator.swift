//
//  Locator.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public enum LocatingMode {
    case newInstance
    case sharedInstance
}

public enum Locator {
    private static var factories: [ObjectIdentifier: () -> Any] = [:]
    private static var sharedInstances: [ObjectIdentifier: Any] = [:]

    public static func register<T>(_ type: T.Type = T.self, _ factory: @escaping () -> T) {
        let key = ObjectIdentifier(type)
        factories[key] = factory
    }

    public static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        register(type, factory)
    }

    public static func register<T>(_ factory: @autoclosure @escaping () -> T) {
        register(T.self, factory)
    }

    public static func locate<T>(_ type: T.Type, mode: LocatingMode = .sharedInstance) -> T {
        let key = ObjectIdentifier(type)

        switch mode {
        case .newInstance:
            return self.factories[key]!() as! T
        case .sharedInstance:
            guard let sharedInstance = self.sharedInstances[key] as? T else {
                let instance = self.factories[key]!() as! T
                self.sharedInstances[key] = instance
                return instance
            }

            return sharedInstance
        }
    }
}

@propertyWrapper
public class Locatable<Dependency> {
    private let dependencyType: LocatingMode
    public init(_ dependencyType: LocatingMode) {
        self.dependencyType = dependencyType
    }

    public convenience init() {
        self.init(.sharedInstance)
    }

    private var dependency: Dependency?
    public var wrappedValue: Dependency {
        return Locator.locate(Dependency.self, mode: dependencyType)
    }
}
