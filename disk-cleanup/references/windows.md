# Disk cleanup on Windows

## Measure

`Get-ChildItem -Recurse` is slow and follows junctions. `robocopy` in list mode is fast and skips junctions with `/XJ`:

```powershell
robocopy "<folder>" NULL /L /S /NJH /BYTES /NC /NDL /NFL /XJ /R:0 /W:0
```

Read the `Bytes :` line of the summary. It still counts each hard link at full size. To see whether a file is hard-linked, run `fsutil hardlink list "<file>"`; a file in a package store with several entries is shared.

Some system folders need an administrator shell to measure. Without one, `robocopy` prints no `Bytes` line for them.

## Delete

- Before deleting a folder, list its links: `Get-ChildItem -LiteralPath "<folder>" -Recurse -Force -Attributes ReparsePoint` and check each `Target`.
- Delete with `rmdir /s /q`, which removes a junction without following it. From PowerShell: ``cmd /c "rmdir /s /q `"<folder>`""``.
- From Git Bash, `cmd //c "rmdir /s /q \"<folder>\""` fails on quoting with "The filename, directory name, or volume label syntax is incorrect". Call it from PowerShell instead. Avoid `rm -rf` on folders that hold junctions, since it can reach through them into the target.
- A file that a running program has open is skipped, and its folder stays. That is expected; report it.

## Usual large items

Safe once the checks in the skill pass:

| Location | What it is |
| --- | --- |
| `%TEMP%\wsl-crashes` | A full dump for each Linux process that crashed under WSL. One Node crash can write about 3 GB. |
| `%TEMP%\<random name>` | Installer extraction folders. Check first that no installer (`msiexec`, `setup`, Visual Studio Installer, WinGet) is running. |
| `%TEMP%\DiagOutputDir` | Remote Desktop client traces. The current trace file is locked and stays. |
| `%LOCALAPPDATA%\Microsoft\PowerToys\Updates` | Every PowerToys installer it ever downloaded. |

The user's call:

| Location | What it is |
| --- | --- |
| `%LOCALAPPDATA%\Docker\wsl\disk\docker_data.vhdx` | Docker Desktop's disk image. See below. |
| `C:\Program Files (x86)\Steam\steamapps\common` | Installed games. Uninstall through Steam. |
| `%LOCALAPPDATA%\Google\Chrome\User Data\OptGuideOnDeviceModel` | Chrome's on-device AI model. Chrome downloads it again unless the feature is turned off. |
| `%LOCALAPPDATA%\Packages\<app>` | Store app data, such as a music app's offline cache or a video editor's projects. Clear or uninstall it from the app itself. |
| `C:\hiberfil.sys` | The hibernation file. `powercfg /h off` in an administrator shell removes it, and hibernation with it. |
| `C:\ProgramData\NVIDIA Corporation\Downloader` | Old graphics driver installers. |

Leave `C:\Windows\Installer`, `C:\Windows\WinSxS` and `pagefile.sys` alone. Use Storage Sense or Disk Cleanup for system files.

## Docker Desktop's disk image

`docker system df` shows what is inside the image file and how much is reclaimable. Pruning frees space inside the file only. Running `fstrim` inside the Docker VM does not shrink it either.

Prune in the foreground. A `docker` command inside a PowerShell `Start-Job` dies when the shell that started it exits, so a long `docker volume prune` stops partway. Unused anonymous volumes and old build cache are often most of the reclaimable space: on one laptop they held 39 GB while the images held 20 GB.

To shrink the file, wait until no session needs containers, then:

1. Quit Docker Desktop from its tray icon, or run `docker desktop stop` (`docker desktop start` brings it back).
2. Run `wsl --shutdown`.
3. In an administrator shell, run `diskpart` and enter:

   ```text
   select vdisk file="%LOCALAPPDATA%\Docker\wsl\disk\docker_data.vhdx"
   attach vdisk readonly
   compact vdisk
   detach vdisk
   exit
   ```

   `diskpart` does not expand `%LOCALAPPDATA%`, so type the full path. `Optimize-VHD` needs the Hyper-V module, which Windows Home does not have.

   An agent can save those lines to a script file and run `Start-Process powershell -Verb RunAs -Wait -ArgumentList "-NoProfile -Command diskpart /s <script> *> <log>"`. The user then clicks Yes on the Windows admin prompt, and the log shows the result.

4. Start Docker Desktop again.
