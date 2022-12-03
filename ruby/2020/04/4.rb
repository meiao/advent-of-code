lines = File.open('4.input.simple').readlines

req_fields = [
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid'
]

valid_count = 0

lines.each do |line|
  fields_in_passport = line.split(' ')
    .map{|v| v.match(/:/).pre_match}
  valid_count += 1 if req_fields.map{|f| fields_in_passport.include?(f)}.count{|v| v} == 7
end

puts valid_count

def byr(value)
  return false if value == nil
  return false if (value =~ /^\d\d\d\d$/) == nil
  v = value.to_i
  return 1920 <= v && v <= 2002
end

def iyr(value)
  return false if value == nil
  return false if (value =~ /^\d\d\d\d$/) == nil
  v = value.to_i
  return 2010 <= v && v <= 2020
end

def eyr(value)
  return false if value == nil
  return false if (value =~ /^\d\d\d\d$/) == nil
  v = value.to_i
  return 2020 <= v && v <= 2030
end

def hgt(value)
  return false if value == nil
  return false if (value =~ /^\d\d(\dcm)|(in)$/) == nil
  v = value.to_i
  return 150 <= v && v <= 193 if value.include?('cm')
  return 59 <= v && v <= 76
  return false
end

def hcl(value)
  return false if value == nil
  return (value =~ /^#[a-f0-9]{6}$/) != nil
end

def ecl(value)
  return false if value == nil
  return ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(value)
end

def pid(value)
  return false if value == nil
  return (value =~/^[0-9]{9}$/) != nil
end

def validate(line)
  fields = {}
  line.split(' ').each do |pair|
    match = pair.match(/:/)
    fields[match.pre_match] = match.post_match
  end
  return byr(fields['byr']) &&
      iyr(fields['iyr']) &&
      eyr(fields['eyr']) &&
      hgt(fields['hgt']) &&
      hcl(fields['hcl']) &&
      ecl(fields['ecl']) &&
      pid(fields['pid'])
end

valid_count = 0
lines.each do |line|
  valid_count += 1 if validate(line)
end
puts valid_count
