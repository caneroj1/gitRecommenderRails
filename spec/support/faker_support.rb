module Support
  class User
    class << self
      def keyword
        %w{ Rails Ruby Gem Web Framework Ember Javascript Angular iOS Swift Objective-C
            Java Tomcat Apache Database Tree }.sample
      end
    end
  end

  class Repository
    class << self
      def languages
        { "Ruby": 0.25, "Java": 0.25, "C": 0.25, "C++": 0.25 }
      end
    end
  end
end
