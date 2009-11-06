class Agenda
  def self.all(*args)
    agenda = []
    
    items = [
      ["08:00", "08:50", "Credenciamento", nil],
      ["08:50", "09:00", "Abertura", nil],
      ["09:00", "09:40", "Palestra I", 1],
      ["09:40", "10:20", "Palestra II", nil],
      ["10:20", "10:40", "Coffee-break", nil],
      ["10:40", "11:20", "Palestra III", nil],
      ["11:20", "12:00", "Palestra IV", nil],
      ["12:00", "14:00", "Intervalo para almoço (*)", nil],
      ["14:00", "14:40", "Palestra V", nil],
      ["14:40", "15:20", "Palestra VI", nil],
      ["15:20", "15:40", "Coffee-break", nil],
      ["15:40", "16:20", "Palestra VII", nil],
      ["16:20", "17:00", "Palestra VIII", nil],
      ["17:00", "17:40", "Palestra XI", nil],
      ["17:40", "18:00", "Sorteiros e encerramento", nil],
      ["18:00", "Cansar", "#horaextra", nil],
    ]
    
    
    items.each do |item|
      os = OpenStruct.new :start_at => item[0], :end_at => item[1], :event => item[2], :speaker_id => item[3]
      
      def os.speaker
        return nil if self.speaker_id.nil?
        @speaker ||= Speaker.find(speaker_id) rescue nil
      end
      
      def os.what_happen
        speaker ? "<a href='/palestrantes#speaker-#{speaker.id}'>#{speaker.name} - #{speaker.presentation}</a>" : self.event
      end
      agenda << os
    end
    
    agenda
  end
end