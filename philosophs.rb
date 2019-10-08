require 'thread'

@philosophen = Array.new
@forks = 0
@thread_array = Array.new

def think(philosoph)
  print " -#{philosoph} does hard thinking\n"
end

def take_left_fork(philosoph)
  if @forks > 0
    print " -#{philosoph} takes left fork"
    @forks = @forks - 1
    print " -Forks: #{@forks}"
  else
    @forks = 0
    wait(philosoph)
  end
end

def take_right_fork(philosoph)
  if @forks > 0
    print " -#{philosoph} takes right fork"
    @forks = @forks - 1
    print " -Forks: #{@forks}"
  else
    @forks = 0
    wait(philosoph)
  end
end

def return_left_fork(philosoph)
  print " -#{philosoph} returns left fork"
  if @forks <= @fork_max
    @forks = @forks + 1
    print " -Forks: #{@forks}"
  else
    @forks = @fork_max
    print " -FORK OVERFLOW"
  end
end

def return_right_fork(philosoph)
  print " -#{philosoph} returns right fork"
  if @forks <= @fork_max
    @forks = @forks + 1
    print " -Forks: #{@forks}"
  else
    @forks = @fork_max
    print "FORK OVERFLOW"
  end
end

def eat(philosoph)
  print " -#{philosoph} does Om nom nom nom"
end

def wait(philosoph)
  print " -#{philosoph} is waiting"
  while (@forks == 0)
  end
end

def philosophs_behaviour(philosoph)
  while(true)
    think(philosoph)
    take_left_fork(philosoph)
    take_right_fork(philosoph)
    eat(philosoph)
    return_left_fork(philosoph)
    return_right_fork(philosoph)
  end
end

loop do
  input = gets.to_i
  puts "#{input} philosphers will be created"

  @fork_max = input
  @forks = input

  input.times do |i|
      @philosophen << "P#{i}"
  end

  @philosophen.each_with_index do |philosoph,index|
    sleep(0.5)
    Thread.new {
      @thread_array[index] = philosophs_behaviour(philosoph)
    }
  end

  @thread_array.each_with_index do |element, index|
    @thread_array[index].join
  end

end
