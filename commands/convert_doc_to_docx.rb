require 'fileutils'

module ConvertDocToDocx
  def self.execute(options)
    # Check if file_name option is provided
    unless options[:file_name]
      puts "Error: Please provide the --file-name option with a value.".red
      exit 1
    end

    input_directory = Dir.pwd
    output_directory = File.join(input_directory, 'converted_files')

    # Create the output directory if it doesn't exist
    FileUtils.mkdir_p(output_directory)

    index = 0

    Dir.glob(File.join(input_directory, '*')).each do |file|
      # base_name = File.basename(file, '.*')
      extension = File.extname(file).downcase
      new_file_name = generate_filename(options[:file_name], index)

      index += 1

      if extension == '.doc'
        converted_file = File.join(output_directory, "#{new_file_name}.docx")
        convert_to_docx(file, converted_file)
        puts "Converting #{file} to #{converted_file}".yellow
      elsif extension == '.docx'
        copied_file = File.join(output_directory, "#{new_file_name}.docx")
        FileUtils.cp(file, copied_file)

        puts "Copying #{file} to #{copied_file}".yellow
      else
        index -= 1
      end
    end

    exit
  end

  def self.generate_filename(base_name, index)
    "#{base_name}_#{(index + 1).to_s.rjust(3, '0')}"
  end

  def self.convert_to_docx(doc_path, docx_path)
    system("unoconv -f docx -o #{docx_path} #{doc_path}")
  end
end

