add-content -path c:/users/lohit/.ssh/config @'
Host ${hostname}
  HostName ${hostname}
  User ${user}
  identityfile ${identityfile}
'@