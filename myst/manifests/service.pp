class myst::service inherits myst {
  if $myst_web_enable == true {
    exec { 'start-myst-web':
      command => "bash ${myst_home}/bin/start-myst-console.sh",
      require => File[$myst_home],
      path    => [$path,$myst_home]
    }
  }
}