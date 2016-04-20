class Student
  attr_accessor :first_name, :last_name, :courses
  def initialize(first_name, last_name, courses = [])
    @first_name = first_name
    @last_name = last_name
    @courses = courses
  end
  def name
    @first_name + " " + @last_name
    # or "#{first_name last_name}"
  end
  def enroll(course)
    return if courses.include?(course)
    raise "course would cause conflict!" if has_conflict?(course)
    @courses << course
    course.students << self #self being the student itself
  end
  def course_load
    load = Hash.new(0)
    @courses.each do |course|
      load[course.department] += course.credits
    end
    load
  end
  def has_conflict?(question_course)
    # self.courses.any? do |jam| ##review on any? method..IMPORTANT
    #   jam.conflicts_with?(course)
    # end
    self.courses.any?{|enrolled| enrolled.conflicts_with?(question_course)}
  end
end
