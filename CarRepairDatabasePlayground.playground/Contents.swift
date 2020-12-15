import Foundation
import RealmSwift

// MARK: - Playground
// define class Person
class Person: Object {
    @objc dynamic var name = ""
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
}

// define class ReapairShop which is link to Person
class ReapairShop: Object {
    @objc dynamic var name = ""
//    When you create a relationship with another Realm object, its property must be of an Optional type
    @objc dynamic var contact: Person?
    
}
// example
let marin = Person("Marin")
let jack = Person("Jack")

let myLittleShop = ReapairShop()
myLittleShop.name = "My Little Auto Shop"
myLittleShop.contact = jack
//myLittleShop.contact = nil

print(myLittleShop.contact?.name ?? "n/a")

// define class Car
class Car: Object {
    @objc dynamic var brand = ""
    @objc dynamic var year = 0
    
    // Object relationships
    @objc dynamic var owner: Person?
    @objc dynamic var shop: ReapairShop?
    
    // To-many relationships (for objects)
    let repairs = List<Repair>()
    let plates = List<String>()
    let checkups = List<Date>()
    let stickers = List<String>()
    
    
    convenience init(brand: String, year: Int) {
        self.init()
        self.brand = brand
        self.year = year
    }
    
    override var description: String {
        return "Car {\(brand), \(year)}"
    }
}

// define class Repair
class Repair: Object {
    @objc dynamic var date = Date()
    @objc dynamic var person: Person?

    convenience init(by person: Person) {
        self.init()
        self.person = person
    }
  
}

let car = Car(brand: "FIAT", year: 1980)

ExamplePrint.of("Object relationships") {
    car.shop = myLittleShop
    car.owner = marin
    
    print(car.shop == myLittleShop)
    print(car.owner!.name)
}

ExamplePrint.of("Adding Object to a different Object's List property") {
    let repairJack = Repair(by: jack)
    car.repairs.append(repairJack)
    car.repairs.append(objectsIn: [repairJack, repairJack, repairJack])

    print("\(car) has \(car.repairs.count)")
//    print(car.repairs)
}

ExamplePrint.of("Adding Primitive types to Realm List(s)") {
    // String
    car.plates.append("WYZ 201 Q")
    car.plates.append("2MNYC0DZ")
    
    print(car.plates)
    print("Current registration: \(car.plates.last!)")
    
    // Date
    car.checkups.append(Date(timeIntervalSinceNow: -31789867))
    car.checkups.append(Date())
    
    print(car.checkups)
    print("First element \(car.checkups.first!)")
    print("Max element \(car.checkups.max()!)")
    
}

// define class Sticker
// At some point, you might need objects in one file to point to a single object or a list of objects in another file. You’ll examine this scenario shortly
class Sticker: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var text = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ text: String) {
        self.init()
        self.text = text
    }
}

ExamplePrint.of("Referencing objects from a different Realm file") {
   // Let's say we're storing those in "stickers.realm"
    let sticker = Sticker("Swift is my life")
    
    car.stickers.append(sticker.id)
    print(car.stickers)
    do{
        let realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TemporaryRealm"))
        
        try! realm.write{
            realm.add(car)
            realm.add(sticker)
        }
        
        print("Linked stickers:")
        print(realm.objects(Sticker.self).filter("id IN %@", car.stickers))
    }catch(let error){
        print(error.localizedDescription)
    }
    
}

