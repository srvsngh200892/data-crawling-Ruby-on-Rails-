module Utilities
  class Array
    def makeflat
      if empty? # base case
        self
      else
        variable = pop
        if variable.kind_of? Array
          makeflat + variable.makeflat
        else
          makeflat << variable
        end
      end
    end
  end

  class MakeFlat < Array
    def self.make_flat(array)
      puts array.makeflat
    end
  end
end
