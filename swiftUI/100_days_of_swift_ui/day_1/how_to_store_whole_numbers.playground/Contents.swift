import Cocoa

// 整数を保存する方法
// 数字はIntと呼ぶ。integer。格納できる最大値が型に存在するらしい
let score = 10
let highScore = 999999999999999999
// アンダースコアを無視する
let reallyBig = 100_000_000

// 四則演算ができる
let lowerScore = score - 2
let higherScore = score + 2
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

// 整数を何らかの方法で調整し、その結果を元の数値に代入する特別な操作がある
var counter = 10

// counter = counter + 5 と同じ意味
counter += 5 // +=のことを省略形演算子、複合演算子と呼ぶ。*=, -=, /=も使える
print(counter)

// Intにも便利な機能が存在する
// isMultiple(of:)は、ある整数が別の整数の倍数であるかどうかを調べる
let number = 120
print(number.isMultiple(of: 3)) // 120が3の倍数かどうかを判定

// 数字を直接判定することもできる
print(120.isMultiple(of: 3))
