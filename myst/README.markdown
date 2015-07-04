#MyST Puppet Module

####Table of Contents

1. [Overview](#overview)
2. [New Features](#newfeatures)
3. [Prerequisites](#prerequisites)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Release Notes](#releasenotes)

##Overview

The `myst` module for Puppet installs, configures and runs MyST.

MyST provides an automated process for the installation, configuration, patching and deployment of Oracle Fusion Middleware and Applications.
The automated installation is driven by simple models (or metadata), which defines the environment specific properties, which are captured during the initial platform design.
MyST provides a number of key capabilities, including:
* Ability to define Fusion Middleware environment templates, from which we can provision new environments on demand.
* Easily automates the build and deployment of FMW solutions, and configurations into development, test, and production environments. 

Products supported by MyST, include:
* Oracle JRockit
* Oracle Java Development Kit (JDK)
* Oracle Weblogic Server
* Oracle Service Bus (OSB)
* Oracle Service Oriented Architecture Suite (SOA) 
* Oracle Business Process Manager (BPM)
* Oracle Business Activity Monitoring (BAM)
* Oracle Managed File Transfer (MTF)
* Oracle Enterprise Scheduler Services (ESS)
* Oracle API Gateway (OAG)
* Oracle Identity and Access Management (OAM)
* Oracle Adaptive Access Management (OAAM)
* Oracle Unified Directory (OUD)
* Oracle Policy Automation (OPA)
* Oracle OAM Webgate
* Oracle Enterprise Manager (OEM) Cloud Control
* Oracle Webtier - including HTTP Server (OHS)
* Oracle Application Integration Architecture (AIA) Foundation Pack
* Oracle Application Integration Architecture (AIA) Process Integration Packs
* Oracle Data Integrator (ODI)
* Oracle Webcenter Portal (WCP) and Content (WCC/UCM)
* Oracle Siebel
* Oracle WebLogic extensions for Exalogic
* Rubicon Red Scheduler

For a full list of supported operating systems and products, visit http://www.rubiconred.com/products/myst/MySTCertificationMatrix

For more information on MyST, visit http://myst.rubiconred.com

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
class { 'myst':
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
Defaults to '' (no existing configuration selected)

####`myst_action`

The identifer for the MyST action to perform (e.g. provision) as part of the MyST execution.
Defaults to 'version' (i.e. displays the MyST version)

####`myst_properties`

The properties to pass through to the MyST execution.
Defaults to {}

####`myst_flags`

The flags to pass through to the MyST execution.
Defaults to '' (no flags set)

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
* 'installed' - installs MyST
* 'absent' - uninstalls MyST
Defaults to installed.

####`myst_version`

The version of MyST which needs to be installed.
Defaults to the latest version.

####`myst_installer`

The location of the MyST installer file.
Defaults to the installer under the module files directory which matches the myst_version specified.

####`myst_license`

The location of the MyST license file.
Defaults to the license under the module files directory.

##Release Notes

###0.3.1
*Released July 4, 2015*
* Puppet-lint fixes

###0.3.0
*Released August 3, 2014*
* Added support for starting MyST web console
* Added support for license installation
* Added support for setting MyST flags to override the command line execution
* Added support for removing MyST environment variable when `environment_enable` is false

###0.2.0
*Released May 14, 2014*
* Minor tweaks

###0.1.0
*Released May 13, 2014*
* Initial release