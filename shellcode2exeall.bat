@echo off

setlocal enabledelayedexpansion

set ARCH=64

for %%f in (*.bin) do (
  set OUTPUT=%%~nf.exe
  echo Global Start > shellcode.asm
  echo SECTION 'foo' write, execute,read >> shellcode.asm
  echo Start: >> shellcode.asm
  echo incbin "%%~f" >> shellcode.asm
  yasm.exe -f win%ARCH% -o shellcode.obj shellcode.asm
  golink /ni /fo !OUTPUT! /entry Start shellcode.obj
  del shellcode.asm
  del shellcode.obj
  echo Converted %%~f to !OUTPUT!
)

echo All shellcode files converted to executables.

pause
