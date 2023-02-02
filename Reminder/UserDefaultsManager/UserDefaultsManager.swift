//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 2/2/23.
//

import Foundation

class UserDefaultsManager {
    // Singleton
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    var counter: Int = 0
    
    func setValue(_ value: Any?, forKey key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    func getValue(forKey key: String) -> Any {
        return UserDefaults.value(forKey: key)!
    }
    func updateValue(_ value: Any?, forKey key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
       }
    func checkValueForKey(key: String) -> Int {
    if let value = userDefaults.value(forKey: key) as? Int {
    return value
    } else {
    userDefaults.set(1, forKey: key)
    return 1
    }
    }

    func valueForKey(key: String) -> Int {
    return userDefaults.integer(forKey: key)
    }
    }
}
