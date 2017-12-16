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
После сборки вы получите main.lst и исполняемый main. Для запуска main не забудьте дать соответствующие разрешения
```
# chmod a+x main
```

## Описание программ

| Файл        | Описание           |
| ------------- |:-------------:|
| __1_1.asm__      | перевод десятичного натурального числа в число с данным основанием |
| __1_2.asm__      | реализация расширенного алгоритма Евклида |
| __1_3.asm__      | факторизация натурального числа, используя алгоритм перебора делителей |
| __quicksort.asm__      | быстрая сортировка |
| __3_1.asm__      | нахождение экспоненты через разложения функции exp(x) в ряд Тейлора |
| __misc.asm__      | полезные макросы и функции |

