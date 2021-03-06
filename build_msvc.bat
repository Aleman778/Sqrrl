@echo off

rem MSVC Build
call vcvarsall.bat x64

IF NOT EXIST build mkdir build
pushd build

rem Common Compiler Flags
set compiler_flags=-nologo -Gm- -GR- -Zo -EHa -Oi -FC -Zi -GS- -Gs9999999
set compiler_flags=-WX -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 %compiler_flags%

rem Common Linker Flags
set linker_flags=-incremental:no -opt:ref -OUT:sqrrl.exe

rem Build Specific Flags
if ["%~1"]==["release"] (    
    rem Release Compiler Flags
    rem set compiler_flags=-O2 -DNDEBUG=1 %compiler_flags%
) else (
    rem Debug Compiler Flags
    set compiler_flags=-Od -DDEBUG=1 -DBUILD_DEBUG=1
    set compiler_flags= -DBUILD_INTERNAL=1 -DBUILD_MAX_DEBUG=1 %compiler_flags%

    rem Debug linker flags
    set linker_flags=dbghelp.lib %linker_flags%
)

rem Compile
cl %compiler_flags% ../code/windows_sqrrl.cpp -link %linker_flags%

popd