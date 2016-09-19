def a
  b
end

def b
  bug
end

def bug
  # fail 'Err'
  puts caller
end

a
