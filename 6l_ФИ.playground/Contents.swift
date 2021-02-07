import UIKit
import Foundation
//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
class CakeParent {
    
}
protocol Cake {
    var name: String { get }
    var weight: Double { get }
    var kkal: Double { get }
    
    func changeTheComposition(_ value: Int)
}
class Biscuit: CakeParent, Cake {
    
    var name: String
    var weight: Double
    var kkal: Double
    var totalLayers: Int
    
    init(weight: Double, kkal: Double, totalLayers: Int) {
        self.name = "Biscuit"
        self.weight = weight
        self.kkal = kkal
        self.totalLayers = totalLayers
    }
    func changeTheComposition(_ value: Int) {
        if (totalLayers + value) > 0 {
            self.totalLayers = totalLayers + value
            print("layers is now \(totalLayers)")
        } else {
            print("changeLayersTo max \(totalLayers)")
        }
    }
}
class BrewingCake: CakeParent, Cake {
    
    var name: String
    var weight: Double
    var kkal: Double
    var creamColor: Int
    
    init(weight: Double, kkal: Double, creamColor: Int) {
        self.name = "BrewingCake"
        self.weight = weight
        self.kkal = kkal
        self.creamColor = creamColor
    }
    func changeTheComposition(_ value: Int) {
        switch value {
        case 1:
            self.creamColor = 1
        case 2:
            self.creamColor = 2
        case 3:
            self.creamColor = 3
        case 4:
            self.creamColor = 4
        case 5:
            self.creamColor = 5
        default:
            print("choose one of 5 colors")
            return self.creamColor = 0
        }
        print("the color is now \(creamColor)")
    }
}
struct Queue<T: Cake> {
    
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        guard elements.count > 0 else {return nil}
        return elements.removeFirst()
    }
    mutating func filterBy(_ predicate: (T) -> Bool) -> [T] {
        var tmp: [T] = []
        for element in elements {
            if predicate(element) {
                tmp.append(element)
            }
        }
        return tmp
    }
    mutating func sortBy(_ predicate: (T, T) -> Bool) -> [T] {
        for i in 0..<elements.count {
            for k in 0..<(elements.count - 1) {
                if !predicate(elements[k], elements[i]) {
                    let tmp: T = elements[i]
                    elements[i] = elements[k]
                    elements[k] = tmp
                }
            }
        }
        return elements
    }
}
enum SomeCake: Cake {
    
    case biscuit(Biscuit)
    case brewingCake(BrewingCake)
    
    var name: String {
        get {
            switch self {
            case .biscuit(let biscuit):
                return biscuit.name
            case .brewingCake(let brewingCake):
                return brewingCake.name
            }
        }
    }
    var weight: Double {
        get {
            switch self {
            case .biscuit(let biscuit):
                return biscuit.weight
            case .brewingCake(let brewingCake):
                return brewingCake.weight
            }
        }
    }
    var kkal: Double {
        get {
            switch self {
            case .biscuit(let biscuit):
                return biscuit.kkal
            case .brewingCake(let brewingCake):
                return brewingCake.kkal
            }
        }
    }
    func changeTheComposition(_ value: Int) {
        switch self {
            case .biscuit(let biscuit):
                return biscuit.changeTheComposition(value)
            case .brewingCake(let brewingCake):
                return brewingCake.changeTheComposition(value)
        }
    }
}

extension Queue {
    subscript(indexes: Int...) -> [T] {
        var result: [T] = []
        for index in indexes where index >= 0 && index < self.elements.count {
            result.append(self.elements[index])
        }
        return result
    }
}
extension CakeParent: CustomStringConvertible {
    var description: String {
        var description = "\n-------\(type(of: self))-------\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        description += "---------------------\n"
        return description
    }
}

var cake = Queue<SomeCake>()
cake.push(.biscuit(.init(weight: 100, kkal: 180, totalLayers: 8)))
cake.push(.biscuit(.init(weight: 110, kkal: 190, totalLayers: 9)))
cake.push(.brewingCake(.init(weight: 150, kkal: 100, creamColor: 1)))
cake.push(.brewingCake(.init(weight: 200, kkal: 215, creamColor: 6)))
print(cake)
print(cake[0])
print(cake[5])

let resFilterByKkal = cake.filterBy({ $0.kkal > 200 })
print("Calorie filter >200 =", resFilterByKkal.map({"\($0.name) \($0.kkal)" }))

let resSortByWeight = cake.sortBy({ $0.weight < $1.weight })
print("Sorted by weight =", resSortByWeight.map({"\($0.name) \($0.weight)" }))

var cake1 = cake.pop()
var cake2 = cake.pop()
var cake3 = cake.pop()

cake1?.changeTheComposition(3)
cake3?.changeTheComposition(6)
cake3?.changeTheComposition(2)
cake2?.name
cake1?.kkal
cake3?.weight
cake.pop()
cake.pop()
