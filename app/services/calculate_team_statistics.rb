class CalculateTeamStatistics
  def initialize(team, as_home_matches, as_away_matches)
    @as_home_matches = as_home_matches
    @as_away_matches = as_away_matches
    @team = team
  end

  def call
    calculate_statistics
  end

  private

  def calculate_statistics
    result_object = {
        id: @team[:id],
        name: @team[:name],
        match_played: 0,
        match_won: 0,
        match_tied: 0,
        match_lost: 0,
        goals_scored: 0,
        goals_conceed: 0,
        goals_difference: 0,
        points: 0,
        ex_aequo_place: @team[:ex_aequo_place] || 0
    }

    @as_home_matches.each do |match|
      if match.homePoints != nil && match.awayPoints != nil
        if match.homePoints > match.awayPoints
          result_object[:match_won]+=1
          result_object[:points]+=3
        elsif match.homePoints == match.awayPoints
          result_object[:match_tied]+=1
          result_object[:points]+=1
        else
          result_object[:match_lost]+=1
        end
        result_object[:goals_scored]+=match.homePoints
        result_object[:goals_conceed]+=match.awayPoints
        result_object[:goals_difference]+= match.homePoints - match.awayPoints
        result_object[:match_played]+=1
      end
    end

    @as_away_matches.each do |match|
      if match.homePoints != nil && match.awayPoints != nil
        if match.homePoints < match.awayPoints
          result_object[:match_won]+=1
          result_object[:points]+=3
        elsif match.homePoints == match.awayPoints
          result_object[:match_tied]+=1
          result_object[:points]+=1
        else
          result_object[:match_lost]+=1
        end
        result_object[:goals_scored]+=match.awayPoints
        result_object[:goals_conceed]+=match.homePoints
        result_object[:goals_difference]+= match.awayPoints - match.homePoints
        result_object[:match_played]+=1
      end
    end
    result_object
  end
end