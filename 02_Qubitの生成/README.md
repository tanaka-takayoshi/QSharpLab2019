# Qubitの生成

このプロジェクトではQ#プロジェクトの構造と、Qubitの生成について説明します。

## Q#プロジェクトの構造

実行可能なQ#プロジェクトは最低以下の3つのファイルを持っています。

- <プロジェクト名>.csproj
- <ファイル名>.cs
- <ファイル名>.qs

`csproj`ファイルで分かるように、プロジェクトとしてはC#プロジェクトで、.NET Core Consoleプロジェクトとなっています。
クラスライブラリの場合は.NET Coreのクラスライブラリプロジェクトとなります。
Q#コードをC#プロジェクトから実行させるために、いくつかのNuGetパッケージが追加されています。
`<ファイル名>.cs`はこのフォルダの場合`Driver.cs`ファイルであり、エントリポイントとなる`Main`メソッドが含まれています。
Q#プロジェクトはまずコンソールプロジェクトとしてC#で書かれたクラスが実行され、そこからQ#で書かれたコードが実行されます。
このフォルダではQ#コードが`Operation.qs`ファイルとなります。

## Q#コードの実行

`Driver.cs`のMainメソッドでは次のコードが記述されています。

```
using (var qsim = new QuantumSimulator())
{
    HelloQ.Run(qsim).Wait();
}
```

`QuantumSimulator`というのはQ#のコードをローカルマシンの量子コンピューターシミュレーターで実行するためのDriverクラスです。
2019年5月現在、Q#のコードを直接実機の量子コンピューターで実行するDriverはQ#のSDKでは提供されていませんが、今後提供された場合はこの`QuantumSimulator`の部分を差し替えるだけでよいことが期待されています。
`HelloQ`というのは`Operation.qs`ファイルに記述されている以下のoperation定義に対応しています。

```
operation HelloQ () : Unit {
    Message("Hello quantum world!");
    CreateQubit();
    CreaMultiteQubits();
}
```

operationというのはQ#で定義できる処理のかたまりです。
Q#プロジェクトでは、Q#で定義したoperationがC#からはクラスとして参照できます。
この参照できるクラスは`QuantumSimulator`クラスを引数にとる`Run`メソッドを持っており、Runメソッドを実行することで、引数に渡したDriver上で参照したQ#のoperationを実行することができます。
実行結果はC#のasync/await構文で利用する`Task`（もしくは`Task<T>`）であるため、`await`するか`Wait`メソッドなどで完了を待機できます。

### Qubitの生成

Q#コードの中で、Qubitは`Qubit()`もしくは`Qubit[n]`で割り当てることができます。前者は1つのQubitが割り当てられ、後者は`n`個のQubitが配列として割り当てられます。
また、割り当てたQubitのライフサイクルを管理するため、通常using節を使います。

```
using (qubit = Qubit()) {
    
}
```

usingを抜ける際にQubitは返却されます。

### Qubit状態の出力

量子コンピューターおよびQubitの性質上、ある時点でのQubitの状態を確認することはできません。
後述する測定によって、|0>あるいは|1>のどちらの値を検出するか調べることだけができます。
しかし、シミュレーターで動かしている場合は、[`DumpRegister`]()という操作によって任意の時点のQubitの状態を出力して確かめることができます。
この操作は2つの引数を取り、最初の引数は出力場所を指定しますが、空のタプル`()`を指定することで標準出力に出力できます。
第2引数に状態を出力するQubitの配列を指定します。

生成したばかりの2つのQubitの状態を確認してみます。

```
using (qubits = Qubit[2]) {
    DumpRegister((), qubits);
    ResetAll(qubits);
}
```

すると、次のように出力されます。`0:`から`3:`というのは2つのQubitの測定結果の組み合わせで、順番に |00>,|10>,|01>,|11>です。
`0: 1 0`という後ろに続く2つの数字は確率で、複素数を取るため実部と虚部に分かれています。
ここでは、`0:`の実部のみ1で、残りが全部0なので、|00>という状態のみになっていることがわかります。
Q#では、usingで割り当てたQubitは必ず|0..0>という状態に初期化されており、それを確認したことになります。

```
# wave function for qubits with ids (least to most significant): 0;1
0:      1       0
1:      0       0
2:      0       0
3:      0       0
```

次に、2つのQubitの最初のQubitに`X`という操作をしてみます。
`X`操作というのは、|0>と|1>という状態を反転させる操作です。

```
using (qubits = Qubit[2]) {
    X(qubits[0]);
    DumpRegister((), qubits);
    ResetAll(qubits);
}
```

|00>の最初のQubitのみ反転させるので|10>と測定される確率の実部のみ1となっています。

```
# wave function for qubits with ids (least to most significant): 1;0
0:      0       0
1:      1       0
2:      0       0
3:      0       0
```

## Qubitのリセット

Q#の仕様上、using節を抜けてQubitを返却する際は状態が0になっている必要があります。
そこで[`ResetAll`]()という操作が用意されており、引数に指定したQubitの状態を|0>にリセットすることができます。

```
using (qubits = Qubit[2]) {
    X(qubits[0]);
    X(qubits[1]);
    DumpRegister((), qubits);
    ResetAll(qubits);
}
```