# -*- encoding : utf-8 -*-
class ImporterController < ApplicationController

  def import_spreadsheet
    @url = params[:url]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def import_suggestions_spreadsheet
    @url = params[:url]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def process_class_spreadsheet
    s = Roo::Excelx.new(params[:import][:spreadsheet].path, file_warning: :ignore)

    i = 2

    reservations = []

    while i <= s.last_row

      hash = {}
      hash[:name]        = s.cell(i, 1)
      hash[:place_id]    = Place.find_by(code: s.cell(i, 2)).id
      hash[:responsible] = s.cell(i, 3)
      hash[:reason]      = s.cell(i, 4)
      hash[:notes]       = s.cell(i, 5)

      hash[:repetitions] = {}

      begin

        hash[:repetitions][i-2] = {begin_date: s.cell(i, 6).strftime("%d/%m/%Y"),
                                   end_date: s.cell(i, 7).strftime("%d/%m/%Y"),
                                   weekly_repeat: s.cell(i, 8).to_i.to_s.chars.map{ |x|
                                     (x.to_i - 1).to_s
                                   },
                                   begin_time: Time.at(s.cell(i, 9).to_f).gmtime.strftime('%R').to_s,
                                   end_time: Time.at(s.cell(i, 10).to_f).gmtime.strftime('%R').to_s,
                                  }

        i+= 1

      end while s.cell(i, 1).nil? && i <= s.last_row

      hash[:user_id] = current_user.id

      hash[:from_class] = true

      reservations << hash

    end

    s = 0
    f = 0

    reservations.each do |hash|

      group_processor = ReservationGroupProcessor.new(hash)

      group_processor.process? ? s+= 1 : f+=1

      group_processor.save

    end

    flash[:notice] = "#{s} Reservas cadastradas com sucesso. Não se esqueça de salvá-las." if s > 0
    flash[:error] = "#{f} Reservas não cadastradas com sucesso" if f > 0

    redirect_to check_group_reservations_path(classes: true, saved: false, anchor: "my_reservations")

  end

  def process_suggestions_spreadsheet

    if params.try(:[], :import).try(:[], :spreadsheet).nil? || params.try(:[], :import).try(:[], :resource_spread_sheet).nil?
      flash[:error] = "Por favor insira as duas planilhas necessárias para o processamento"
      return redirect_to classes_suggestions_path
    end

    s = Roo::Excelx.new(params[:import][:resource_spread_sheet].path)

    $redis.set('status', 'input_conversion')

    $redis.set('total_to_process', 0)
    $redis.keys('processed*').each { |x| $redis.set(x, 0) }

    i = 3

    rooms = []
    types = []

    active_index = -1

    while i <= s.last_row

      unless s.empty?(i, 1)
        active_index += 1
        rooms << []
        types << s.cell(i, 1)
      end

      rooms[active_index] << {
        code:     s.cell(i, 2),
        name:     s.cell(i, 3),
        capacity: s.cell(i, 4).to_i,
        hours:    s.cell(i, 5)
      } unless s.empty?(i, 2)

      i+=1
    end

    i = 3

    classes = []

    s = Roo::Excelx.new(params[:import][:spreadsheet].path, file_warning: :ignore)

    while i <= s.last_row && s.cell(i, 1) != "FIM"

      classes << {
        code:         s.cell(i, 1),
        name:         s.cell(i, 2),
        acronym:      s.cell(i, 3),
        capacity:     s.cell(i, 4),
        class_number: s.cell(i, 5).to_i,
        teachers:     s.cell(i, 6).split("/"),
        suggestions: []
      } unless s.cell(i, 1).blank?

      classes.last[:suggestions] << [{
        hours:      s.cell(i, 7),
        room_type: types.find_index(s.cell(i, 8)),
      }]

      j = 9

      unless s.cell(i, j).nil?
        classes.last[:suggestions].last  << {
          hours:      s.cell(i, j),
          room_type: types.find_index(s.cell(i, j+1))
        }
        j += 1
      end

      i += 1

    end

    ClassSuggestionWorker.perform_async(classes, rooms)
    redirect_to classes_suggestions_path
  end

  def status
    total_to_process = $redis.get('total_to_process').to_i
    processed = $redis.keys('processed*').map { |x| $redis.get(x).to_i }.sum

    $redis.set('status', 'done') if (total_to_process == processed && total_to_process != 0)

    render json: {
      status: $redis.get('status'),
      total_to_process: total_to_process,
      processed: processed,
      percentage: get_percentage(processed, total_to_process)
    }
  end

  private

  def get_percentage(processed, total_to_process)
    (processed/total_to_process * 100.0).to_s + "%"
  rescue
    "0%"
  end

end
