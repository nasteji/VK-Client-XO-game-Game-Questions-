import UIKit
import Foundation
//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState {
    case action
    case noAction
}
enum Windows {
    case openWindows
    case closeWindows
}
class Car {
    var model: String
    var year: UInt
    var engineState: EngineState
    var windows: Windows

    var old: UInt {
        get {
            let date = Date()
            let calendar = Calendar.current
            return UInt(calendar.component(.year, from: date)) - year
        }
    }
    static var carCounter: UInt = 0
    
    deinit {
        print("car is deleted")
        Car.carCounter -= 1
    }
    
    init(model: String, year: UInt) {
        self.model = model
        self.year = year
        self.engineState = .noAction
        self.windows = .closeWindows
        Car.carCounter += 1
    }
    func printCar() {
        print("---------------")
        print("model = \(model)")
        print("year = \(year)")
        print("old = \(old)")
        print("engineState = \(engineState)")
        print("windows = \(windows)")
    }
    func changeEngineState(_ value: EngineState) {
        self.engineState = value
        print("change engineState at \(model) is \(engineState)")
    }
    func changeWindows(_ value: Windows) {
        self.windows = value
        print("change windows at \(model) is \(windows)")
    }
}

enum SportBodyType {
    case citySportsCar
    case racingCar
}
class SportCar: Car {
    var sportBodyType: SportBodyType
    var sportsTiresIncluded: Bool
    
    init(model: String, year: UInt, sportsTiresIncluded: Bool, sportBodyType: SportBodyType) {
        self.sportsTiresIncluded = sportsTiresIncluded
        self.sportBodyType = sportBodyType
        
        super.init(model: model, year: year)
    }
    func changeSportsTiresIncluded(_ value: Bool) {
        sportsTiresIncluded = value
        print("sportsTiresIncluded change is \(sportsTiresIncluded)")
    }
    override func printCar() {
        print("---------------")
        print("model = \(model)")
        print("sportBodyType = \(sportBodyType)")
        print("year = \(year)")
        print("old = \(old)")
        print("sportsTiresIncluded = \(sportsTiresIncluded)")
        print("engineState = \(engineState)")
        print("windows = \(windows)")
    }
}

enum Trailer {
    case trailer_Is_Attached
    case trailer_Is_Unpinned
}
enum SleepingPlace {
    case noSleepingPlace
    case oneBerth
    case twoBerth
}
class TrunkCar: Car {
    var trunkVolume: Double
    var sleepingPlace: SleepingPlace
    
    var trailer: Trailer {
        willSet {
            print("be careful the \(newValue)")
        }
    }
    
    var trunkIsOccupied: Double {
        didSet {
            let changeTrunkIsOccupied = trunkIsOccupied - oldValue
            print("change trunkIsOccupied at \(model) is \(changeTrunkIsOccupied), trunkIsOccupied = \(trunkIsOccupied)")
        }
    }
    init(model: String, year: UInt, trailer: Trailer, sleepingPlace: SleepingPlace, trunkVolume: Double) {
        self.trailer = trailer
        self.sleepingPlace = sleepingPlace
        self.trunkVolume = trunkVolume
        self.trunkIsOccupied = 0.0
        
        super.init(model: model, year: year)
    }
    func changeTrunkIsOccupied(_ value: Double) {
        if (value + trunkIsOccupied) < 0 {
            print("only \(trunkIsOccupied) can be unloaded")
        } else if (value + trunkIsOccupied) <= trunkVolume {
           self.trunkIsOccupied = trunkIsOccupied + value
       } else {
           print("not enough storage for \(value), trunkIsOccupied no change = \(trunkIsOccupied)")
       }
   }
    func changeTrailer(_ value: Trailer) {
        trailer = value
        print("change trailer is \(trailer)")
    }
    func changeSleepingPlace(_ value: SleepingPlace) {
        sleepingPlace = value
        print("change sleepingPlace is \(sleepingPlace)")
    }
    override func printCar() {
        print("---------------")
        print("model = \(model)")
        print("year = \(year)")
        print("old = \(old)")
        print("trailer = \(trailer)")
        print("sleepingPlace = \(sleepingPlace)")
        print("trunkVolume = \(trunkVolume)")
        print("trunkIsOccupied = \(trunkIsOccupied)")
        print("engineState = \(engineState)")
        print("windows = \(windows)")
    }
}

Car.carCounter
var car1 = Car(model: "toyota", year: 2020)
car1.old
car1.engineState
car1.windows
car1.printCar()
Car.carCounter

var sportCar1 = SportCar(model: "porche", year: 2017, sportsTiresIncluded: true, sportBodyType: .racingCar)
sportCar1.printCar()
sportCar1.changeWindows(.openWindows)
sportCar1.sportBodyType
sportCar1.changeSportsTiresIncluded(false)
Car.carCounter

var trunkCar1 = TrunkCar(model: "mann", year: 2009, trailer: .trailer_Is_Attached, sleepingPlace: .oneBerth, trunkVolume: 300)
trunkCar1.printCar()
trunkCar1.trunkIsOccupied
trunkCar1.changeTrunkIsOccupied(70)
trunkCar1.changeTrunkIsOccupied(500)
trunkCar1.changeTrunkIsOccupied(-100)
trunkCar1.changeSleepingPlace(.twoBerth)
trunkCar1.changeTrailer(.trailer_Is_Unpinned)
trunkCar1.changeWindows(.openWindows)
Car.carCounter
