import Cocoa

// 配列に順序付きデータを格納する方法

// 配列, Array
// 曜日、クラスの生徒リスト、過去100年間のその年の人口など、大量のデータを一箇所にまとめるのに、必要なだけ格納できる
// 追加した順でデータを保持する
// 複数の値を角括弧で囲み、値同士の合間はカンマで区切る
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
let strings = ["a", "b", "c"]

// 配列から値を読み取る時、配列内の順番を指定して呼び出す
// 配列内の順番、項目の位置のことを一般的にインデックスと呼ぶ
// インデックスは0からカウントする
// 入力したインデックスが存在していないと、コードはクラッシュする。beatlesで言えば、4を指定するとダメ
print(beatles[0])
print(numbers[2])
print(strings[0])

// 配列が変数であれば、作成後に変更可能
// append()で新しい項目を追加できる
beatles.append("Adrian")
beatles.append("Allen")

// 配列には一度に一種類のデータしか含められない。以下はエラーになる
//numbers.append("Chris")

// 同様に、配列は値を読み取る時、一つの型でしか呼び出せない
// numbersの場合、常に整数しか返されないし、beatlesの場合、常に文字列しか返せない
// 以下はエラーになる
//let firstBeatle = beatles[0]
//let firstNumber = numbers[0]
//let notAllowed = firstBeatle + firstNumber

// Array<Int>() は正確な配列の記法で、<>の中で配列中の値の型を指定する。末尾の()は、必要に応じて配列の生成方法をカスタムする用途で使う
// Swiftでは配列は一般的なものであり、Array<String>()と書く代わりに、[String]()と書くことが可能
var albums = [String]()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

// Swiftの型安全性は、配列が保存しているデータの種類を常に把握していなければならないことを意味している
// 初期値を提供することで、Swiftは自らそれを把握できる可能性がある
var colors = ["red"]
colors.append("blue") // 型を理解しているので、追加できている
colors.append("yellow")

// 以下、配列の便利機能の紹介
// .countは、配列中の項目数を読み取ることができる
print(albums.count)

// 配列から項目を削除する
// remove(at:)を使用して特定のインデックスの項目を削除する
// removeAll()を使用してすべてを削除する
colors.remove(at: 0)
print(colors)
colors.removeAll()
print(colors)

// 配列の特定の項目が含まれているかどうかを確認する contains()
let bondMovies = ["Casino Royale", "Skyfall", "Spectre", "No Time to Die"]
print(bondMovies.contains("Casino Royale"))
//print(bondMovie.contains("Frozen"))

// 配列をソートできる sorted()
print(bondMovies.sorted()) // 項目は昇順に並ぶ。文字列はアルファベット順、数字は数値順になる
print(bondMovies) // 元の配列の並びは変更されない

// 配列の並び順を反転させる reversed()
let reversedBondMovies = bondMovies.reversed()

//print(reversedBondMovies) // eversedCollection<Array<String>>(_base: ["Casino Royale", "Skyfall", "Spectre", "No Time to Die"])
// 上記のコードだと少し変わった出力になるが、これは正常。
// Swiftは項目を反転させたいことを覚えておくだけの処理を実行している
// 反転したものをArrayを使って配列へキャストすると通常の配列の挙動となる

print(Array(reversedBondMovies))
