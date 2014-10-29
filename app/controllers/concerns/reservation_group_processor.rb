# -*- encoding : utf-8 -*-
class ReservationGroupProcessor

  attr_reader :reservations

  def initialize(hash)
    @hash = hash
    @group = ReservationGroup.new(name: hash[:name], user_id: hash[:user_id],
      notes: hash[:notes], from_class: hash[:from_class])
  end

  def process?
    reservations = []

    @hash[:repetitions].each do |key, repetition|
      days = select_days(repetition)

      if repetition[:begin_time] > repetition[:end_time]
        return false
      end

      days.each do |day|
        reservations << Reservation.new(date: day, begin_time: repetition[:begin_time],
          end_time: repetition[:end_time], status: 'pending', reason: @hash[:reason],
          user_id: @hash[:user_id], place_id: @hash[:place_id], responsible: @hash[:responsible], created_by_id: @hash[:created_by_id])
      end
    end

    @reservations = reservations

    return true
  end

  def save
    return nil if @reservations.nil?
    return nil if @reservations.empty?

    ActiveRecord::Base.transaction do
      reservations = []

      @reservations.each do |reservation|
        raise Exception.new reservation.errors.inspect unless reservation.valid?

        @group.reservations << reservation
      end

      @group.save
    end

    return @group
  end

  private

  def select_days(repetition)
    begin_date = Date.parse(repetition[:begin_date])
    end_date = Date.parse(repetition[:end_date])
    weekly_repeat = repetition[:weekly_repeat].delete_if(&:blank?).map(&:to_i)

    result = (begin_date..end_date).to_enum.select { |k| weekly_repeat.include?(k.wday) }
  end
end
