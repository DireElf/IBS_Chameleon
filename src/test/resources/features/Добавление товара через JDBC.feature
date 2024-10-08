# language: ru

# Тестовые данные:
  # $Наименование Ананас
  # $Тип Фрукт
  # $Экзотический 1

@JDBC
Функция: Добавление товара через JDBC

  Сценарий:
    * к БД выполнено подключение "H2" с параметрами:
      | field        | value                                   |
      | Адрес        | jdbc:h2:tcp://localhost:9092/mem:testdb |
      | Пользователь | user                                    |
      | Пароль       | pass                                    |
    * из БД выбирается строка запросом "Получение количества записей"
    * в переменной "Количество записей" сохранено значение поля "Счетчик записей"
    * к БД выполняется запрос "Добавление товара" c параметрами:
      | field        | value           |
      | Имя          | #{Наименование} |
      | Тип          | #{Тип}          |
      | Экзотический | #{Экзотический} |
    * из БД выбирается строка запросом "Получение количества записей"
    * в переменной "Новое количество записей" сохранено значение поля "Счетчик записей"
    * значения выражений:
      | expression                  | operator | value                            |
      | #{Новое количество записей} | равно    | #math{#{Количество записей} + 1} |
    * из БД выбирается строка запросом "Получение последней записи"
    * в переменной "Идентификатор последней записи" сохранено значение поля "Идентификатор"
    * значения полей:
      | field        | operator | value           |
      | Имя          | равно    | #{Наименование} |
      | Тип          | равно    | #{Тип}          |
      | Экзотический | равно    | #{Экзотический} |
    * к БД выполняется запрос "Удаление товара по идентификатору" c параметрами:
      | field         | value                             |
      | Идентификатор | #{Идентификатор последней записи} |
    * закрыто подключение к БД