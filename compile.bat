@echo off

rem PdlFile
set HASKELL_FILE=pdl.hs

rem PDL
set EXECUTABLE=seu_executavel

rem Compilação do arquivo Haskell
ghc -o %EXECUTABLE% %HASKELL_FILE%

rem Remoção dos arquivos intermediários
del %HASKELL_FILE:.hs=.hi%
del %HASKELL_FILE:.hs=.o%

rem Execução do programa
%EXECUTABLE%
