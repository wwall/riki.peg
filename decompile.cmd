@chcp 65001

@call vrunner decompileepf ./build/rikiPEG.epf  ./src/epf
@call vrunner decompileepf ./build/example.epf  ./src/epf
@call vrunner decompileepf ./build/console.epf  ./src/epf

@call vrunner decompileepf ./build/tests/testRikiPeg.epf  ./tests/epf

