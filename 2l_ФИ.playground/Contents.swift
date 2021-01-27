import UIKit

//1. Написать функцию, которая определяет, четное число или нет.

func evenNumber(_ number: Int) -> Bool{
    return number % 2 == 0
}

evenNumber(14)
evenNumber(15)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func toNumber(_ number: Int, _ divider: Int) -> Bool {
    if divider != 0 {
    return number % divider == 0
    } else{
        return false
    }
}
toNumber(14, 3)
toNumber(15, -3)
toNumber(34, 0)

//3. Создать возрастающий массив из 100 чисел.

func array(from userFrom: Int, to userTo: Int) -> [Int] {
    var arrayNumber: [Int] = []
    for i in stride(from: userFrom, through: userTo, by: 1){
        arrayNumber.append(i)
    }
    return arrayNumber
}

array(from: 1, to: 100)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

var arrayModify = array(from: 1, to: 100)
arrayModify.removeAll(where: { evenNumber($0) || !toNumber($0, 3) })
print(arrayModify)

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

var resFibb: [Decimal] = []

func fibb(array: inout [Decimal], number: UInt) {
    repeat{
        if array.count == 0 {
            array.append(0)
        } else if array.count == 1 {
            array.append(1)
        } else {
            array.append(array[array.count-1] + array[array.count-2])
        }
    } while array.count < number
}
fibb(array: &resFibb, number: 50)
print(resFibb)

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу.

var resPrimeNumber: [UInt] = []

func primeNumber(_ number: UInt) -> Bool {
    if number > 1 {
        for i in 2..<number {
            if number % i == 0 {
                return false //делится на другие числа
            }
        }
        return true //делится только на себя и 1
    }
    return false //0 и 1
}

primeNumber(4)
primeNumber(5)

func arrayPrimeNumber(array: inout [UInt], number: UInt) {
    var checkNumber: UInt = 0
    repeat{
        if primeNumber(checkNumber) {
            array.append(checkNumber)
        }
        checkNumber += 1
    } while array.count < number
}
arrayPrimeNumber(array: &resPrimeNumber, number: 100)
print(resPrimeNumber)
resPrimeNumber.count

