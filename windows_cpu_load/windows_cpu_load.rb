class WindowsCPULoad < Scout::Plugin

  def build_report
    if `typeperf \"\\Processor(_Total)\\% Processor Time\" -sc 1` =~ /,\"(\d*\.\d*)\"\n/
      report '% used' => $1.to_f
    else
      raise "Couldn't use `typepref` as expected."
    end
  rescue Exception
    error "Error determining load", $!.message
  end

end

