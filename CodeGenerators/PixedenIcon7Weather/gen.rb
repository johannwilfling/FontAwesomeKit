require '../CodeGenerator.rb'

names = [];
codes = []

# TextMate 'CSS compress' and delete first lines
#.pe-7w-wind:before{content:"\e600";}
File.read("pe-icon-7-weather.css").each_line do |line| 
  name = '' 
  line.gsub(/(?<=\.pe-7w-).*(?=:before)/i) { |match| name = match }
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

generator = CodeGenerator.new('PixedenIcon7Weather', names, codes)
generator.generate


