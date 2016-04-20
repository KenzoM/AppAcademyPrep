def measure(repeat = 1)
  past = Time.now
  repeat.times do |block|
    yield block
  end
  elapse = (Time.now - past)/ repeat
end
