# GITブランチを使ったプログラミング言語の作り方の作り方

## 1. はじめに

プログラミング言語の作り方をインクリメンタルに行う文章はチュートリアル的に言語を楽しく作れるようになるため、一分界隈で人気があります。
そんなプログラミング言語の作り方を書くのはけっこう大変です。バージョン管理ソフトであるGITを使ってうまく作る方法を考えます。
基本的なアイディアは各章ごとにGITのブランチを切って管理し成長させていけばいいじゃんというものです。
バージョン事にブランチがあるので元のブランチを修正したければ、単にそのブランチをチェックアウトして修正し、それ以降の章は修正された章をマージすればいいのです。
そのアイディアを元に大雑把な開発の流れを書きながらブランチを作って修正してみようと思います。
まずはgit init、git add .、git commit -aでコメントつけて保存後、この章の１ブランチを作ります。

```
git checkout -b 1
```

２章を書き始める前に、

```
git checkout -b 2
```

と書きます。それから２章を書き始めましょう。

## 2. 構文を書こう


BNFを数学的にチャカチャカと書きます。

構文

```
e ::= i | e+e
```

ご覧のように足し算ができるだけの言語です。
これを実装する言語は Prolog で書きます。

評価規則

```
eval(I,I)    :- integer(I).                          % 整数
eval(E1+E2,I):- eval(E1,I1),eval(E2,I2),I is I1+I2.  % 加算
:- eval(1+2+3+4,R),writeln(R).
:- halt.
```

Prologで評価規則を書くときれいに書けます。
これだけですね。

```
git commit -a -m "2"
```

ここで時を戻してみましょう。

```
git checkout 1
```

とかくとこのコメントが消えて、１章だけの時代に戻ります。

```
git checkout 2
```

として戻ってきましょう。

次は３章を書きますよ。

```
git commit -a -m "2"
git checkout -b 3
```

です。

## 3. 引き算を加える。

構文

```
e ::= i | e+e | e-e
```

e-e の構文を増やします。

評価規則

```
eval(E1-E2,I):- eval(E1,I1),eval(E2,I2),I is I1-I2.  % 減算
:- eval((10+20)-(3+4)-2,R),writeln(R).
```

追加する評価規則はこれだけ。あ、、、haltしてないから終わらんぞ、、、。

```
git commit -a -m "3"
git checkout 2
```

として、haltを追加して戻ってきましょう。

2章にhaltを追加したので、

```
git commit -a -m "3"
git merge 2
```

としてマージします。そのまえにコミットしてからだけどね。

<<<<<<< HEAD
```
git commit -a -m "3"
git checkout main
git merge 3
git checkout 3
```

としてmainに3章までの変更をマージして戻ってきましょう。

3.plに加えて

```
% swipl 3.pl
10
21
```

で実行することができます。

## 4. プログラムを加える。

```
git checkout -b 4
```

さあ、いつものようにブランチを切って、Prologのプログラムを２章と３章に加えていきましょう。

```
eval(I,I)    :- integer(I).                          % 整数
eval(E1+E2,I):- eval(E1,I1),eval(E2,I2),I is I1+I2.  % 加算
:- eval(1+2+3+4,R),writeln(R).
:- halt.
```

を2章を見ながら、2.plとして保存します。

```
git commit -a -m "4"
git checkout 2
```

としてからファイルを書き込み、

```
git add 2.pl
git commit -a -m "2"
git checkout 4
```

で戻ってきて、マージしちゃいましょう。

```
git merge 2
```

プログラムもある状態になりました。
３章の引き算についても書き加えてきましょう。

```
git commit -a -m "4"
git checkout 3
```

で、２章をマージしてから、３章の引き算を加えます。

```
git merge 2
```

とやって2.plに引き算のプログラムをかいたら、

```
git commit -a -m "3"
git checkout 4
git merge 3
```

です。
なんともタイムマシンに乗るような体験になると思いますが、3章に歴史上なかった3.plが生まれて我々の住む世界にもその情報を持ち越すことができました。
バンザイ！！
このようなgit操作をすることでドキュメントをあとから加えたり、プログラムを前に戻って修正しながら、プログラミング言語の作り方を書くことができます。
作り方がかければバージョン管理もずっとうまくなっているはずです。

```
git commit -a -m "4"
git checkout main
git merge 4
git checkout -b 5
```

次に進みましょう。

## 5. まとめ

ここではGITブランチを使ったプログラミング言語の作り方の作り方を書きました。
実際に簡単な言語を作る方法を先に書いた後に、前の章に戻って文章やプログラムを加えるなどして修正もしてみました。
この手法を用いれば１つのリポジトリ内で美しいプログラミング言語の作り方を書くことができます。
是非試してみてください。

```
git commit -a -m 5
git checkout main
git merge 5
```

ではまたあいましょう。

あ、そうそう、githubにあげてませんでしたね。
githubでリポジトリを作ったら、

```
git remote add origin git@github.com:hsk/momoplugb.git
git branch -M main
git push -u origin main
```

としてサーバ上におきます。

```
git checkout 1
git push
```

とすると

```
git push --set-upstream origin 1
```

と言われるので、そうして戻ってきます。

```
git checkout 2
git push --set-upstream origin 2
git checkout 3
git push --set-upstream origin 3
git checkout 4
git push --set-upstream origin 4
git checkout 5
git push --set-upstream origin 5
```

としてブランチをサーバ上に置きましょう。
