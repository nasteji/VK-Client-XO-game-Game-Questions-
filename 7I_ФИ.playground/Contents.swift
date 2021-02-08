import UIKit
import Foundation

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

enum TrunkIsOccupiedError: Error {
    case tooMuch(max: Double)
    case tooFew(min: Double)

    var localizedDescription: String {
        switch self {
        case .tooFew(min: let min):
            return "only \(min) can be unloaded"
        case .tooMuch(max: let max):
            return "not enough storage, maximum can be loaded = \(max)"
        }
    }
}
class TrunkCar {
    var model: String
    var year: UInt
    var trunkVolume: Double
    var trunkIsOccupied: Double
    
    init(model: String, year: UInt, trunkVolume: Double) {
        self.model = model
        self.year = year
        self.trunkVolume = trunkVolume
        self.trunkIsOccupied = 0.0
    }
    func changeTrunkIsOccupied(_ value: Double) -> ( trunkIsOccupied: Double?, error: TrunkIsOccupiedError?) {
        guard (value + trunkIsOccupied) >= 0 else {
            return (trunkIsOccupied: nil, error: .tooFew(min: trunkIsOccupied))
        }
        guard (value + trunkIsOccupied) <= trunkVolume else {
            return (trunkIsOccupied: nil, error: .tooMuch(max: trunkVolume - trunkIsOccupied))
        }
        self.trunkIsOccupied += value
        return (trunkIsOccupied: trunkIsOccupied, error: nil)
    }
}

var trunkCar1 = TrunkCar(model: "mann", year: 2020, trunkVolume: 300)
let change11 = trunkCar1.changeTrunkIsOccupied(50)
let change12 = trunkCar1.changeTrunkIsOccupied(1000)
let change13 = trunkCar1.changeTrunkIsOccupied(-200)
let change14 = trunkCar1.changeTrunkIsOccupied(-50)

var allChanges = [ change11, change12, change13, change14 ]

for change in allChanges {
    if change.trunkIsOccupied != nil {
        print("Success: trunkIsOccupied = \(change.trunkIsOccupied!)")
    } else if let error = change.error {
        print("Error: ", error.localizedDescription.description)
    }
}

extension TrunkCar {
    
    func occupiedWithTry(_ value: Double) throws -> Double {
         guard (value + trunkIsOccupied) >= 0 else {
             throw TrunkIsOccupiedError.tooFew(min: trunkIsOccupied)
         }
         guard (value + trunkIsOccupied) <= trunkVolume else {
            throw TrunkIsOccupiedError.tooMuch(max: trunkVolume - trunkIsOccupied)
         }
         self.trunkIsOccupied += value
         return trunkIsOccupied
     }
}

var trunkCar2 = TrunkCar(model: "mersedes", year: 2012, trunkVolume: 560)

do {
    _ = try trunkCar2.occupiedWithTry(100)
    _ = try trunkCar2.occupiedWithTry(-300)
    _ = try trunkCar2.occupiedWithTry(300)
} catch let error as TrunkIsOccupiedError {
    print("Error: ", error.localizedDescription)
} catch {
    print("Error unknown")
}

let change24 = try trunkCar2.occupiedWithTry(1000)
let change25 = try? trunkCar2.occupiedWithTry(1000)
