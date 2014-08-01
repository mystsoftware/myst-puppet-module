class myst::params {
  $myst_config = ''
  $myst_action = 'version'
  $myst_properties = {}
  $myst_flags = ''
  $myst_web_enable = false
  $myst_jenkins_enable = false
  $environment_enable = false
  $package_ensure = installed
  $myst_version = '2.5.2.1'
  $myst_installer = "puppet:///modules/myst/myst-installer-${myst_version}-install.jar"
  $myst_license = "puppet:///modules/myst/myst.lic"
  
  case $::osfamily {
    'Linux', 'AIX', 'Debian', 'RedHat', 'SuSE', 'FreeBSD', 'Archlinux', 'Gentoo' : {
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
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
    default   : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}