module Viewpoint::EWS
  module Types

    KEY_PATHS = {} #blank by default, set in type classes

    def method_missing(method_sym, *arguments, &block)
      if self.class::KEY_PATHS.keys.include?(method_sym)
        resolve_key_path(@ews_item, self.class::KEY_PATHS[method_sym])
      else
        super
      end
    end

    # @see http://www.ruby-doc.org/core/classes/Object.html#M000333
    def respond_to?(method_sym, include_private = false)
      if self.class::KEY_PATHS.keys.include?(method_sym)
        true
      else
        super
      end
    end

    def methods(include_super = true)
      super + self.class::KEY_PATHS.keys
    end

    private

    def class_by_name(cname)
      if(cname.instance_of? Symbol)
        cname = cname.to_s.camel_case
      end
      Viewpoint::EWS::Types.const_get(cname)
    end

    def resolve_key_path(hsh, path)
      k = path.first
      return hsh[k] if path.length == 1
      resolve_key_path(hsh[k],path[1..-1])
    end

    def get_var(hsh, path)
      val = resolve_key_path(hsh, path)
      yield val if block_given?
    end

  end
end
