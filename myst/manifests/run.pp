class myst::run inherits myst {
  if $package_ensure == installed {
    $property_arguments = inline_template('<% @myst_properties.each do |key,value| -%>-D<%= key %>=<%= value %> <% end -%>')
    exec { 'run-myst':
      environment => ["MYST_HOME=${myst_home}"],
      command    => "myst ${myst_action} ${myst_config} ${property_arguments} ${myst_flags}",
      cwd        => $myst_workspace_home,
      path       => [$path,$myst_home],
      logoutput  => true
    }
  }
}