require 'fileutils'

module ConvertDocToDocx
  def self.execute(options)
    # Check if file_name option is provided
    # unless options[:file_name]
    #   puts "Error: Please provide the --file-name option with a value.".red
    #   exit 1
    # end

    input_directory = Dir.pwd
    output_directory = File.join(input_directory, 'converted_files')

    # Create the output directory if it doesn't exist
    FileUtils.mkdir_p(output_directory)

    index = 0

    Dir.glob(File.join(input_directory, '*')).each do |file|
      base_name = File.basename(file, '.*')
      extension = File.extname(file).downcase

      next unless ['.doc', '.docx'].include?(extension)

      new_file_name = generate_filename(options[:file_name], index)
      # Determine the file name to use based on the presence of options[:file_name]
      chosen_file_name = options[:file_name] ? new_file_name : base_name

      index += 1
      new_file_path = File.join(output_directory, "#{chosen_file_name}.docx")
      pdf_file = File.join(output_directory, "#{chosen_file_name}.pdf")
      convert_to_pdf(file, pdf_file)
      puts "Converting PDF #{file} to #{pdf_file}".light_blue

      if extension == '.doc'
        convert_to_docx(file, new_file_path)
        puts "Converting DOCX #{file} to #{new_file_path}".yellow
      elsif extension == '.docx'
        FileUtils.cp(file, new_file_path)

        puts "Copying #{file} to #{new_file_path}".magenta
      else
        index -= 1
      end
    end

    exit
  end

  def self.generate_filename(base_name, index)
    "#{base_name}#{(index + 1).to_s.rjust(3, '0')}"
  end

  def self.convert_to_docx(doc_path, docx_path)
    system("unoconv -f docx -o #{docx_path} #{doc_path}")
  end

  def self.convert_to_pdf(doc_path, pdf_file)
    system("unoconv -f pdf -o #{pdf_file} #{doc_path}")
  end
end

