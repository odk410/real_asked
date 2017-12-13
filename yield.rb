def hello
  puts "hello"
  yield
  puts "welcome"
end

#Block
# 아래는 같은 의미 {}의 경우 코드 여러줄을 쓸 경우 ; 을 써주어야 한다.
#hello {puts "john"}
hello do
  puts "john"
end
