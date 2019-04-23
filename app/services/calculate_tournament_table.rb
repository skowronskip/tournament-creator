class CalculateTournamentTable
  def initialize(participants)
    @participants = participants
  end

  def call
    calculate_table
  end

  private

  def calculate_table
    calculated = @participants.map do |participant|
      calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
      calculator.call
    end
    assign = OrderTeamsByAllConditions.new(calculated)
    table = assign.call.flatten
    table = table.sort_by { |team| [-team[:points], team[:ex_aequo_place], -team[:goals_difference]] }
    place = 1
    table.each do |team|
      team[:place] = place
      place += 1
    end
  end
end