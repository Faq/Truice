reg query "HKCU\Software\Truice"
if not ErrorLevel 1 (
  reg delete "HKCU\Software\Truice"
)