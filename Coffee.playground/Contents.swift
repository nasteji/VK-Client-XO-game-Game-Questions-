import UIKit

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int = 100
    
}

protocol CoffeeDecorator: Coffee {
    var coffee: Coffee { get }
    init(coffee: Coffee)
}

class Milk: CoffeeDecorator {
    var coffee: Coffee
    
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    var cost: Int {
        return coffee.cost + 30
    }
}

class Whip: CoffeeDecorator {
    var coffee: Coffee
    
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    var cost: Int {
        return coffee.cost + 50
    }
}

class Sugar: CoffeeDecorator {
    var coffee: Coffee
    
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    var cost: Int {
        return coffee.cost + 5
    }
}

let coffee = SimpleCoffee()
let coffeeWithWhip = Whip(coffee: coffee)
let coffeeWithWhipAndMilk = Milk(coffee: coffeeWithWhip)
let coffeeWithAllIngredients = Sugar(coffee: coffeeWithWhipAndMilk)
print(coffeeWithAllIngredients.cost)

