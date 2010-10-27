class WindowsScriptRunner < Scout::Plugin
  # An embedded YAML doc describing the options this plugin takes
  OPTIONS=<<-EOS
    file_to_run:
      label: Bat file with path to run
  EOS

  # Basically, run a given bat file, expecting output like "Blah: 5"
  def build_report
    if `#{option(:file_to_run)}` =~ /: \(\d*\)\n/
      report 'count' => $1.to_f
    else
      raise "Couldn't run `bat file` as expected."
    end
  rescue Exception
    error "Error running bat file", $!.message
  end

end
