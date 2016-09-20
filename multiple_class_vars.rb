require 'explicit-eval'

module M
  def set_var
    @@v ||= 2
  end

  def get_var
    @@v
  end
end

module N
  def set_v
    @@v ||= 1
  end

  def get_v
    N.class_variable_defined?(:@@v) ? @@v : 'undefined'
  end
end

class P
end

class A < P
end

e = ExplicitEval.new

e.implicit('A.extend M')
e.implicit('A.extend N')
e.explicit('A.set_var')
e.explicit('A.class_variable_defined?(:@@v)')
e.explicit('A.get_var')
e.explicit('A.get_v')
e.explicit('A.set_v')
e.explicit('A.get_v')
