import Foundation
import RealmSwift

// MARK: -  Setup
let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TemporaryRealm"))

print("Ready to play!")
