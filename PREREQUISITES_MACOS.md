# Dev Container: Prerequisites (macOS)

For dev containers to work correctly, some host configuration changes may be necessary

- [SSH Agent](#ssh-agent)
- [GPG Agent](#gpg-agent)

***All instructions in this document are for macOS!***

## SSH Agent

This is used for SSH with public key auth, including Git (over SSH). You must have an SSH private key (eg. `$HOME/.ssh/id_ed25519`)

1. Make sure the `AllowAgentForwarding` option is _not_ set to `no` in your [`/etc/ssh/sshd_agent`](/etc/ssh/sshd_agent) config file. The default value is `yes`, so it should be enough that the option is not set. It can also be explicitly set to `yes`.
   - Restart the computer if you change this option.
2. Run `ssh-add --apple-use-keychain` to add your SSH private key as an SSH agent identity stored in the Apple keychain.
3. Add `ssh-add --apple-load-keychain &>/dev/null` to your `$HOME/.zprofile` script to preload SSH keys from the apple keychain.
   - Using SSH outside the dev container causes keys to be loaded from the keychain on demand. Unfortunately, using SSH inside the dev container does not do so, which is why the preload fix is necessary.

If you added your public key to Github for SSH auth, then you can test your credentials by running `ssh -T git@github.com`. If it works on the host, but not in the dev container, then SSH agent forwarding is not working correctly. The `ssh-add -L` command should also list the same identities when run on the host and in the dev container.

Dev container SSH agent forwarding is a little finicky. If you're pretty sure it's setup correctly, but it's still not working, try restarting the computer.

## GPG Agent

Only necessary if the host has GnuPG (gpg) installed. You can check by running the `which gpg` command. If the command is not found, then you can skip the following steps.

1. Run `gpg -k &>/dev/null` once. This will create the `$HOME/.gnupg/S.keyboxd` socket which will prevent errors when using gpg to verify signatures (eg. during Mise install).
2. Add `gpg -k &>/dev/null` to your `$HOME/.zprofile` script to make sure the `keyboxd` socket is always created on login.
