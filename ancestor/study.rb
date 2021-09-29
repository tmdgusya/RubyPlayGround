class Bird

    def speak
        puts "tweet"
    end

end

class Duck < Bird

    def speak
        super
    end

end

duck = Duck.new
duck.speak