BASE = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen" ,
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}

TENS = {
  0   => "one",
  1   => "ten",
  2   => "hundred",
  3   => "thousand",
  6   => "million",
  9   => "billion",
  12  => "trillion"
}

class Fixnum
  #had helped from a YouTube lecture-- https://www.youtube.com/watch?v=-Ze9kfbrzEE
  def in_words
    return BASE[self] if BASE[self]
    #lets find the base log 10
    log = Math.log10(self).floor
    until TENS[log]
      log -= 1
    end

    magnitude = TENS[log]
    quotient, remainer = self.divmod(10 ** log)

    latter_in_words = remainer.in_words
    ##if it zero past from the beginning, skip it
    latter_in_words = "" if latter_in_words == "zero"

    if magnitude == "ten"
      (quotient * 10).in_words + " " + latter_in_words
    else
      (quotient.in_words + " "+ magnitude + " " + latter_in_words).strip
    end

  end
end
