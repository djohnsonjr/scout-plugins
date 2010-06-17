class WindowsCheckForFiles < Scout::Plugin

	OPTIONS=<<-EOS
		directory:
			default: ~
	EOS

  def build_report
		count = scan_directory
		if count
	    report :count => count
		else
			raise 'Error during file counting'
		end
  rescue Exception
    error "Error determining file status", $!.message
  end

	def scan_directory
		count = 0
    Dir.foreach(option(:directory)) do |dir_item| 
      next if dir_item.match(/^\./)
			count += 1
    end
		count
	end

end


