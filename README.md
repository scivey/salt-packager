# salt-packager

Packages up salt roots and some extra scripts into a tarball. Salt does something like this already, but mine is better.

The resulting tarball can be used to run `state.highstate` on any host with python and virtualenv installed.

## Advantages
* Runs salt from a virtualenv (which it also sets up for you).
* Doesn't touch any of the system-wide salt dirs (`/var/cache/salt`, `/etc/salt`, `/srv/salt`...).
* Normally, the first run of your state wouldn't have access to custom modules / utils / etc.  This script makes sure everything is synced by the time your state runs. (It runs a separate dummy state first.)
* Salt doesn't need to be installed system-wide.
* If Salt *is* installed system-wide, running your packaged state won't interfere with that installation.

## Usage

### packaging

```shell
$SALT_PACKAGER_DIR/bin/build-salt-package -o ./build $ROOTS_DIR
```

The package goes to `./build/salt-package.tar.gz`.

`$ROOTS_DIR` is a directory containing your top-level `salt` and `pillar` dirs. Something like this:
```
roots
roots/salt
roots/salt/base
roots/salt/base/some_state.sls
roots/salt/base/top.sls
roots/pillar
roots/pillar/base
roots/pillar/base/some_pillar_data.sls
roots/pillar/base/top.sls
```

### Deploying
Copy `salt-package.tar.gz` anywhere and then run:

```shell
tar -xaf salt-package.tar.gz
sudo ./bin/provision
```

