# Changelog

All notable changes to this project will be documented in this file.

## Release 0.1.2

**Features**
- Include new sleeptime option, allow user to specify how long to wait for JunOS to apply configurations

**Bugfixes**
- [#7](https://github.com/benjamin-robertson/juniper_config/issues/7) If commit check fails, bolt still reports as successful 
- [#8](https://github.com/benjamin-robertson/juniper_config/issues/8) If commit check fails, temporary config file isn't deleted.
- [#9](https://github.com/benjamin-robertson/juniper_config/issues/9) Task is not aware if configuration database is locked

**Known Issues**
- [#10](https://github.com/benjamin-robertson/juniper_config/issues/10) When --noop is used and configuration is invalid. Bolt still report the node as successful

## Release 0.1.1

**Features**

**Bugfixes**
- Documentation update for Puppet forge

**Known Issues**

## Release 0.1.0

**Features**

**Bugfixes**

**Known Issues**
