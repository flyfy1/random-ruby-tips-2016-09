require 'explicit-eval'

module M
  def M.included clz
    p "self is: #{self}, self.class_variable_defined?(:@@v): #{self.class_variable_defined?(:@@v)}"

    puts "Included clz: #{clz}"
    clz.class_eval do
      p "self.class_variable_defined?(:@@v): #{self.class_variable_defined?(:@@v)}"

      def self.set_var
        puts "setting var, self is: #{self}"
        @@v ||= {}
      end

      def self.get_var
        @@v
      end
    end
  end
end

class P
end

class A < P
end

class B < P
end

e = ExplicitEval.new 

e.implicit('A.include M')
e.explicit('A.set_var.object_id')
e.explicit('A.class_variable_get(:@@v).object_id')

e.explicit('A.set_var.object_id')

e.explicit('B.class_variable_defined?(:@@v)')
e.implicit('B.include M')
e.explicit('B.class_variable_defined?(:@@v)')

e.explicit('M.class_variable_defined?(:@@v)')
e.explicit('M.class_variable_get(:@@v).object_id')

e.explicit('A.ancestors')
e.explicit('B.ancestors')
