import Cocoa

// 列挙型の作成方法と使用方法

// 列挙型 enumとは、名前付き値の集合
// ユーザーが曜日を選択できるようにするコードを書いているとする
var selected = "Monday"
selected = "Tuesday"
selected = "January" // 月が入っている
selected = "Friday " // Fridayの末尾にスペースが入っちゃった
// 色々入れることができてしまう。このようなことに文字列を使うには、慎重なプログラミングが必要で、効率も悪い。
// ここで列挙型が登場する

// 列挙型は、特定の値を持つ新しいデータ型を定義できる
// 例えば、ブール型はtrueかfalseしか選択肢が存在しない。
// 「maybe」や「probably」は設定できない。ブール型が理解できる値の範囲に含まれていないため。
// 列挙型も同じで、列挙型が取り得る値の範囲を事前にリストアップでき、Swiftは列挙型の使用時に間違いがない様にしてくれる

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

// caseを一つだけ書いて、カンマ区切りで連ねる書き方もできる
//enum Weekday {
//    case monday, tuesday, wednesday, thursday, friday
//}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

// 列挙型を使うことによって「friday」に余計なスペースを入れてしまったり、月の名前を入力してしまったり、といったミスを防ぐことができる
// 常に列挙型でリストされている曜日のいずれかを選択する必要がある
// 「Weekday.」と入力すると、すべてのオプションを確認できる

// 変数・定数に値を代入すると、データ型は固定され、後から変更することはできなくなる
// この前提により、列挙型では、最初の代入の後は、列挙型の名前を省略することができる

var ommittedDay = Weekday.monday // 値の型は、ここで確定している
ommittedDay = .monday // 列挙型の名前を省略。型は確定しているので、case名のみ書いて表すことができる

// 列挙型の利点は、Swiftがそれらを最適化された形で保存できること
// caseの場合分けを内部的に0の様な単一の整数で保存する可能性が高く、
// mondayのような文字列で管理するよりも格納・チェックがはるかに効率的である

// enum使い方のコツ：限られた選択肢を持つ場合、列挙型にするのが好ましい
