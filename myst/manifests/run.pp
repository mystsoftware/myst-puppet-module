# == Class: myst::run
#
# Runs MyST actions such as provision, install, configure etc.
# 
class myst::run inherits myst {
  if $::package_ensure == installed {
    $property_arguments = inline_template('<% @myst_properties.each do |key,value| -%>-D<%= key %>=<%= value %> <% end -%>')
    $myst_args =
      "${::myst_action} ${::myst_config} ${property_arguments} ${::myst_flags}"
    exec { 'run-myst':
      environment => ["MYST_HOME=${::myst_home}"],
      command     => "myst ${myst_args}",
      cwd         => $::myst_workspace_home,
      path        => [$::path,$::myst_home],
      logoutput   => true
    }
  }
}