module AttendeesHelper
  def formatted_date(date)
    date == Date.today ? "hoje" : "dia #{date.strftime("%d/%m")}"
  end
end
