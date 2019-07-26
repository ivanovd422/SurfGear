# Сборка/выгрузка проекта

## Сборка

Для сборки артефактов предусмотрены скрипты из директории /script
Их выполнение происходит на Jenkins при Pr и Tag джобах.
Также возможно ручное выполнение скриптов из консоли.

- ./script/android/build.sh - сборка qa/release (x64)
- ./script/ios/build.sh - ios сборка 

**ВАЖНО**: Все команды выполняютсмя из корня **проекта**(там где находится pubspec.yaml приложения)

**ВАЖНО**: Перед IOs сборкой необходимо 

* Скачать сертификаты с Apple Account и Provisioning Profile и положить их в папку `./ios/certs`
* Заполнить todo в скрипте `./ios/scripts/init_certs.sh`

* Выполнить следующие команды:

```
cd ios/ && make init
```

В случае непонятных ошибок(актуально для iOS сборок):

1. Закройте Xcode
1. Отключите девайсы
1. Очистите проект:
```
flutter clean
cd ios/
rm -rf .symlinks/
xcodebuild clean
```

1. Проделайте заново все шаги по сборке проекта


## Выгрузка артефактов 

Для распространения артефактов мы используем **Beta by Fabric**.
Чтобы выгрузить сборки в данный сервис используется fastlane.

Основне команды:

```
cd android/; fastlane android beta //android сборка

cd ios/; make beta //ios сборка
```

**ВАЖНО**: При локальной выгрузке перед нейследует выполнить сборку проекта одним из описанных 
выше билдскриптов. 