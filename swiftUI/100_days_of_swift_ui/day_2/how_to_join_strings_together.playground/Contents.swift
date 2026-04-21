import Cocoa

// 文字列を結合する方法

// ＋を使用して結合
let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart

let people = "Haters"
let action = "hate"
let lyric = people + " gonna " + action
print(lyric)

// operator overloading - 演算子オーバーローディング
// IntとDoubleを使用すると数値を合算し、String同士の時は文字列が結合する
// +のような演算子が使用方法に応じて異なる意味を持つ
// これは複合代入演算子にも適用される
// あまり使いすぎたく無い技術。小さいものには有効。以下のコードは順番に結合していくため、不要なタイミングの数値も計算することになるそう(結果の"123"が欲しいのに、中間生成物として"12"が生まれ、不要な計算をさせていて無駄)
let letluggageCode = "1" + "2" + "3"

// string interpolation - 文字列補完
// IntやDoubleから文字列を作成できたり、文字列の中に二重引用符を記載する際に使ったバックスラッシュの記法でSwiftに命令する技術のこと
// 文字列補完は、＋を使用して文字列を一つずつ結合するよりもはるかに効率的
// 文字列の中に \(name) の様に変数・定数名を記述すると、文字列の中で変数に含む文字列を呼び出すことが可能
let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)

// Int, Doubleも文字列補間を使うと簡単に文字列に変換してテキストにすることが可能

// ＋を使用する際は、String同士、Int同士、Double同士なら結合および加算できるが、たとえば、以下はエラーになる
let number = 11
//let missionMessage = "Appolo " + number + " landed on the moon."

// これは、以下の書き方ならエラーなく結合可能
//let missionMessage = "Appolo " + String(number) + " landed on the moon."
let missionMessage = "Appolo \(number) landed on the moon." // 何も考えずに表現できる。文字列補間すごい

// 計算して文字列に含めることもできる
print("5 * 5 is \(5 * 5)")
