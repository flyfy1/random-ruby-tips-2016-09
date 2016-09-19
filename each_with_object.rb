require 'explicit-eval'

e = ExplicitEval.new

e.explicit('[1,2,3].each_with_object({}){|val, obj| obj[val] = val + 1}')
e.explicit('[1,2,3].reduce({}){|mem, val| mem[val] = val + 1; mem}')
