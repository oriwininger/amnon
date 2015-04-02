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
		file_contents = File.read("./source_files/#{filename}")

		get_presidents_lines(file_contents)

		# write all lines to a new file with the origin file name, but in seperate directory
	end

	def Generator.get_presidents_lines(file_contents_as_string)
		pres_title = file_contents_as_string[0..file_contents_as_string.index(".").to_i]
		cut_points = [0]
		last_found_index = 1
			while (last_found_index != nil) do 
			# get the next poisition of the president title response
			last_found_index = file_contents_as_string.index("? #{pres_title}",last_found_index+3)
			if !(last_found_index == nil)
				cut_points << last_found_index if last_found_index > -1 
			end
		end

		last_found_index = 1
			while (last_found_index != nil) do 
			# get the next poisition of the president title response
			last_found_index = file_contents_as_string.index("Q.",last_found_index+3)
			if !(last_found_index == nil)
				cut_points << last_found_index 
				
			end
		end
		file_data = []
		cut_points = cut_points.sort
		while cut_points.count > 1
			file_data << file_contents_as_string[cut_points[0]...cut_points[1]]
			cut_points.delete_at(0)
			cut_points.delete_at(1)
		end
		file_data = destroy_questions(file_data)
		File.open("results.txt", 'a') {|f| f.write(file_data) }
		#puts file_contents_as_string.rpartition(".")[0].rpartition("Q")[0].rpartition(".")[2]
		
	end
	def Generator.destroy_questions(data)
		n = 0 
		while n != data.count do
			if data[n].to_s.include?("Q.")
				data.delete_at(n)
			else
				n = n + 1
				puts n
			end			
		end
		return data
	end
end