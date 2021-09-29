# [1, 2, 3].each { |num| puts num }

def hello_block?
    yield
end

# hello_block? {puts "Hello Block!"}

def hello_empresand?(&block)
    puts block
    block.call()
end

def hello_emp(block)
   block.call 
end

# block_var = -> { puts "Hello empersand!" }
# block_proc_var = Proc.new { puts "Hello empersand!" }
# hello_emp block_var
# hello_emp block_proc_var

# hello_empresand? &Proc.new { puts "Hello empersand!" }
# hello_empresand? &Proc.new { puts "Hello empersand!" }

def return_diff(num)
    puts num.call + 1
end

proc_var = Proc.new {return 1}
lambda_var = -> {return 1}

return_diff lambda_var
return_diff proc_var