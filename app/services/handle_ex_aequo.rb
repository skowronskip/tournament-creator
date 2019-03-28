class HandleExAequo
  def initialize(teams)
    @teams = teams
    @teams_with_small_statistics = Array.new
  end

  def call
    find_matches
  end

  private

  def find_matches
    query = MatchesBetweenTeams.new(@teams)
    @teams_with_small_statistics = query.call
    create_table
  end

  def create_table
    @teams_with_small_statistics = @teams_with_small_statistics.map do |team|
      calculator = CalculateTeamStatistics.new(team, team[:home_matches], team[:away_matches])
      calculator.call
    end
    @teams_with_small_statistics = @teams_with_small_statistics.sort_by { |team| [-team[:points], -team[:goals_difference], -team[:goals_scored]] }
    place = 0
    i=0
    @teams_with_small_statistics.each do |team, index|
      if i==0 || team[:points] != @teams_with_small_statistics[i-1][:points] || team[:goals_difference] != @teams_with_small_statistics[i-1][:goals_difference] || team[:goals_scored] != @teams_with_small_statistics[i-1][:goals_scored]
        place += 1
      end
      old_team = @teams.detect {|old| old[:id] == team[:id]}
      old_team[:ex_aequo_place] = place
      old_team[:home_matches] = nil
      old_team[:away_matches] = nil
      i += 1
    end
    @teams
  end
end