# == Class: myst::config
#
# Sets up the MYST_HOME and PATH environment variables for MyST
#
class myst::config inherits myst {
  if $::environment_enable == true {
    case $::osfamily {
      'Linux', 'AIX', 'Debian', 'RedHat', 'SuSE', 
      'FreeBSD', 'Archlinux', 'Gentoo' : {
        file { '/etc/profile.d/myst-env.sh':
          ensure  => present,
          content => template('myst/myst-env.sh.erb'),
          owner   => 'root',
          group   => 'root',
          mode    => '0644'
        }
      }
      'Darwin' : {
        file_line { 'update-mac-path_1':
          line => "export MYST_HOME=${::myst_home}",
          path => '/etc/profile'
        }

        file_line { 'update-mac-path_2':
          line    => "export PATH=\$PATH:${::myst_home}",
          path    => '/etc/profile',
          require => File_line[update-mac-path_1]
        }
      } default: {
        fail($::unsupported_msg)
      }
    }
  } else {
    file { '/etc/profile.d/myst-env.sh':
      ensure  => absent,
    }
  }
}