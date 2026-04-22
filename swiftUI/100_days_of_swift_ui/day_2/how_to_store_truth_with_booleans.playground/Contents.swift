import Cocoa

// ブール値を使って真実を保存する方法（？）

// これまで見てきた、hasSuffix()、isMultiple(of:)にはブール演算子が紛れ込んでいた
let fileName = "README.md"
print(fileName.hasSuffix(".md")) // Bool値を出力している

// 初期値にtrue, falseを代入するとブール値を作成できる
let goodDogs = true

// ブール値には論理積や論理和のような算術演算子は無い
// ブール値には、否定を意味する特別な演算子"!"が存在する。真から偽、偽から真へ反転する
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated) // true
isAuthenticated = !isAuthenticated
print(isAuthenticated) // false

// ブール値に対してtoggle()を呼び出すことで値を反転する方法もある
// !を使うよりもコード量が少し少なくなる、かも
var gameOver = false
print(gameOver) // false
gameOver.toggle()
print(gameOver) // true
// print(gameOver.toggle()) ではだめだった
