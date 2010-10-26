class WindowsServiceCheck < Scout::Plugin
class StarterPlugin < Scout::Plugin
  # An embedded YAML doc describing the options this plugin takes
  OPTIONS=<<-EOS
    service_to_monitor:
      label: Service to Monitor
      default: Idle
  EOS

  def build_report
		status = get_status
		if status
	    report :status => status
		else
			raise 'Error during process status'
		end
  rescue Exception
    error "Error determining process status", $!.message
  end

	def get_status
    if results = `typeperf \"\\Process(#{option(:service_to_monitor)})\\Working Set\" -sc 1`
			# good ends with The command completed successfully
			# not running ends with Error:\nthe data is not valid
			if results.match(/completed successfully/)
				"on"
			else
				"off"
			end
		else
			raise 'Error during process status: Typeperf returned unexpected value.'
		end
	end

end

