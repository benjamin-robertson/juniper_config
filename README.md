# juniper_config

A bolt task which allows you to update Juniper devices with configurations snippets.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with juniper_config](#setup)
    * [What juniper_config affects](#what-juniper_config-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with juniper_config](#beginning-with-juniper_config)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

A bolt task which allows you to update Juniper devices with configurations snippets.

## Setup

### Setup Requirements

### This has only been tested on enterprise linux 7!!!!!!!!!!!!!!!!

1. Requires bolt to be intalled see: https://puppet.com/docs/bolt/latest/bolt_installing.html#install-bolt-on-rhel-sles-or-fedora
2. Clone git repo locally, 'git clone https://github.com/benjamin-robertson/juniper_config.git'
3. Change directory into juniper_config. 
4. Run 'bolt project init' within that directory
5. Run 'bolt project show' within that directory, you should see "juniper_config::config_apply   Check and compare Junper config differences" listed

Note: unless the task is installed in your bolt module path, you will need to run bolt task from the juniper_config project directory

### Beginning with juniper_config

Note: --transport=remote must always be set when using this task.

A basic config apply test

bolt task run juniper_config::config_apply --targets hostname --transport=remote config=/path/to/config user=bolt apply_mode=merge --noop

## Usage

-- User with password to merge a configuration file --

bolt task run juniper_config::config_apply --targets hostname --transport=remote config=/path/to/config user=bolt password=hello apply_mode=merge

-- Applying to multiple devices in set mode --

bolt task run juniper_config::config_apply --targets hostname,hostname2,hostname3 --transport=remote config=/path/to/config user=bolt password=hello apply_mode=set

-- Applying to device with specified ssh key --

bolt task run juniper_config::config_apply --targets hostname,hostname2,hostname3 --transport=remote config=/path/to/config user=bolt ssh_key=/path/to/ssh/key apply_mode=set

## Reference

Parameters accepted

1. config     : String Minlength 1
2. user       : String Minlength 1
- apply_mode : String["set,"merge","override","replace"]
- password   : Optional String
- ssh_key    : Optional String

For apply_mode see https://www.juniper.net/documentation/en_US/junos/topics/topic-map/junos-config-files-loading.html

If no password or ssh_key is set, standard user ssh key will be used.

Supports noop, will report on changes to be made if --noop is used. 

## Limitations

Only tested on Enterprise Linux 7

