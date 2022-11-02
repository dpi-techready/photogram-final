module ApplicationHelper

  # method on index to change boolean to a simple "yes" or "no"

  def humanize_boolean(value)
    case value
    when true
      "Yes"
    when false
      "No"
    when nil
      "Undefined"
    else
      "Invalid"
    end
  end
end
