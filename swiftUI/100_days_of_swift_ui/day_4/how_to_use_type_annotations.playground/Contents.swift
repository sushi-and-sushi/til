import Cocoa

// 型注釈(type annotations)の使い方

// 値をすぐに代入したくないが、型は決めておきたい。型の選択を上書きしたい。
// そんな時に型注釈が役立つ
// 値をまだ設定しない定数・変数を作成した時に、値を代入するまでの間に、予期しない値が含められない様にする

// 以下の見慣れたコードでは、型推論 type inference を使用している
// let surname = "Lasso"
// var score = 0
// 文字列が代入されているから、surnameは文字列型
// 整数が代入されているから、scoreは整数型

// 型注釈を使うと、どのようなデータ型が必要かを明示的に指定できる
let surname: String = "Lasso"
var score: Int = 0
// 別の型を指定したい時もある、ということ。以下はDoubleの指定がなければ、SwiftはIntとして推測する
// var score: Double = 0

// 適切な型注釈を使用できる様に、それぞれの名前を知っておこう
let playerName: String = "Roy"
var luckyNumber: Int = 13
let pi: Double = 3.141
var isAuthenticated: Bool = true
var albums: [String] = ["Red", "Fearless"] // 配列
var user: [String: String] = ["id": "@twostars"] // 辞書
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Women, Other"]) // セット

// 空の配列を作っておきたい場合、この様に書く
// 代入する時に()が必要になることを忘れずに
var teams: [String] = [String]()
var cities: [String] = [] // こんな書き方も可能
var clues = [String]() // こんな書き方も可能
// =, : に注意。

// 列挙型
enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light // 型注釈により？これ以降の代入ではenum名を省略できる
style = .dark
