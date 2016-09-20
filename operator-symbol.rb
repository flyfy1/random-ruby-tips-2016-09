require 'explicit-eval'

e = ExplicitEval.new
e.explicit('1 + 2')
e.explicit('1 .+ 2')
e.explicit('1.+(2)')

puts

e.explicit('h = {}')
e.explicit('h["a"] = 1; h')
e.explicit('h.send :[]=, "b", 2; h')

puts

e.explicit('def m; end')

puts

e.explicit('[1,2,3,4].reduce(:+)')
