`git cat-file -s <hash>` - узнать размер _blob_ файла в байтах

Изначально Git сохраняет объекты на диске в так называемом свободном(_loose_) формате. Но время от времени такие объекты упаковываются в один бинарный файл для экономии места на диске и повышения эффетивности. Это происходит автоматически, когда файлов в свободном формате становится слишком много. Можно вручную вызвать комадну _git gc_ или отправить данные на удаленный сервер
При упаковке объектов система ищет файлы с похожими именами и примерно одного размера, после чего сохраняет только разницу между версиями. Для просмотра содержимого упакованного файла существует служебная команда _git verify-pack_

`git gc` - упаковывает _blob_ файалы
`git verify-pack` - просмотр содержимого упакованного файла

#### Пример:

`curl https://raw.githubusercontent.com/mojombo/grit/master/lib/grit/repo.rb > repo.rb` - добавляем тестовый файл _grit_, размером 22Кбайта
`git add repo.rb`
`git commit -m 'added repo.rb'`

`git cat-file -p master^{tree}` - проверяем текущее дерево файлов
_100644 blob fa49b... new.txt_
_100644 blob 033b4... repo.rb_
_100644 blob e3f09... test.txt_

`git cat-file -s 033b4` - проверяем размер файла _repo.rb_
_22044_

Изменим файл _repo.rb_
`echo '# testing' >> repo.rb`
`git commit -am 'modified repo a bit'`

`git cat-file -p master^{tree}` проверим измение коммита для файла _repo.rb_
_100644 blob fa49b new.txt_
_100644 blob b042a repo.rb_
_100644 blob e3f09 test.txt_

`git cat-file -s bo42a...` - посмотрим размер объектного файла
_20052_

`git gc` - вручную упакуем файлы
`git gc --auto` для автоматическаго выполнения
`find .git/objects -type f` - проверим количество объектных файлов
_.git/objects/bd/9dbf4a..._
_.git/objects/d6/70460..._
_.git/objects/info/packs_
_.git/objects/pack/pack-978e0 ... .idx_
_.git/objects/pack/pack-978e0 ... .pack_

`git verify-pack -v .git/objects/pack/pack-978e039 ... .idx` - отобразим содержимое упакованного файла
_2431d commit 223 155 12_
_69bcd commit 214 152 167_
_d318d tag 130 122 874_
_fe879 tree 136 136 996_
_deef2 tree 136 136 1178_
_d98ac tree 6 17 1314 1 \ deef2_
_..._
_b942a blob 22054 5799 1463_
_033b4 blob 9 20 7262 1 \ b942a_

В данном случае двоичный массив данных _933b4_ который представляет собой первую версию файла _repo.rb_, ссылается на двоичный массив данных _b042a_, являющийся второй версией этого файла. Третий столбец в списке вывода содержит размер объекта в упакованном виде. Если _b042a_ занимает 22KB, то _033b4_ всего 9B, Примечательно что вторая весия сохраняется в исходном виде, в то время как от оригинала остаются только данные о внесенных изменениях. Это делается помтому, что чаще всего требуется доступ к последней версии файла.

...
...