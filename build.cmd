@chcp 65001


@call del /Q /S build
@call rmdir /Q /S build

@rem Загружаем базу заглушку
@call vrunner init-dev --dt ./fixtures/clear.dt

@rem собрать внешние обработчики и отчеты в каталоге build
@call vrunner compileepf src/epf build/epf %*
@call vrunner compileepf tests/epf build/tests %*
