import Cocoa

// 文字列の作成方法

// 変数や定数にテキストを代入する場合、それを文字列と呼ぶ
// 二重引用符の中に何を入れるかは自由
let actor = "🔫Keanu Reeves🕶️"
let filename = " avator.jpg "

// 文字列の中に二重引用符を含める場合は、文字列の終わりでなく文字列の中にあると認識させるために、二重引用符の前にバックスラッシュをつける
let quote = "\"I'm gonna make him pay!\""
print(quote)

// 文字列内の改行は指定が特殊になる。あまり使われない書き方
let movie = """
A day in
the life of an
Apple engineer
""" // 冒頭の代入先の記載以降と、末尾の二重引用符は単独で行に並んでいる必要がある

// Swiftには文字列を操作する便利な機能が存在する
// .countを変数or定数名の後ろにつなげて書くと、文字列の長さを読み取ることができる
let nameLength = actor.count
print(nameLength)

// .uppercased()はすべての文字を大文字にした同じ文字列を返す
// 末尾の括弧は何らかの処理を実行させる用途で存在する
print(actor.uppercased())

// .hasPrefix()は、文字列が指定した文字で始まるかどうかを判定してくれる
// .hasSuffix()は、文字列が特定のテキストで終わっているかどうかをチェックする
// 判定条件にする文字列も大文字小文字区別しっかりするので注意
print(actor.hasPrefix("K"))
print(actor.hasSuffix("🕶️"))

// これでもtrueが返ってくる！！
//print(actor.hasSuffix(""))
//print(actor.hasPrefix(""))
