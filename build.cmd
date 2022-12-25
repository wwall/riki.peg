@chcp 65001

@rem Загружаем базу заглушку
@call vrunner init-dev --dt ./tools/clear.dt

@rem собрать внешние обработчики и отчеты в каталоге build
@call vrunner compileepf src/epf/rikiPEG build %*
@call vrunner compileepf src/erf/tests/testRikiPeg build/test %*
