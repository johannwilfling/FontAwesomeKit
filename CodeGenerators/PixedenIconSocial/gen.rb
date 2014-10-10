require '../CodeGenerator.rb'

names = [];
codes = []

# TextMate 'CSS compress' and delete first lines
#.pe-so-aim:before{content:"\e600";}
File.read("pe-icon-social.css").each_line do |line| 
  name = '' 
  line.gsub(/(?<=\.pe-so-).*(?=:before)/i) { |match| name = match }
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

generator = CodeGenerator.new('PixedenIconSocial', names, codes)
generator.generate


