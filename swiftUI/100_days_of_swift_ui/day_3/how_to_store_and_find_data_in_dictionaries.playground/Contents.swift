import Cocoa

// 辞書にデータを保存および検索する方法

// 配列は追加した順序や重複する項目が含まれる可能性がある場合に最適だが、配列内の位置に基づいてデータにアクセスすることは煩わしかったり、危険だったりする

// 従業員の詳細情報
var employee = ["Taylor Swift", "Singer", "Nashvile"]
// こんな感じで表示できるかもしれない
print("Name: \(employee[0])")
//employee.remove(at: 1) // これを実行すると...
print("Job title: \(employee[1])")
print("Location: \(employee[2])")
// こういった造りには問題が2つあり、深刻な問題を引き起こす場合がある
// 1. employee[2]が本当にLocationであることが確信できない、という問題がある。もしかしたら、パスワード情報かもしれない。
// 2. employeeの配列に[2]の項目が存在する保証がない。配列は変数なので、変わっている可能性がある

// こういった問題を解決するために、Swiftには辞書、Dictionariesが存在する
// 辞書型は、項目をどこに保存すべきか指定することができる

// 配列では値だけを保存していたが、辞書では値に名前をつけることができる
// 左側の文字列を辞書の「キー」と呼び、右側の文字列を「値」と呼ぶ
//let employee2 = ["name" : "Taylor Swift", "job" : "Singer", "location" : "Nashvile"] // 一行で書ける

let employee2 = [ // 改行もできる
    "name" : "Taylor Swift",
    "job" : "Singer",
    "location" : "Nashvile"
]

// 辞書からデータを読み取る時は、キーを使用する
// Optionalに囲まれた値が出力される
// これは、辞書内のデータにアクセスした時に「値が返される可能性もあれば、何も返されない可能性もある」という表示をしている
// Swiftでは値は任意（optional）であるため、Optionalと呼ばれる
print(employee2["name"]) // emplyee2に存在するキー。Optional("Taylor Swift")が返ってくる
print(employee2["password"]) // emplyee2に存在しないキー。nilが返ってくる

// Expression implicitly coerced from 'String?' to 'Any'
// 「『String?』から暗黙的に強制された表現「Any」へ」という意味。本当に呼び出してもいいの？と聞かれている

// 読み取ろうとした時、キーが存在しなかった場合の出力を default: で指定できる
// 値がなかった時、nilを出力するか、default値を出力するか、という2通りの選択肢がある、ということ
// nameにnilの値が入っている場合は、nilが出力され、nameというキーが見つからなかった場合にdefault値が出力される
print(employee2["name", default: "Unknown"])

// 他の型も利用できる
let hasGraduated = ["Eric": false, "Meave": true, "Otis": false]
let olympic = [2012: "London", 2016: "Rio de Janeiro", 2021: "Tokyo"]
print(olympic[2016, default: "Unknown"])

// 先に保存する予定の型のみ指定して、後からキーを一つずつ設定することも可能
var heights = [String: Int]() // 型を指定する場合は末尾のカッコが必要になる。確かにカッコなかったら配列になるもんな
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

// 辞書ではキーの重複は許可されない。すでに存在するキーに値を設定しようとすると、Swiftは以前の値を上書きしてしまう
heights["LeBron James"] = 207

// count()やremoveAll()などの便利な機能が辞書にも備わっており、操作することができる
print(hasGraduated.count)
print(heights)
let emptyHeights = heights.removeAll()
print(emptyHeights)
