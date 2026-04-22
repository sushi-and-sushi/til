import Cocoa

// 配列に順序付きデータを格納する方法

// 配列, Array
// 曜日、クラスの生徒リスト、過去100年間の年の人口など、大量のデータを一箇所にまとめるのに、必要なだけ格納できる
// 追加した順でデータを保持する
// 複数の値を角括弧で囲み、値同士の合間はカンマで区切る
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]

// 配列から値を読み取る時、配列内の順番を指定して呼び出す
// 配列内の順番、項目の位置のことを一般的にインデックスと呼ぶ
// インデックスは0からカウントする
// 入力したインデックスが存在していないと、コードはクラッシュする。beatlesで言えば、4を指定するとダメ
print(beatles[0])
print(numbers[2])

// 配列が変数であれば、作成後に変更可能
// apend()で新しい項目を追加できる
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

// 次の箇所から再開：This is type safety, just like how Swift won’t let us mix integers and decimals, except it’s taken to a deeper level. Yes, all beatles and numbers are both arrays, but they are specialized types of arrays: one is an array of strings, and one is an array of integers.
