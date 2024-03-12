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
git merge 2
```

としてマージします。そのまえにコミットしてからだけどね。
