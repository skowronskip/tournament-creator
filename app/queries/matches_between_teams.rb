class MatchesBetweenTeams
  def initialize(teams)
    @teams = teams
  end

  def call
    all_matches = find_matches
    @teams = @teams.each { |team|
      team[:home_matches] = all_matches.where(home_team_id: team[:id])
      team[:away_matches] = all_matches.where(away_team_id: team[:id])
    }
  end

  private

  def find_matches
    teams_id = @teams.map do |team|
      team[:id]
    end
    Match.where(home_team_id: teams_id, away_team_id: teams_id)
  end
end