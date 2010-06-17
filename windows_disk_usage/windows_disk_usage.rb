class WindowsDiskUsage < Scout::Plugin

  def build_report
    if `typeperf \"\\LogicalDisk(_Total)\\% Free Space\" -sc 1` =~ /,\"(\d*\.\d*)\"\n/
      report '% available' => $1.to_f
    else
      raise "Couldn't use `typepref` as expected."
    end
  rescue Exception
    error "Error determining load", $!.message
  end

end

