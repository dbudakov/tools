## Gobbling, обработка всего файла, реверс файла

```sh
echo 'e9
e2
e3
e4
e8
e6
e7
e1
e5' > employees.txt
```

, забирает первую строку на удержание, далее обрабатывает каждую строку со 2 по последнюю, берет строку и добавляет к ней удержание и обновляет область удержания(буфер), получается
2+1 	> buff,
3+2+1	> buff,
4+3+2+1	> buff;
В вывод идет только последняя строка, иначе будет в вывод попадают все шаги обновления буфера

```sh
sed -n -e '1 {h;};2,$ {G;h;};$p;' employees.txt
sed -n -f reverse.sed employees.txt

# h; - удерживает первую строку
# G; - берет строку и добавляет удержание(буфер)
# h; - обновляет удержание уже с двумя строками
# $p; - вывод только результирующей склейки
```

*источник:* _5. Gobbling_  <https://www.baeldung.com/linux/sed-replace-multi-line-string#3-editing-in-action>