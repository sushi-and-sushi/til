import Cocoa

// 小数値を保存する方法

// 浮動小数点数は扱いづらい
let number = 0.1 + 0.2
print(number) // 0.30000000000000004

// 浮動小数点数はDoubleと見なす
// 倍精度浮動小数点数
// Swiftでは、少数と整数は異なるデータ型として扱う。両者を混在させることはできない（明示的に指定すれば可能）

let a = 1
let b = 2.0

// 以下はエラーが起きる
// let c = a + b

// 混在させる場合は以下の様にすれば可能
//let c = a + Int(b)
//let c = Double(a) + b

// 型推論
// Swiftでは代入した数値に基づいてDoubleを作成するかIntを作成するか決定する
let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

// 型安全性
// 保持するデータ型を一度決定したら、常に同じデータ型を保持しなければならない
var name = "Nicolas Cage"
name = "John Travolta"
//name = 47 // nameは文字列を格納する様に指示しているので、整数を入れようとするとエラーが起きる

// 複合代入演算子を利用できる
// 十進整数値？、十進小数値？同士を計算することができる
var rating = 5.0
rating *= 2

// 古いAPIはCGFloatで小数値を格納する
// CGFloatが期待されるすべての場所でDoubleを使用することが可能
