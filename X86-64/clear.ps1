Remove-Item bin -Force -Recurse;
New-Item -ItemType Directory -Force -Path "bin";
New-Item -ItemType Directory -Force -Path "bin/obj";
New-Item -ItemType Directory -Force -Path "bin/elf";