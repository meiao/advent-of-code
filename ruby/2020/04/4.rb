lines = File.open('4.input.simple').readlines

req_fields = %w[
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
]

valid_count = 0

lines.each do |line|
  fields_in_passport = line.split(' ')
                           .map { |v| v.match(/:/).pre_match }
  valid_count += 1 if req_fields.map { |f| fields_in_passport.include?(f) }.count { |v| v } == 7
end

puts valid_count

def byr(value)
  return false if value.nil?
  return false if (value =~ /^\d\d\d\d$/).nil?

  v = value.to_i
  1920 <= v && v <= 2002
end

def iyr(value)
  return false if value.nil?
  return false if (value =~ /^\d\d\d\d$/).nil?

  v = value.to_i
  2010 <= v && v <= 2020
end

def eyr(value)
  return false if value.nil?
  return false if (value =~ /^\d\d\d\d$/).nil?

  v = value.to_i
  2020 <= v && v <= 2030
end

def hgt(value)
  return false if value.nil?
  return false if (value =~ /^\d\d(\dcm)|(in)$/).nil?

  v = value.to_i
  return 150 <= v && v <= 193 if value.include?('cm')

  59 <= v && v <= 76
end

def hcl(value)
  return false if value.nil?

  (value =~ /^#[a-f0-9]{6}$/) != nil
end

def ecl(value)
  return false if value.nil?

  %w[amb blu brn gry grn hzl oth].include?(value)
end

def pid(value)
  return false if value.nil?

  (value =~ /^[0-9]{9}$/) != nil
end

def validate(line)
  fields = {}
  line.split(' ').each do |pair|
    match = pair.match(/:/)
    fields[match.pre_match] = match.post_match
  end
  byr(fields['byr']) &&
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
