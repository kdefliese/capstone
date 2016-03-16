class Symptom < ActiveRecord::Base
  belongs_to :days
  belongs_to :users
  validates :name, presence: true
  validates :start_time, presence: true

  def military_conversion(id,start_or_end)
    @symptom = Symptom.find(id)
    if start_or_end == "start_time"
      time = @symptom.start_time
    elsif start_or_end == "end_time"
      time = @symptom.end_time
    end
    if time.strftime("%p") == "AM" && time.strftime("%l").to_i < 10
      @return_time = "0" + time.strftime("%l:%M").strip
    elsif time.strftime("%p") == "AM" && time.strftime("%l").to_i > 10
      @return_time = time.strftime("%l:%M").strip
    else
      hour = time.strftime("%l").to_i
      if hour != 12
        military_hour = hour + 12
        @return_time = military_hour.to_s + ":" + time.strftime("%M")
      else
        @return_time = hour.to_s + ":" + time.strftime("%M")
      end
    end
    return @return_time
  end

end
