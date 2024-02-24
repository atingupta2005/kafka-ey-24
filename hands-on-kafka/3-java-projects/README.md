```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

```
choco install intellijidea-community -y
choco install oraclejdk -y
choco install git -y
```

```
git clone https://github.com/atingupta2005/kafka-ey-24
```

```
exit
```
