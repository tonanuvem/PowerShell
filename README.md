PowerShell
==========

PowerShell Scripts:

Desabilitar cache no WebClient

> webClient.CachePolicy = new System.Net.Cache.RequestCachePolicy(System.Net.Cache.RequestCacheLevel.NoCacheNoStore);

Uso:

> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString(' https://tonanuvem.github.io/PowerShell/Invoke-CPUStressTest.ps1'))
