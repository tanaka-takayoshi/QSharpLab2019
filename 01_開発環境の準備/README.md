# 開発環境の準備

ここではQ#の開発環境の準備をします。最新情報は以下の公式ドキュメントを参照してほしいので、このドキュメントでは注意事項をまとめています。

- [https://docs.microsoft.com/en-us/quantum/install-guide/csharp?view=qsharp-preview](https://docs.microsoft.com/en-us/quantum/install-guide/csharp?view=qsharp-preview)

また各プロジェクトは、5/23現在でのQ#の最新バージョン0.6で開発しています。

## サポートされるOS

原則として.NET Core SDK 2.1以上が動作するOSであればサポートされます。
詳細は[こちらの記事](https://github.com/dotnet/core/blob/master/release-notes/2.1/2.1-supported-os.md)に記載されていますが、Windows 7 SP1以降、macOS 10.12以降、さまざまなLinuxディストリビューションが対象です。

## サポートされるエディタ

Q#は.NET Core CLI経由でインストールし、ビルドできます。そのため、任意のテキストエディタと.NET Core CLIコマンドの組み合わせで開発できます。Visual Studio と Visual Studio Codeについては拡張機能が提供されています。

## 手順の概要

1. (必須) [.NET Core SDK](https://dotnet.microsoft.com/download) 2.1以降をインストールする
2. (どちらかを利用したい場合) Visual Studio 2017以降もしくはVisual Studio Codeをインストールする
2. (Visual Studioを利用する場合) [Visual Studio拡張](https://marketplace.visualstudio.com/items?itemName=quantum.DevKit)をインストールする
3. (Visual Studio Codeを利用する場合) [Visual Studio Code拡張](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode)をインストールする
4. (Visual Studio Codeもしくは任意のエディタを利用する場合) .NET Core CLIを使ってプロジェクトテンプレートをインストールする

```
dotnet new -i Microsoft.Quantum.ProjectTemplates
```


## このリポジトリの動作確認

.NET Core CLIで直接実行する場合は、`dotnet run <csprojファイルへのパス>`が実行できればOKです。
Visual Studio Codeを利用する場合は、このリポジトリを開いて、csprojファイルを対象にプロジェクトを実行できればOKです。
Visual Studioを利用する場合は、このリポジトリの直下にあるソリューションファイルを開いてプロジェクトが実行できればOKです。