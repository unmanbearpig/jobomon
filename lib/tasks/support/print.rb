class Print
  class << self
    def call(object_or_objects)
      if relation_or_ar_class?(object_or_objects)
        print_relation(object_or_objects)
      elsif object_or_objects.kind_of?(Array) || object_or_objects.kind_of?(Enumerable)
        print_enumerable(object_or_objects)
      else
        puts object_or_objects
      end
    end

    def relation_or_ar_class?(obj)
      return true if obj.kind_of?(ActiveRecord::Relation)
      return true if obj.kind_of?(Class) &&
                     obj.ancestors.include?(ActiveRecord::Base)
      false
    end

    def print_enumerable(enum)
      enum.each
    end

    def single_obj_str(obj)
      "#{obj.class} #{obj.id}: #{obj}"
    end

    def print_single(obj)
      puts single_obj_str(obj)
    end

    def print_relation(relation)
      relation.find_each do |obj|
        print_single(obj)
      end
    end
  end
end
