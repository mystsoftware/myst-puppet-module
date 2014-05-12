# == Class: myst
#
# This is the MyST module for Puppet which allows for MyST to be installed, 
# configured and executed from Puppet.
#
# === Parameters
#
# Document parameters here.
#
# [*myst_config*]
#   The identifer for the MyST platform configuration definition (aka model)
#   to be used in MyST execution.
#   Defaults to ''
#
# [*myst_action*]
#   The identifer for the MyST action to perform (e.g. provision) as part of
#   the MyST execution.
#   Defaults to 'version' (i.e. displays the MyST version)
#
# [*myst_properties*]
#   The properties to pass through to the MyST execution.
#   Defaults to {}
#
# [*myst_home*]
#   The home directory to install MyST to.
#   Defaults to:
#    - '/u01/app/oracle/admin/myst' on Linux
#    - '/Applications/myst' on Mac
#    - 'C:/RubiconRed/MyST' on Windows
#
# [*myst_workspace_home*]
#   The home directory where the MyST workspace can be found.
#   This includes the conf directory with all the MyST platform definitions.
#   Defaults to:
#    - '/u01/app/oracle/admin/myst/lib' on Linux
#    - '/Applications/myst/lib' on Mac
#    - 'C:/RubiconRed/MyST/lib' on Windows
#
# [*myst_web_enable*]
#   Whether to install the MyST web console.
#   Defaults to false
#
# [*myst_jenkins_enable*]
#   Whether to install Jenkins CI for MyST.
#   Defaults to false
#
# [*environment_enable*]
#   Whether to setup the required environment variables for MyST.
#   This is only required for executing MyST outside of Puppet.
#   Defaults to false
#
# [*package_ensure*]
#   Valid options are:
#   - 'installed' - installs MyST
#   - 'absent' - uninstalls MyST
#   Defaults to installed.
#
# [*myst_version*]
#   The version of MyST which needs to be installed.
#   Defaults to the latest version.
#
# [*myst_installer*]
#   The location of the MyST installer file.
#   Defaults to the installer under the module files directory which matches 
#   the myst_version specified.
#
# === Examples
#
#  class { 'myst':
#    myst_action => 'provision',
#    myst_config => 'env.dev.soa.platform'
#  }
#
# === Authors
#
# Craig Barr (craig.barr@rubiconred.com)
#
# === Copyright
#
# Copyright 2014 Rubicon Red, unless otherwise noted.
#
class myst (
  $myst_config         = $myst::params::myst_config,
  $myst_action         = $myst::params::myst_action,
  $myst_properties     = $myst::params::myst_properties,
  $myst_home           = $myst::params::myst_home,
  $myst_workspace_home = $myst::params::myst_workspace_home,
  $myst_web_enable     = $myst::params::myst_web_enable,
  $myst_jenkins_enable = $myst::params::myst_jenkins_enable,
  $environment_enable  = $myst::params::environment_enable,
  $package_ensure      = $myst::params::package_ensure,
  $myst_version        = $myst::params::myst_version,
  $myst_installer      = $myst::params::myst_installer) inherits myst::params {
  
  validate_string($myst_config)
  validate_string($myst_action)
  validate_hash($myst_properties)
  validate_absolute_path($myst_home)
  validate_absolute_path($myst_workspace_home)
  validate_bool($myst_web_enable)
  validate_bool($myst_jenkins_enable)
  validate_bool($environment_enable)
  validate_string($package_ensure)
  validate_string($myst_version)
  validate_string($myst_installer)

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'myst::begin': } ->
  class { '::myst::install': } ->
  class { '::myst::config': } ->
  class { '::myst::service': } ->
  class { '::myst::run': } ->
  anchor { 'myst::end': }
}
