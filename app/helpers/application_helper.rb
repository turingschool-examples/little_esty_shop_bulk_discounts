module ApplicationHelper

  def float_to_percent(float)
    return "#{(float * 100).to_i}%"
  end
end
