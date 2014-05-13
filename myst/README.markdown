#MyST Puppet Module

####Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Reference](#reference)

##Overview

The `myst` module for Puppet installs, configures and runs MyST.

MyST provides an automated process for the installation, configuration, patching and deployment of Oracle Fusion Middleware and Applications.
The automated installation is driven by simple models (or metadata), which defines the environment specific properties, which are captured during the initial platform design.
MyST provides a number of key capabilities, including:

Ability to define Fusion Middleware environment templates, from which we can provision new environments on demand.
Easily automates the build and deployment of FMW solutions, and configurations into development, test, and production environments. 

* Oracle products supported by MyST, include:
* Oracle Weblogic Server
* Oracle Service Bus (OSB)
* Oracle Business Process Manager (BPM)
* Oracle Business Activity Monitoring (BAM)
* Oracle Identity and Access Management 
* Oracle Unified Directory (OUD)
* Oracle Policy Automation (OPA)
* Oracle OAM Webgate
* Oracle Enterprise Manager (OEM)
* Oracle HTTP Server (OHS)
* Oracle AIA Foundation Pack
* Oracle Data Integrator (ODI)
* Oracle Webcenter and Content

For more information, visit http://rubiconred.com/myst

##Prerequisites

MyST requires Java to be installed on all agents where MyST is to be run.

Before using the plugin, you must copy the MyST binary into the standard files directory of the myst puppet module.

##Usage

All interaction with the MyST module can be done through the main `myst` class. This means you can simply toggle the options in `myst` to have full functionality of the module.

###I just want MyST agent installed, what's the minimum I need?

```puppet
include myst
```

###I want MyST agent installed with the MyST Web & Jenkins consoles

```puppet
class { 'myst':
    myst_web_enable => true,
    myst_jenkins_enable => true,
}
```

###I want to run an existing MyST configuration to provision my environment.

```puppet
class { 'myst':
    myst_action => 'provision',
    myst_config => 'env.dev.soa.platform'
}
```

###I want to build a simple WebLogic environment with my definition entirely in the Puppet manifest

```puppet
class { 'myst:
    myst_action => "provision",
    myst_properties => {
        'core.fmw.home' => "/u01/app/oracle/product/fmw",
        'core.fmw.domain-home' => "/u01/app/oracle/product/fmw/user_projects/domains/MySimpleDomain",
        'core.fmw.admin.username' => "weblogic",
        'core.fmw.admin.password' => "{AES}YMW8mvz1MjvVoqSeCHw3Yw==",
        'core.domain.name' => "MySimpleDomain",
        'core.domain.server[AdminServer].name' => "AdminServer",
        'core.domain.server[AdminServer].listen-address' => $hostname,
        'core.domain.server[AdminServer].listen-port' => "7001", 
        'core.domain.server[AdminServer].is-admin-server' => "true",  
        'core.product[java].home' => "/u01/app/oracle/product/fmw/jdk",
        'core.product[weblogic].home' => "/u01/app/oracle/product/fmw/wlserver_10.3", 
    }
}
```

##Reference

###Classes

####Public Classes

* ntp: Main class, includes all other classes.

####Private Classes

* myst::install: Handles the installation of MyST
* myst::config: Handles the configuration of MyST
* myst::run: Runs MyST

###Parameters

The following parameters are available in the `myst` module:

####`myst_config`

The identifer for the MyST platform configuration definition (aka model) to be used in MyST execution.
Defaults to ''

####`myst_action`

The identifer for the MyST action to perform (e.g. provision) as part of the MyST execution.
Defaults to 'version' (i.e. displays the MyST version)

####`myst_properties`

The properties to pass through to the MyST execution.
Defaults to {}

####`myst_home`

The home directory to install MyST to.
Defaults to:
* '/u01/app/oracle/admin/myst' on Linux
* '/Applications/myst' on Mac
* 'C:/RubiconRed/MyST' on Windows

####`myst_workspace_home`

The home directory where the MyST workspace can be found.
This includes the conf directory with all the MyST platform definitions.
Defaults to:
* '/u01/app/oracle/admin/myst/lib' on Linux
* '/Applications/myst/lib' on Mac
* 'C:/RubiconRed/MyST/lib' on Windows

####`myst_web_enable`

Whether to install the MyST web console.
Defaults to false

####`myst_jenkins_enable`

Whether to install Jenkins CI for MyST.
Defaults to false

####`environment_enable`

Whether to setup the required environment variables for MyST.
This is only required for executing MyST outside of Puppet.
Defaults to false

####`package_ensure`

Valid options are:
 'installed' - installs MyST
 'absent' - uninstalls MyST
Defaults to installed.

####`myst_version`

The version of MyST which needs to be installed.
Defaults to the latest version.

####`myst_installer`

The location of the MyST installer file.
Defaults to the installer under the module files directory which matches the myst_version specified.