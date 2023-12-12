cat << EOF >> -path ~/.ssh/config
Host ${hostname}
  HostName ${hostname}
  User ${user}
  identityfile ${identityfile}
EOF

