def to_camel_case(word)
  word.tap { |e| e[0] = e[0].downcase }
end

def to_snake_case(word)
  word.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr('-', '_').
      downcase
end