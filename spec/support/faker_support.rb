module Support
  class User
    class << self
      def keyword
        %w{ Rails Ruby Gem Web Framework Ember Javascript Angular iOS Swift Objective-C
            Java Tomcat Apache Database Tree }.sample
      end
    end
  end
end
