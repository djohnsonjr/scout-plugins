class WindowsAvailableMemory < Scout::Plugin

  def build_report
    if `typeperf \"\\Memory\\Available KBytes\" -sc 1` =~ /,\"(\d*\.\d*)\"\n/
      report :available => $1.to_f
    else
      raise "Couldn't use `typepref` as expected."
    end
  rescue Exception
    error "Error determining load", $!.message
  end

end

