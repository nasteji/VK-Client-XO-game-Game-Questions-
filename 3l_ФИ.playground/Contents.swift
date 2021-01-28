import UIKit

//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.
enum EngineState {
    case action
    case noAction
}
enum Windows {
    case openWindows
    case closeWindows
}
struct Car {
    let model: String
    let year: UInt
    var engineState: EngineState
    var windows: Windows
    var trunkVolume: Double

    var old: UInt {
    get {
        return 2021 - year
    }
    }
    var trunkIsOccupied: Double {
        didSet {
            let changeTrunkIsOccupied = trunkIsOccupied - oldValue
            print("change trunkIsOccupied at \(model) is \(changeTrunkIsOccupied), trunkIsOccupied = \(trunkIsOccupied)")
        }
    }
    func printCar() {
        print("---------------")
        print("model = \(model)")
        print("year = \(year)")
        print("old = \(old)")
        print("engineState = \(engineState)")
        print("windows = \(windows)")
        print("trunkVolume = \(trunkVolume)")
        print("trunkIsOccupied = \(trunkIsOccupied)")
    }
    mutating func changeTrunkIsOccupied(_ value: Double) {
        if (value + trunkIsOccupied) < trunkVolume {
            self.trunkIsOccupied = trunkIsOccupied + value
        } else {
            self.trunkIsOccupied = trunkIsOccupied
            print("not enough storage")
        }
    }
    mutating func changeEngineState(_ value: EngineState) {
        self.engineState = value
        print("change engineState at \(model) is \(engineState)")
    }
    mutating func changeWindows(_ value: Windows) {
        self.windows = value
        print("change windows at \(model) is \(windows)")
    }
}
var sportCar = Car(model: "ferrari", year: 2006, engineState: .noAction, windows: .openWindows, trunkVolume: 5, trunkIsOccupied: 0)
var trunkCar = Car(model: "mann", year: 2012, engineState: .action, windows: .closeWindows, trunkVolume: 300, trunkIsOccupied: 50)

sportCar.old
trunkCar.old
sportCar.windows

sportCar.changeEngineState(.action)
sportCar.changeWindows(.closeWindows)

trunkCar.trunkIsOccupied
trunkCar.changeTrunkIsOccupied(40)
trunkCar.trunkIsOccupied
trunkCar.changeTrunkIsOccupied(-80.5)
trunkCar.trunkIsOccupied
trunkCar.changeTrunkIsOccupied(500)
trunkCar.trunkIsOccupied

sportCar.printCar()
trunkCar.printCar()
