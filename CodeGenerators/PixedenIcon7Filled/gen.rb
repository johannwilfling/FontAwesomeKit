require '../CodeGenerator.rb'

names = [];
codes = []

# TextMate 'CSS compress' and delete first lines
#.pe-7f-cloud-upload:before{content:"\e605";}
File.read("pe-icon-7-filled.css").each_line do |line| 
  name = '' 
  line.gsub(/(?<=\.pe-7f-).*(?=:before)/i) { |match| name = match }
  nameParts = name.split('-')
  nameParts = nameParts.each_with_index.map do |p, i|
    if i < 1
      p
    else
      p = p.capitalize
    end
  end
  name = nameParts.join
  names.push name
  
  code = ''
  line.gsub(/".*"/) { |match| code = match[1..(match.length-2)] }
  code = code.gsub(/\\(\w{4})/, "\\u\\1")
  codes.push code
end

generator = CodeGenerator.new('PixedenIcon7Filled', names, codes)
generator.generate


