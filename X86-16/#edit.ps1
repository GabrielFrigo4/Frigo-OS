if ($IsWindows) {
    Start-Process -FilePath "wsl" -WorkingDirectory "." -ArgumentList "code ." -WindowStyle Hidden;
}
elseif ($IsLinux) {
    Start-Process -FilePath "code" -WorkingDirectory ".";
}