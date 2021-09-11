# Block?

**Ruby 에는 Block method 라는 것이 존재**한다. 다른 언어로 치면 익명함수와 비슷한 존재이다.
**함수의 몸체 그 자체**이다.

Block 메소드에 넘겨줘야 할 Argument 는 Pipe(|) 로 적어주고 실행될 몸체는 아래와 같이 적어준다.

```ruby
[1, 2, 3].each { |num| puts num }
```

## yield?

루비에는 **yield method 가 있는데 이는 block method 를 호출하는 코드**이다. 아래의 예시를 보자.

```ruby
def hello_block?
    yield
end

hello_block? { puts "Hello Block!" }
```

## & expression

특히 **Ruby 에서는 `&` 을 쓸때 block 을 넘겨주어야 한다.** 아래의 예시를 보자.

```ruby
def hello_empresand?(&block)
    block.call
end

hello_empresand? {puts "Hello empersand!"}
```

우리가 block 을 객체처럼 들고 있으려면 어떻게 해야할까. 예를 들면 아래와 같이 말이다.

```ruby
block_var = { puts "Hello empersand!" }

main.rb:13: syntax error, unexpected '}', expecting end-of-input
```

위와 같은 방법으로 들고 있기 위해서 주로 Proc 혹은 lambda 를 이용한다.
하지만 **Lambda 와 Proc 을 이용하면 &를 이용할 수 없다.** 아래와 같은 상황을 보자.

```ruby
block_var = -> { puts "Hello empersand!" }
block_proc_var = Proc.new { puts "Hello empersand!" }
hello_empresand? block_var
hello_empresand? block_proc_var
```

```ruby
main.rb:9:in `hello_empresand?': wrong number of arguments (given 1, expected 0) (ArgumentError)
        from main.rb:15:in `<main>'
```

위와 같이 오류가 난다. 왜 이럴까 `&` 는 어떤 역할을 하길래 이런 일이 일어나는 걸까?

사실 **Block만 `&`로 받아서 이용할 수 있는 이유는 `&` 가 Block 을 Proc 객체로 치환해주기 때문**이다.
아래의 메소드를 한번보자

```ruby
def hello_empresand?(&block)
    puts block
end


hello_empresand? { puts "Hello empersand!" }
hello_empresand? &Proc.new { puts "Hello empersand!" }
```

```ruby
#<Proc:0x00007fe49397d1a8 main.rb:22>
#<Proc:0x00007fe49397cfa0 main.rb:23>
```

위와 같이 **Block 이 Proc 으로 치환된걸 확인할 수** 있다.

따라서 해당 메소드를 변경해보자

```ruby
def hello_emp(block)
   block.call
end

block_var = -> { puts "Hello empersand!" }
block_proc_var = Proc.new { puts "Hello ampersand!" }
hello_emp block_var
hello_emp block_proc_var
```

```ruby
Hello empersand!
Hello empersand!
```

위와 같이 잘 실행되는 걸 볼 수 있다.

## lambda vs proc

둘다 사용방법은 아래와 같이 비슷하다.

```ruby
block_var = -> { puts "Hello empersand!" }
block_proc_var = Proc.new { puts "Hello empersand!" }
```

그렇다면 두객체는 어떻게 비교할까? 아래와 같은 방법으로 비교 가능하다.

```ruby
Proc.new{}.lambda? # => false
proc{}.lambda?     # => false
lambda{}.lambda?   # => true
->{}.lambda?       # => true
```

하지만 위와 같은 이유만으로는 왜 **Proc 과 lambda 가 따로 있는지를 알기 힘드므로 결정적인 차이를 알아야 한다.**
결정적인 차이는 **return 을 하는 방식의 차이**이다.

```ruby
def return_diff(num)
    puts num.call + 1
end

proc_var = Proc.new {return 1}
lambda_var = -> {return 1}

return_diff lambda_var
return_diff proc_var
```

```ruby
#result

2
```

위와 **같이 똑같이 생각하지만, lamdba_var 로 실행한 결과만 결과값이 출력**된다. 왜 일까?
이건 개념적 차이가 있는데 lambda 라는 것은 결국에 어떤 걸 받아서 평가해 내는 평가 함수가 되는데, Proc 은 하나의 Process 를 명시한 Block 처럼 여겨지므로 return 을 하지않는다.
따라서 return 을 할 블록이여야 한다면 lambda 를 쓰는 것이 맞다.
