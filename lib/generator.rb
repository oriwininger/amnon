class Generator

	def Generator.start
		files_to_scan = Generator.files_in_dir
		files_to_scan.each do |filename|
			Generator.extract_presidents_in_file(filename)
		end
	end

	def Generator.files_in_dir
		path = Rails.root.join('source_files')
		Dir.entries(path)[2..-1]
	end


	def Generator.extract_presidents_in_file(filename)
		file_contents = File.read("./source_files/test_file.TXT")

		get_presidents_lines(file_contents)

		# write all lines to a new file with the origin file name, but in seperate directory
	end

	def Generator.get_presidents_lines(file_contents_as_string)
	puts file_contents_as_string.rpartition(/.l/)[2]
		binding.pry
	end
end