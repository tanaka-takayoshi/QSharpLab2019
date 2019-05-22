# Qubitの基本操作

Qubitに基本操作を加えて、状態の変化を確認するサンプルコードです。

### Hadamardゲート

[`H`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.intrinsic.h?view=qsharp-preview)操作はHadamardゲートとも呼ばれます。

|0>を1/√2(|0>+|1>)に、|1>を1/√2(|0>-|1>)に、変換し、`H`を2回適用すると元にもどります。
2回適用すると元にもどるというのはHを表現するユニタリー行列の二乗が単位行列となることに対応しています。

### Zゲート

[`Z`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.intrinsic.z?view=qsharp-preview)操作はパウリZゲートとも呼ばれます。
a|0>+b|1>をa|0>-b|1>にする、つまり|1>の符号だけを反転する作用を持ちます。

### Sゲート

[`S`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.intrinsic.s?view=qsharp-preview)操作はπ/4だけ回転させる作用を持ちます。
a|0>+b|1>がa|0>+ib|1>となります。

### R1ゲート

[`R1`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.intrinsic.r1?view=qsharp-preview)操作は|1>を回転軸として指定した角度だけ回転させる作用を持ちます。
角度はラジアン単位ですが、円周率は`PI()`で取得することができます。