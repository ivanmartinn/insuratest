//
//  UserData.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class UserData {
    static let shared = UserData()
    private init() {}
}

//kAuthenticationToken
extension UserData {
    var token: String? {
        guard let value = Preference.getString(forKey: .kAuthenticationToken) else { return nil }
        return value
    }
    
    func saveToken(_ value: String){
        Preference.set(value: value, forKey: .kAuthenticationToken)
    }
    
    func removeToken(){
        Preference.set(value: nil, forKey: .kAuthenticationToken)
    }
}

protocol StaticPreference {
    associatedtype output: Codable
    var key: PreferenceKey! { get set }
}

extension StaticPreference {
    func read() -> output? {
        return Preference.structData(output.self, forKey: key)
    }
    
    func save(model: output) {
        Preference.setStruct(model.self, forKey: key)
    }
    
    func clear() {
        Preference.clear(forKey: key)
    }
}

class UserDataPreference: StaticPreference {
    typealias output = User
    var key: PreferenceKey! = .kUserData
}
