# GITブランチを使ったプログラミング言語の作り方の作り方

## 1. はじめに

プログラミング言語の作り方をインクリメンタルに行う文章はチュートリアル的に言語を楽しく作れるようになるため、一分界隈で人気があります。
そんなプログラミング言語の作り方を書くのはけっこう大変です。そこでバージョン管理ソフトであるGITを使ってうまく作る方法を考えます。
基本的なアイディアは各章ごとにGITのブランチを切って管理し成長させていけばいいじゃんというものです。
バージョン事にブランチがあるので元のブランチを修正したければ、単にそのブランチをチェックアウトして修正し、それ以降の章は修正された章をマージすればいいのです。
そのアイディアを元に大雑把な開発の流れを書きながらブランチを作って修正してみようと思います。
まずはgit init、git add .、git commit -aでコメントつけて保存後、この章の１ブランチを作るところから話ははじまります:

```
git checkout -b 1
```

君はそう、この修行を通じて時の魔法使いとなりて完璧な魔導書を作る魔法を手に入れるのです。
この枝を使いこなせばあなたはより一流の魔法使いに近づくことができます。

２章の修行を始める前に、

```
git checkout -b 2
```

と書きます。それから２章を始めましょう。

1章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/0..1
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

2章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/1..2
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

e.plに加えて

```
% swipl e.pl
10
21
```

で実行することができます。

3章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/2..3
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

を2章を見ながら、e.plとして保存します。

```
git commit -a -m "4"
git checkout 2
```

としてからファイルを書き込み、

```
git add e.pl
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

とやってe.plに引き算のプログラムをかいたら、

```
git commit -a -m "3"
git checkout 4
git merge 3
```

です。
なんともタイムマシンに乗るような体験になると思いますが、3章に歴史上なかったe.plが生まれて我々の住む世界にもその情報を持ち越すことができました。
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

4章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/3..4
## 5. githubで差分を見よう

```
git commit -a -m 5
git checkout main
git merge 5
```

githubに上げて、差分を見ながら作業をすると何かと便利です。この章ではgithubを利用する方法を説明します。
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

と言われるので、--set-upstrem origin を加えてpushします。
同様に、

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

差分を以下のアドレスから見ることができます:

- 1-2 https://github.com/hsk/momoplugb/compare/1..2
- 2-3 https://github.com/hsk/momoplugb/compare/2..3
- 3-4 https://github.com/hsk/momoplugb/compare/3..4
- 4-5 https://github.com/hsk/momoplugb/compare/4..5
- 5-6 https://github.com/hsk/momoplugb/compare/5..6

5章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/4..5

# 6. 禁断の履歴書き換え

履歴を完全に書き換えて最低限のものを残す方法を以下に示します。
途中経過が消えてしまうので必要な場合のみ行ってください。

ブランチを持ってくる

```
git pull origin 1:1
git pull origin 2:2
git pull origin 3:3
git pull origin 4:4
git pull origin 5:5
git pull origin 6:6
```

空のブランチを作る

```
git checkout --orphan v0
```

他のブランチのファイルを全部上書帰してコミットする。(マージではなく展開するだけ)

```
git commit -a -m 0
git checkout -b v1 && git checkout 1 . && git add . && git commit -a -m 1
git checkout -b v2 && git checkout 2 . && git add . && git commit -a -m 2
git checkout -b v3 && git checkout 3 . && git add . && git commit -a -m 3
git checkout -b v4 && git checkout 4 . && git add . && git commit -a -m 4
git checkout -b v5 && git checkout 5 . && git add . && git commit -a -m 5
git checkout -b v6 && git checkout 6 . && git add . && git commit -a -m 6
git checkout -b v7 && git checkout 7 . && git add . && git commit -a -m 7
```

ファイル内容修正作業用

ファイル内容に変更がある場合はこちらを使うと便利です

```
git commit -a -m 0 && git checkout -b v1 && git checkout 1 . && git add . 
git commit -a -m 1 && git checkout -b v2 && git checkout 2 . && git add .
git commit -a -m 2 && git checkout -b v3 && git checkout 3 . && git add .
git commit -a -m 3 && git checkout -b v4 && git checkout 4 . && git add .
git commit -a -m 4 && git checkout -b v5 && git checkout 5 . && git add .
git commit -a -m 5 && git checkout -b v6 && git checkout 6 . && git add .
git commit -a -m 6 && git checkout -b v7 && git checkout 7 . && git add .
git commit -a -m 7

間違えたとき用

git checkout main
git branch -D v0
git branch -D v1
git branch -D v2
git branch -D v3
git branch -D v4
git branch -D v5
git branch -D v6
git branch -D v7
```

古いブランチを消す

```
git branch -D 0
git branch -D 1
git branch -D 2
git branch -D 3
git branch -D 4
git branch -D 5
git branch -D 6
git branch -D 7
```

新しいブランチに書き換える

```
git checkout v0 && git branch -m 0
git checkout v1 && git branch -m 1
git checkout v2 && git branch -m 2
git checkout v3 && git branch -m 3
git checkout v4 && git branch -m 4
git checkout v5 && git branch -m 5
git checkout v6 && git branch -m 6
git checkout v7 && git branch -m 7
```

github上のブランチを上書きする

```
git checkout 0 && git push --set-upstream origin 0 --force
git checkout 1 && git push --set-upstream origin 1 --force
git checkout 2 && git push --set-upstream origin 2 --force
git checkout 3 && git push --set-upstream origin 3 --force
git checkout 4 && git push --set-upstream origin 4 --force
git checkout 5 && git push --set-upstream origin 5 --force
git checkout 6 && git push --set-upstream origin 6 --force
git checkout 7 && git push --set-upstream origin 7 --force
```

mainに上書きしてしまう。

```
git checkout 7 && git checkout -B main
```

github上のmain を上書きする

```
git push --force
```

github上のブランチにpush

```
git checkout 0 && git push --set-upstream origin 0
git checkout 1 && git push --set-upstream origin 1
git checkout 2 && git push --set-upstream origin 2
git checkout 3 && git push --set-upstream origin 3
git checkout 4 && git push --set-upstream origin 4
git checkout 5 && git push --set-upstream origin 5
git checkout 6 && git push --set-upstream origin 6
git checkout 7 && git push --set-upstream origin 7
```

6章の変更は次のアドレスから見ることができます: https://github.com/hsk/momoplugb/compare/5..6
