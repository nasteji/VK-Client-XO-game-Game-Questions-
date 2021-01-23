import UIKit

//1. Написать функцию, которая определяет, четное число или нет.

func evenNumber(_ number: Int) -> Bool{
    return number % 2 == 0
}

evenNumber(14)
evenNumber(15)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func toNumber(
    _ number: Int,
    _ divider: Int) -> Bool {
    return number % divider == 0
}

toNumber(14, 3)
toNumber(15, 3)

//3. Создать возрастающий массив из 100 чисел.

func array(
    from userFrom: Int,
    to userTo: Int) -> [Int] {
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
