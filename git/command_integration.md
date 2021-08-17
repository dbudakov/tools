Для приема коммитов создаются ветки на master'a куда заливаются изменения, \
Например `sc/ruby_client`, где _`sc`_ - инициалы разработчика, а _`ruby\_сlient`_ - алиас его задачи

#### Получение коммита по email

`git apply /tmp/patch-ruby-client.patch`
`git am`

### Просмотр вносимых изменений

Убрать из списка коммиты, которые уже есть в ветке _master_
`git log contrib --not master`

Посмотреть к каким изменениям приведет коммит
`git log -p`

Просмотр разницы между последним коммитом ветки, в которой вы находитесь и ее общим предком с другой ветко
Выводит только те нароботки тематической ветки, которые появились там, после разхождения с веткой _master_
`git diff master...contrib`

Менее удобный способ:
`git merge-base contrib master`
`git diff (hash_commit)`

###

`git cherry-pick e43a6` - помещает коммит в свою ветку, извлекает изменения появившиеся в коммите, checksum изменится из-за смены даты