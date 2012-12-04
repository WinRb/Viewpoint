module Viewpoint::EWS
  module Types

    @@key_paths = {} #blank by default, set in type classes
    @@key_types = {} #blank by default, set in type classes
    @@key_alias = {} #blank by default, set in type classes

    def initialize
      @shallow      = true
      @auto_deepen  = true
    end

    def method_missing(method_sym, *arguments, &block)
      if method_keys.include?(method_sym)
        type_convert(
          method_sym,
          resolve_key_path(@ews_item, method_path(method_sym))
        )
      else
        super
      end
    end

    def shallow?
      @shallow
    end

    def auto_deepen?
      @auto_deepen
    end

    def deepen!
      if shallow?
        self.get_all_properties!
        @shallow = false
        true
      end
    end
    alias_method :enlighten!, :deepen!

    # @see http://www.ruby-doc.org/core/classes/Object.html#M000333
    def respond_to?(method_sym, include_private = false)
      if method_keys.include?(method_sym)
        true
      else
        super
      end
    end

    def methods(include_super = true)
      super + key_paths.keys + key_alias.keys
    end

    private

    def class_by_name(cname)
      if(cname.instance_of? Symbol)
        cname = cname.to_s.camel_case
      end
      Viewpoint::EWS::Types.const_get(cname)
    end

    def type_convert(key,str)
      return nil if str.nil?
      key_types[key] ? key_types[key].call(str) : str
    end

    def resolve_key_path(hsh, path)
      begin
        k = path.first
        return hsh[k] if path.length == 1
        resolve_key_path(hsh[k],path[1..-1])
      rescue
        if shallow? && auto_deepen?
          enlighten!
          retry
        end
      end
    end

    def get_var(hsh, path)
      val = resolve_key_path(hsh, path)
      yield val if block_given?
    end

    def key_paths
      self.class.key_paths
    end

    def key_types
      self.class.key_types
    end

    def key_alias
      self.class.key_alias
    end

    def method_keys
      key_paths.keys + key_alias.keys
    end

    # Resolve the method path with or without an alias
    def method_path(sym)
      key_paths[key_alias[sym] || sym]
    end

  end
end
