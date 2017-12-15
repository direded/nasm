# Реализация простых программ на NASM

## Требования

* Инструменты `nasm` и `gcc` последних версий
* Прямые руки
* Везение

## Сборка

### Для 32-разрядных программ

```
$ ./make_32.sh filename
```

### Для 64-разрядных программ

```
$ ./make_64.sh filename
```

### Запуск
После сборки вы получите main.lst и выполняемый main. Для запуска main не забудьте дать соответствующие разрешения
```
# chmod a+x main
```

## Описание программ

| Файл        | Описание           | Входные данные  |
| ------------- |:-------------:| :-----: |
| __1_1.asm__      | перевод десятичного натурального числа в число с данным основанием | long long int, int |
| __misc.asm__      | полезные макросы и функции     |   |
