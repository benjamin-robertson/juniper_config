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

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most basic
use of the module.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as
Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your
module. For details on how to add code comments and generate documentation with
Strings, see the [Puppet Strings documentation][2] and [style guide][3].

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the
root of your module directory and list out each of your module's classes,
defined types, facts, functions, Puppet tasks, task plans, and resource types
and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

* The data type, if applicable.
* A description of what the element does.
* Valid values, if the data type doesn't make it obvious.
* Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

Only tested on Enterprise Linux 7

