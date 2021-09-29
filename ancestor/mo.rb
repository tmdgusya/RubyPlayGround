module A
    def read
        "module A"
    end
ends

module B
    def read
        "module B"
    end
end

class Test
    prepend A
    include B

    def read
        "Class Test!"
    end
end

test = Test.new
print test.read

print Test.ancestors