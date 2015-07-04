# == Class: myst::params
#
# Default parameter values for the myst module
#
class myst::params {
  $myst_config = ''
  $myst_action = 'version'
  $myst_properties = {}
  $myst_flags = ''
  $myst_web_enable = false
  $myst_jenkins_enable = false
  $environment_enable = false
  $package_ensure = installed
  $myst_version = '3.1.2.0'
  $myst_installer = "puppet:///modules/myst/myst-installer-${myst_version}.jar"
  $myst_license = 'puppet:///modules/myst/myst.lic'
  
  $unsupported_msg =
    "The ${module_name} module is not supported on ${::osfamily}."
  
  case $::osfamily {
    'Linux', 'AIX', 'Debian', 'RedHat', 'SuSE',
    'FreeBSD', 'Archlinux', 'Gentoo' : {
      $myst_home = '/u01/app/oracle/admin/myst'
      $myst_workspace_home = '/u01/app/oracle/admin/myst/lib'
    }
    'Darwin'  : {
      $myst_home = '/Applications/myst'
      $myst_workspace_home = '/Applications/myst/lib'
    }
    'windows' : {
      $myst_home = 'C:/RubiconRed/MyST'
      $myst_workspace_home = 'C:/RubiconRed/MyST/lib'
      fail($unsupported_msg)
    }
    default   : {
      fail($unsupported_msg)
    }
  }

}