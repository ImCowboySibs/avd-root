# avd-root
Root Android AVDs with SuperSU

## Usage:

List all AVDs:
```
$SDK_PATH/emulator/emulator -list-avds
```
Start AVD with `-writable-system`, `-selinux disabled` and `-no-snapshot`:
```
$SDK_PATH/emulator/emulator -avd YourAVDHere -no-snapshot -writable-system -selinux disabled
```
After AVD Boots:
```
./avd-root.sh
```

Once the device is rooted, open SuperSU. It'll prompt you to update the `su` binary, press "CONTINUE" then "NORMAL". When the update is complete, hit "OK".

**DO NOT REBOOT**

## Persistence:

This is a system root, meaning we are modifying the `/system` parition. This requires using the `-writable-system` flag, even after changes have been made. Not using this flag will load the default system image. 

If the `su` daemon is not being started on boot, you can always start it manually with `su --daemon &`.

## Disclaimer:

This will only work for system images that are using API 7+
