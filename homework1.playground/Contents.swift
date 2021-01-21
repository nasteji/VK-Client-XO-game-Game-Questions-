import UIKit

// 1. Решить квадратное уравнение
let a: Double = 1
let b: Double = 2.5
let c: Double = -10
var x1: Double
var x2: Double

var d = Double(b * b - 4 * a * c)

if d > 0 {
    let ds = Double(sqrt(d))
    x1 = (-b + ds) / (2 * a)
    x2 = (-b - ds) / (2 * a)
    print("Корни уравнения: ", Int(x1),"и", Int(x2), "\n")
    
    }else if d == 0 {
        let ds = Double(sqrt(d))
        x1 = (-b + ds) / (2 * a)
        print("Корень уравнения: ", Int(x1), "\n")
        
        }else {
        print("Корней нет!", "\n")
        }

// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let k1: Double = 6.7
let k2: Double = 9

var s = Double(k1 * k2 / 2)
print("Площадь треугольника равна:", String(format: "%.2f", arguments: [s]), "квадратных единиц.\n")

var g = Double(sqrt(k1 * k1 + k2 * k2))
print("Гипотенуза треугольника равна:", String(format: "%.2f", arguments: [g]), "единиц.\n")

var p = Double(k1 + k2 + g)
print("Периметр треугольника равен:", String(format: "%.2f", arguments: [p]), "единиц.\n")

// 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
var sum: Double = 10000
var rate: Double = 15
var year = 5

rate = rate / 100

for years in 1...year{
    sum += sum * rate
    print("В \(years) год сумма вклада составит \(String(format: "%.2f", arguments: [sum])) денежных знаков.\n")
}
