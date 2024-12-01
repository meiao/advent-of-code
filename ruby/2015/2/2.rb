str_lines = File.open('2.input').readlines

paper = 0
ribbon = 0
str_lines.each do |line|
  dims = line.split('x')
             .map { |dim| dim.to_i }
             .sort
  paper += 3 * dims[0] * dims[1] +
           2 * dims[0] * dims[2] +
           2 * dims[1] * dims[2]

  ribbon += 2 * dims[0] +
            2 * dims[1] +
            dims[0] * dims[1] * dims[2]
end

puts paper
puts ribbon
