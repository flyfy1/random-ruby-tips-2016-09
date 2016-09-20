require 'explicit-eval'

module M
  def set_var
    @@v ||= {}
  end

  def get_var
    @@v
  end
end

class P
end

class A < P
  def self.g
    @@v
  end

  def gg
    @@v
  end
end

class B < P
end

e = ExplicitEval.new 

e.implicit('A.extend M')
e.explicit('A.set_var.object_id')
e.explicit('A.class_variable_defined?(:@@v)')
e.explicit('A.get_var.object_id')

e.implicit('B.extend M')
e.explicit('B.get_var.object_id')

e.explicit('A.singleton_class.ancestors')
e.explicit(<<EOS)
A.singleton_class.ancestors.map do |clz| 
  [clz, clz.class_variable_defined?(:@@v)]
end
EOS

e.explicit('M.class_variable_defined?(:@@v)')

=begin
e.explicit('A.set_var.object_id')

e.explicit('B.class_variable_defined?(:@@v)')
e.explicit('B.class_variable_defined?(:@@v)')

e.explicit('M.class_variable_defined?(:@@v)')
e.explicit('M.class_variable_get(:@@v).object_id')

e.explicit('A.ancestors')
e.explicit('B.ancestors')
=end
