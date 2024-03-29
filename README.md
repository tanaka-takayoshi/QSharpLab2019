# QSharpLab2019

Q# サンプルコード集と解説

## このドキュメントについて

このドキュメントはde:code 2019向けにQ#を初めてさわる開発者に向けて、Q#のサンプルコードとその解説を集めたものです。
量子プログラミング言語Q#を知るために、すぐに動かせるサンプルコードを作りました。
現時点で用意できているのはQubitの生成と、基本的ないくつかのゲート操作、測定までで、複雑な状態を作るためのゲートの組み合わせであったり、具体的なアルゴリズムなどは含まれていません。

ぜひこのコードを動かし、結果を見て、次にコードのあちこちを変更して結果がどうなるかをみてQ#を知ってほしいと思っています。

### ドキュメントの構成

`01_開発環境の準備` のようにフォルダごとにテーマを分けてます。`01_開発環境の準備`のみは、お手持ちのマシンに環境を準備するため手順のみ記載していますが、それ以外のフォルダはそれぞれプロジェクトとなっており、フォルダ直下の`README.md`をまず読んでいただき、実際にプロジェクトを実行して、ソースコードを読んでQ#を知ってもらえるようにしています。

### 目次

- [開発環境の準備](./01_開発環境の準備)
- [Q#プロジェクトの構造と、Qubitの生成について](./02_Qubitの生成)
- [Qubitの基本操作](./03_Qubitの基本操作)
- [Superpositionの生成](./04_Superpositionの生成)
- [Qubitsの測定](./05_Qubitsの測定)
 
## License
 
The MIT License (MIT)

Copyright (c) 2019 Takayoshi Tanaka (@tanaka_733)