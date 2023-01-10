[3.3 Git – Ветки – Команда checkout при незакоммиченных изменениях](https://www.youtube.com/watch?v=KxKjBneF_NI&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=13)


Проблемы с checkout при наличии изменения, варианты их решения:
- удаление с checkout -f
- сохранение с git stash

Очистка индекса возможна с помощью:
```bash
git checkout -f HEAD
git checkout -f
```

***stash*** не привязак к ветке, поэтому можно применить на одной ветки, а вернуть на другую. Нужно иметь ввиду что родительский коммит должен быть один и тот же.

Проблека с checkout не будет, если редактируемый файл опирается на один и тот же родительский коммит, но надо быть аккуратнее, чтобы бы не закомитить в другую ветку.
```bash
git stash
git checkout <new_branch>
git stash pop
```
---

[3.4 Git – Ветки – Перенос незакоммиченных изменений](https://www.youtube.com/watch?v=mlxmxsBzIMs&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=14)


Создание новой ветки для текущих изменений.
```bash
git checkout -b fix
git commit -am "New changes"
```
---

[3.5 Git – Ветки – Перенос веток "вручную"](https://www.youtube.com/watch?v=6oZG-pAeHRE&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=15)


- Перенос последних коммитов в новую ветку: общий подход.
- Создание и перенос веток на нужный коммит.

```bash
git branch <new_branch>
git chechout <new_branch>
git branch -f master <some_commit>
# git checkout -B <old_branch> <some_commit>
```

Если передумал
```bash
git branch -f master <new_branch>
```

---
[3.6 Git – Ветки – Состояние отделённой HEAD](https://www.youtube.com/watch?v=g0GgtqlhHaw&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=16)

- Git checkout на произвольный коммит
- Состояние "detached HEAD", выход из него.

```bash
git checkout <some_commit>
```
Теперь в HEAD будет ссылка не на ветку, а на коммит. Это как раз и есть отделенный HEAD

```bash
git commit -am "Show detached HEAD"
git checkout <old_branch>
```

После этого сложно будет вернуться обратно, так как нет ветки разработки и надо искать тот самый коммит. А далее эта "ветка" будет автоматически удаленна через какое-то время.

---
[3.7 Git – Ветки – Восстановление предыдущих версий файлов](https://www.youtube.com/watch?v=3z-LjQacu2Q&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=17)

- Получение предыдущих версий файлов из репозитория в текущее состояние проекта.
- Замена/восстановление файлов на предыдущие.

```bash
git checkout <some_commit> <some_file>
```

Откатить все изменения для текущего индекса
```bash
git checkout HEAD <some_fle>
# git checkout <some_file>
```
---
[3.8 Git – Ветки – Просмотр истории и старых файлов, символы ~, ^, @, поиск с :/](https://www.youtube.com/watch?v=l-sTQBr3rXY&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=18)

```bash
git log
git log --oneline
```
Посмотреть изменения в конкретном коммите
```bash
git show <some_commit>
```
Переход на один коммит назад `~`
```bash
git show HEAD~
git show HEAD~~
git show HEAD~2
git show @~
```


Посмотреть предыдущий файл целиком
```bash
git show @~:<some_file>
```

Использовать поиск по слову в описание. Ищем самый свежий коммит с таким словом во всех ветках
```bash
git show :/<some_word>
```

---
[3.9 Git – Ветки – Слияние веток "перемоткой"](https://www.youtube.com/watch?v=g--N6QHbt6Q&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=19)

- Команда git merge (простейший случай).
- Отмена простого git merge.

В самом простейшем случае будет использоваться метод перемотки fast-worward. Т.е. указатель более старой ветки будет перемещен на указатель более новой ветки.
```bash
git merge <some_branch>
```
Если передумал, то можно написать 
```bash
git branch -f <current_branch> <some_commit>
# or
git branch -f <current_branch> ORIG_HEAD
```

---
[3.10 Git – Ветки – Удаление веток](https://www.youtube.com/watch?v=yFVPNYSTlLQ&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=20)

- Удаление ветки после merge: git branch -d
- Удаление любой ветки: git branch -D

 Ветка удалится без проблем, если она ссылается на коммит, что и другая ветка. В ином случае, гит вернет ошибку, т.к. часть коммитов будет недостижимыми и со временем будут удалены автоматически
 
 Восстановить ветку нельзя, но можно создать новую с таким же названием, которая будет указывать на тот же коммит.
 ```bash
 git branch <the_same_branch> <the_same_commit>
 ```

 ---
 [3.11 Git – Ветки – История переключений веток: лог ссылок reflog](https://www.youtube.com/watch?v=FxyGx_XTRhA&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=21)

- Что такое reflog?
- Зачем он полезен (восстановление удалённой ветки)
- Форматирование вывода reflog, поиск по дате.
- Продвинутые варианты reflog.
- Синтаксис @{-N}.


```bash
git reflog <some_branch [HEAD]
git reflog [HEAD]

git branch <some_branch> HEAD@{some_number or some_date}
```

```bash
git reflog
# the same
git log --oneline -g
```

```bash
git reflog --date=iso
```

Переключиться на предыдущю ветку
```bash
git checkout @{-1}
# or
git checkout -
```
Равносильно, что напиать `git reflog`, там найти последний checkout, и поставить в идентификатов для `git checkout <some_id>`

---
[4.1 Git – Удаление "лишних" файлов и незакоммиченных изменений](https://www.youtube.com/watch?v=h9kYvAQoXjo&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=22)

- Удаление незакоммиченных изменений с git checkout -f или reset --hard.
- Удаление неотслеживаемых "лишних" файлов при помощи git clean.

Полностью почистить проект до прошлого коммита, при условии что есть новые добавленные файлы
```bash
git checkout -f
git clean -dxf
```

---
[5.1 Git – Reset – Жесткий reset --hard: отмена изменений, удаление коммитов](https://www.youtube.com/watch?v=DMncFUqzDuM&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=23)

- Команда reset --hard
- Удаление изменений: до коммита и после коммита.

```bash
git reset --hard <some_commit>
git reset --hard @~
```

В случае, если передумал, гит записывает предыдущий HEAD
```bash
# cat .git/ORIG_HEAD
git reset --hard ORIG_HEAD
```

Так же с помощью этого можно очистить рабочую директорию и index.

---
[5.2 Git – Reset – Мягкий reset --soft: замена и объединение коммитов](https://www.youtube.com/watch?v=bUdLmdSMm7E&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=24)

- Команда reset --soft: передвижение указателя ветки без индекса и данных.
- Использование reset для исправления последнего коммита (или даже нескольких).

```bash
git reset --sorf @~
```

В данном случае указатель будет показывать на предыдущий коммит, а рабочая директория и index будет создержвать файлы из ORIG_HEAD

Случай, когда коммит надо чу-чуть доделать
```python
git reset --soft @~
# some chagnes
git add <some_file>
git commit -c ORIG_HEAD # copy info from previous commit
```

---
[5.3 Git – Reset – Правка последнего коммита: commit --amend](https://www.youtube.com/watch?v=Hho9WBgWil0&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=25)

- Быстрое исправление последнего коммита: commit --amend.

Гит `amend` тоже сокращие из предыдущего видео. Удобно использовать с флагом `-m` для изменения комментария. Но надо иметь ввиду, что это сокращение для _предыдущего коммита_.


---
[5.4 Git – Reset – Смешанный reset (без флагов), сравнение видов reset](https://www.youtube.com/watch?v=r1oUTfqKXac&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=26)

- Таблица основных видов reset, их сравнение.
- Отмена индексации с reset без флагов.

| reset --soft | reset --mixed     | reset --hard     | 
|:-------------|:-----|:-----|
| working direcotry | working directory | <span style="color:red">working directory</span> | 
| index | <span style="color:red">index</span> | <span style="color:red">index</span> | 
| <span style="color:red">current branch</span> | <span style="color:red">current branch</span> | <span style="color:red">current branch</span> | 


`git reset --soft HEAD` или `git reset` можно использовать для сброса изменений в индексе. Например на случай, когда слишком рано добавил файл в индекс или хочешь сформировать индекс по другому.


---
[5.5 Git – Reset – Таблица с действиями reset](https://www.youtube.com/watch?v=hb-x1SJB43s&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=27)

Документация Git: таблица с действиями разных видов reset в разных состояниях проекта.


---
[6.1 Git – Просмотр – Сравнение коммитов, веток и не только: git diff](https://www.youtube.com/watch?v=1oExHLJXBIg&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=28)
- Вывод git diff, сравнение коммитов.
- Сравнение веток с git diff.
- Синтаксис для сравнения с учётом рабочей директории/индекса/HEAD.

Примеры
```bash
git diff <branch_1> <branch_2>
git diff <branch_1>..<branch_2>


git diff <branch_1>...<branch_2> # what changed after a split


git diff # compare working directory and index
git diff HEAD # compare working directory and Repo
git diff --cached # compare index and Repo
```

---
[6.2 Git – Просмотр – Вывод истории: git log, форматирование коммитов](https://www.youtube.com/watch?v=Oim9dbpbCMc&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=29)
- Базовое использование git log
- Примеры полезных флагов и форматирования вывода git log

---
[6.3 Git – Просмотр – Диапазоны коммитов для git log и не только](https://www.youtube.com/watch?v=nRYSu3wbNXo&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=30)
- Синтаксис git для диапазонов коммитов.
- Вывод истории для одной ветки.
- Вывод дерева веток с флагом --graph.


Некоторые примеры. 

Показать коммиты из `feature` кроме коммитов из `master`
```bash
git log feature ^master
# or
git log master..feature


git help revisions # help
```

---
[6.4 Git – Просмотр – Вывод git log коммитов, меняющих нужный файл](https://www.youtube.com/watch?v=7A68GxROZ2I&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=31)
- Вывод git log коммитов, меняющих интересные нам файлы или директории

---
[6.5 Git – Просмотр – Поиск в истории, фильтры для git log](https://www.youtube.com/watch?v=lhrchh5dqH0&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=32)
- Поиск коммитов по строке в описании.
- Поиск коммитов по строке в изменениях.
- Поиск коммитов, меняющих интересный нам фрагмент файла (по регэкспу).
- Поиск коммитов по дате.

Пример с grep где используется несколько совпадений одновременно.
```bash
git log --grep Hello --grep world --all-match
```

Изменить конфиг для более современных регулярок. `git config --global grep.patternType perl`

Поиск по изменениям.
```bash
git log -G'some words'

git log -L '/match start/','/match end/':my_file
```

---
[6.6 Git – Просмотр – Кто написал эту строку? git blame](https://www.youtube.com/watch?v=o9du71FpLLM&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=33)
- Вывод авторов для каждой строки кода с git blame.
- Флаги git blame, форматирование вывода.

---
[7.1 Git – Слияние – "Истинное" слияние и разрешение конфликтов в git merge](https://www.youtube.com/watch?v=PXK1hIifpWU&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=34)
- Процесс слияния веток и файлов при помощи git merge.
- Конфликты и их разрешение.


При слиянии, гит сравнивает 3 файлы:
- base - коммит, где две ветки разошлись
- ours - коммит, нашей ветки
- theirs - коммит, ветки которую хотим слиять

![alter text](https://kapitonov.tech/img/25cb0d275c318f2ce15f.png)

Гит запоминает состоянии, на котором прервалось слияния. Его можно узнать с помощью команды 
```bash
cat .git/MERGE_HEAD
```
![alter text](https://kapitonov.tech/img/2ed0143fad9057a14419.png)

Гит сравнивает все 3 состояния. Если в одной из веток это состоянии не изменилось от `base`, тогда гит автоматически берет изменение из той ветки, что изменилась.

##### Пример конфлита
![alter text](https://kapitonov.tech/img/9a0be70fc87b781e4d9a.png)
![alter text](https://kapitonov.tech/img/4d6e4880ee5f736a2a66.png)

##### Варианты решеиий

```bash
git checkout --ours <some_file>
git checkout --theirs <some_file>
git checkout --merge <some_file>
# turn all back
git reset --hard # on clear git status
git reset --merge # sometimes much better
```

При решении конфликта, иногда хочется посмотреть что было до конфликта, для этого есть модицикация команды

```bash
git checkout --conflict=diff3 --merge <some_file>
```

---
[7.2 Git – Слияние – Коммит слияния, дальнейшие слияния](https://www.youtube.com/watch?v=EJKw_qW5pgI&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=35)
- Как устроены коммиты слияния, получение их родителей.
- Структура веток после слияний.
- Удобное описание для коммитов слияния.


В данном случае `git show` нужен для того, чтобы посмотреть какие были конфликты и как они решились

Некоторые опции
```bash
git show --first-parent

git diff HEAD^1 # first parent
git diff HEAD^2 # second parent

# in case I want to see more
git diff HEAD^^ # parent of first parent
git diff HEAD^2^ # parent second parent
```

![alter text](https://kapitonov.tech/img/caa6d8b43f16d5810e7b.png)

Посмотреть какие ветки у же объеденены
```bash
git branch --merged
```

---
[7.3 Git – Слияние – Отмена слияния](https://www.youtube.com/watch?v=TEsjp1eDLx4&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=36)
- Как отменить слияние, если что-то пошло не так?
- Отмена успешных слияний, возврат назад по истории.

---
[7.4 Git – Слияние – Семантические конфликты и их разрешение](https://www.youtube.com/watch?v=h4jxghOE9e0&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=37)
- Git merge не обнаруживает семантические конфликты.
- Примеры, исправление.

При семантической ошибке, можно выполнить
```bash 
git merge --no-commit
```
А далее уже решить конфликт, закоммитить изменения или `git merge --continue`

---
[7.5 Git – Слияние – Полезный приём: сохранение веток с флагом --no-ff](https://www.youtube.com/watch?v=AHjS9MWsNm0&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=38)
- Сохранение истории разработки веток при помощи запрета "перемотки".
- Важно для удобной отмены слияния, а также хорошей истории проекта.

Отменить перемотку по умолчанию можно с помощью конфига
```bash
git config merge.ff false
git config branch.master.mergeoptions '--no-ff'
```

---
[7.6 Git – Слияние – Создание коммита из ветки: merge --squash](https://www.youtube.com/watch?v=1v-dxpobjlY&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=39)
- Альтернативный способ слияния, когда из ветки делается один коммит (а ветку можно потом удалить).
- Удобен, если история разработки ветки и сама ветка не нужна.

---
[8.1 Git – Копирование коммитов – Копирование коммитов: cherry-pick](https://www.youtube.com/watch?v=TZJxBSfR0NE&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=40)
- Копирование одного или нескольких коммитов на другую ветку командой git cherry-pick.
- Копирование изменений в индекс, без создания нового коммита.

![alter text](https://kapitonov.tech/img/9b9b925ed48b756e8265.png)

Есть второй способ. Найти проблемное место, создать ветку, и потом уже по очереди сливать ветки. Так более надежднее, но может быть неудобно
![alter text](https://kapitonov.tech/img/5972bbf1d27a7356a20d.png)

Опции cherry-pick
```bash
git cherry-pick --abort
git cherry-pick --continue
git cherry-pick --quit
```

Так же можно скопировать изменения, но без коммита
```bash
git cherry-pick --no-commit
```

---
[9.1 Git – Перемещение коммитов – Перебазирование вместо слияния: rebase](https://www.youtube.com/watch?v=jxwPgfmutjs&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=41)
- Команда git rebase: перенос ветки поверх master.
- Подробное описание, как работает команда rebase.

В простом случае, можно сказать, что rebase, это последовательность уже знакомых операций.
- создание отделенного коммита
- копирование с помощью cherry-pick
- * как обычно могут возникать конфликты, которые надо решать, или пропускать, или заканчивать 
- перемещение HEAD на последний новый отделенный коммит
- перенос на тот же коммит текущей ветки

Надо быть внимательный при `git reset --hard` т.к. ветка все еще будет в состоянии отделенного коммита

---
[9.2 Git – Перемещение коммитов – Rebase и merge: сравнение подходов](https://www.youtube.com/watch?v=Z3Q2RaEUQO0&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=42)
- При разработке новой ветки для интеграции изменений с master можно использовать merge или rebase.
- Сравнение этих подходов.
- "Подводные камни" rebase.

Интересная особенность в данном примере в том, что master вливается в feature. Это требуется для того, чтобы использоваться последние наработки из master в новой ветке.
![alter text](https://kapitonov.tech/img/30349386d8085860f99d.png)

При `rebase` может случиться так, что скопируется пачка неправильный коммитов. Например, в одной из веток переименовали старую функцию и при `rebase` никакая ошибка не высветится. Потенциально это плохая ситуация, т.к. для разработчика не понятно откуда было копирование. Для безопасного `rebase` есть флаг `-x`. Он позволяет выполнять любую комманду при `rebase`, как правильно это автотесты
```bash
git rebase -x '...' <some_branch>
```
![alter text](https://kapitonov.tech/img/a433d352c61fbbe2b136.png)


---
[9.3 Git – Перемещение коммитов – Rebase с тестами, флаг -x](https://www.youtube.com/watch?v=dnT8YzpqEYA&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=43)
- Аккуратное перебазирование, с запуском автотестов на каждом коммите.

При обнаружении ошибки, сначала ее надо исправить, а потом обновить последний коммит и только после этого можно продолжать копирование `git rebase --continue`.

---
[9.4 Git – Перемещение коммитов – Перенос части ветки, rebase --onto](https://www.youtube.com/watch?v=t_sPfT8m0s8&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=44)
- Как rebase ищет коммиты для переноса?
- Перенос части ветки, флаг --onto.
- Альтернативный подход с cherry-pick.

Команда `git rebase --onto master feature` перенесет изменения на ***master*** начиная с момента ***feature***

![alter text](https://kapitonov.tech/img/51c8b165a84636edc355.png)

В средующем примере требуется перести последние 2 коммита с ветки ***master*** на ветку ***feature***.
![alter text](https://kapitonov.tech/img/99799a340c604a499017.png)

При использовании rebase перенесются не только коммиты, то и сама ветка ***master***. А указатель ***feature*** все еще нахотся в старом положении.
![alter text](https://kapitonov.tech/img/bbaef5991e7ef094d176.png)

Куда удобнее в данном случае сначала переключиться на ***feature***, скопировать нужные коммиты и потом перенести ***master*** на 2 коммита назад.
```bash
git checkout feature
git cherry-pick master~2..master
git branch -f master master~2
```
![alter text](https://kapitonov.tech/img/105fc1ee3e67b8115abf.png)


---
[9.5 Git – Перемещение коммитов – Перебазирование слияний, --rebase-merges](https://www.youtube.com/watch?v=P89rsHliIpM&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=45)
- Rebase по умолчанию пропускает коммиты слияния вместе с внесёнными в них изменениями.
- Пример перебазирования с сохранением слияний.

При `resabe` коммиты слияния пропускаются 

![alter text](https://kapitonov.tech/img/940dfb6345088bbefccb.png)

Результат команды `git rebase --rebase-merges master`.

![alter text](https://kapitonov.tech/img/6d7449968467a6d6d13b.png)

В данном примере коммиты из сторонней ветки не используются, в вместо их беруются копии коммитов слияния.


---
[9.6 Git – Перемещение коммитов – Интерактивное перебазирование, rebase -i](https://www.youtube.com/watch?v=4K9X1Aa1nvA&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=46)
- Интерактивное перебазирование позволяет привести историю ветки "в порядок" перед её публикацией.


---
[9.7 Git – Перемещение коммитов – Исправляем коммит посередине ветки: autosquash](https://www.youtube.com/watch?v=exYHemsk1V8&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=47)
Rebase позволяет в полуавтоматическом режиме создавать и применять "коммиты-заплатки", для исправления коммитов, которые были сделаны ранее в ветке.

Логика достаточно простая. Сначала коммит помечается с помощью ***Fixup!*** как заплатка, а при дальнейшем rebase будет объединен с оригианльным коммитом и получаетс своего рода исправление в середине ветки.


---
[10.1 Git – Отмена коммитов через revert – Обратные коммиты, revert](https://www.youtube.com/watch?v=FcwQrN9XOwU&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=48)
- Отмена коммита, который нельзя удалить из истории, так как он был отправлен другим людям.
- Создание обратного коммита командой git revert.

`git revert` сравнивает diff коммита или диапазон коммитов с родительским коммитом и применяет противоположные это изменения.

Пример для команды `git revert A..B`
![alter text](https://kapitonov.tech/img/0aad89b901557d71fbd9.png)


---
[10.2 Git – Отмена коммитов через revert – Отмена слияния через revert](https://www.youtube.com/watch?v=aRbOsagYs8w&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=49)
- Отмена слияния, которое было отправлено другим людям.
- Особенности работы git revert с коммитами слияния.

Данные примере рассматриваются при коммандной разработке. Когда изменения были выполнены и отправленны другим разработчикам. В таком случае нельзя отменить изменения с помощью `git reset --hard @~`
`revert` не может отменить коммит слияния
![alter text](https://kapitonov.tech/img/1c1a9dfb69ff97eb1791.png)

Если смотреть коммит с точки зрения изменения их родителей, то становится понятно что эти изменения как правило разные, поэтому надо указывать родителей при команде `revert`.
Отменить изменения относительно первого родителя
```bash
git revert <some_commit> -m 1
```

Работа над ***master*** и ***feature*** продолжается и при попытке `git merge feature` произойдет проблема. Т.к. гит сначала находит последние общие коммиты, и уже потом добавляет новые изменения. В данном случае это не сработает, т.к. предыдущие общие коммиты были отменены и получается, что будут потеряны.

![alter text](https://kapitonov.tech/img/7af414e0763021647c28.png)
![alter text](https://kapitonov.tech/img/87f263a5e057371f5303.png)

Для того, чтобы эти изменения не терялись, их нужно скопировать:
- cherry-pick
- отменить отмену
Что происходит при отмене отмены? Сначала изменения копируются с помощью ***merge***, т.к. между коммитом отмены и коммитом слияния могут быть другие коммиты, при коммите отмены возникают которые будут решены. И как раз получается, что при отмене отмены этот конфликт тоже будет учтен и скопирован.

> Если упростить, отмена отмены это старый merge с всеми решенными конфликтами (не точно)_

![alter text](https://kapitonov.tech/img/7026edbed411f9ab0a32.png)


---
[10.3 Git – Отмена коммитов через revert – Повторное слияние с rebase](https://www.youtube.com/watch?v=3HDSLArx3qw&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=50)
Альтернативные способы повторного слияния, не требующие отмены отмены:
- С rebase ветки поверх master.
- С rebase ветки на том же месте.

Дополнительный способ решения без отмены отмены.
```bash
git rebase --onto master 54a4 feature
```
![alter text](https://kapitonov.tech/img/4899245cf02a0c932b2a.png)

В данном примере может появится конфликт, который уже решался. Для таких случае есть механизм rerere. Для его использования его сначала необходимо активировать, потом обучить на предыдущих конфликтах

```bash
git rebase --onto master 54a4 feature
git merge --no-ff --no-edit feature
```
![alter text](https://kapitonov.tech/img/11d3d51bf3ff96cd0482.png)

Для удаления связи между ***2с11*** и ***38е8*** у гита нет специального механизма, но через `rebase` можно скопировать нужные нам коммиты
```bash
git checkout feature
git rebase 54a4 --no-ff
```
![alter text](https://kapitonov.tech/img/d1df9b8abd7de5e54233.png)
