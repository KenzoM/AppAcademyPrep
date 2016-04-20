class Timer
  attr_accessor :seconds
  def seconds(value = 0)
      @seconds = value
  end
  def time_string
    hour, temp_min = @seconds.divmod(3600) ##change this to a single responsblity instead
    minute, second = temp_min.divmod(60)
    not_strings_yet = [hour,minute,second]
    answer = not_strings_yet.map do |time|
      pad_it(time)
    end
    answer.join(":")
  end

  def pad_it(time)
    if time.between?(0,9)
      "0" + time.to_s
    else
      time.to_s
    end
  end
end
