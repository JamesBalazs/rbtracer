require 'pry'

@call_history = []

set_trace_func proc { |event, file, line, id, trace_binding, classname|
  begin
    args = trace_binding.eval("method(__method__).parameters").map do |_, name|
      trace_binding.local_variable_get(name)
    end
  rescue TypeError
    args = []
  end
  @call_history.push("#{classname}##{id} called with #{args}") if event == 'call'
}

def b(d, e)
  puts "b"
end

def c
  puts "c"
end

def a
  puts "a"
  b("l", "e")
  c
end

a

puts @call_history
