## ExecutionPolicy :
`To set ExecutionPolicy`
```
Set-ExecutionPolicy -ExecutionPolicy <type> -Scope <user>
```
- `Type` :
>- RemoteSigned : Downloaded scripts must be signed by a trusted publisher before they can be run.
>- Unrestricted : No restrictions; all Windows PowerShell scripts can be run.
>- Restricted : No scripts can be run. Windows PowerShell can be used only in interactive mode.

- `User` :
>- CurrentUser : The execution policy affects only the current user.
>- LocalMachine : The execution policy affects all users of the computer.
>- Process : Sets the execution policy for the current Windows PowerShell process. The execution policy is saved in the $env:PSExecutionPolicyPreference environment variable.
>- MachinePolicy : Sets the execution policy for all users of the computer. The execution policy is saved in the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell registry entry.
>- UserPolicy : Sets the execution policy for all users of the computer. The execution policy is saved in the HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell registry entry.

`To check ExecutionPolicy` :
```
Get-ExecutionPolicy -List
```

