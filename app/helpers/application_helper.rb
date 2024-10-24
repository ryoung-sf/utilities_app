module ApplicationHelper
  def bill_date_range(bill)
    end_date = bill.end_at - 1.day
    "#{short_date(bill.start_at)} - #{short_date(end_date)}"
  end

  def change_color_class(value)
    case value
    when -2...2
      "text-gray-200"
    when value > 2
      "text-red-400"
    else
      "text-spearmint"
    end
  end

  def readings_date_range(first_reading, last_reading)
    end_date = last_reading.end_at - 1.day
    "#{short_date(first_reading.start_at)} - #{short_date(end_date)}"
  end

  def short_date(date)
    date.strftime('%b %e, %Y')
  end
end
