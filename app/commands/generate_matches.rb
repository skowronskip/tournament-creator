class GenerateMatches
  def initialize(participants, tournament_id)
    @participants = participants
    @tournament_id = tournament_id
  end

  def call
    generate_matches
  end

  private

  def generate_matches
    participants_amount = @participants.length
    rounds_amount = participants_amount - 1
    matches = Tournament.find(@tournament_id).matches
    unless matches.empty?
      return {error: 'Tournament has already generated matches'}
    end
    if participants_amount.odd?
      half_way = (participants_amount + 1)/ 2
      home_indices = Array.new
      away_indices = Array.new
      i = 0
      j = participants_amount - 1
      home_indices.push(0)
      while i < half_way - 1 do
        home_indices.push(@participants[i])
        i += 1
      end
      while j > half_way - 2 do
        away_indices.push(@participants[j])
        j -= 1
      end
    else
      half_way = participants_amount / 2
      home_indices = Array.new
      away_indices = Array.new
      i = 0
      j = participants_amount - 1
      while i < half_way do
        home_indices.push(@participants[i])
        i += 1
      end
      puts '-----'
      while j > half_way - 1 do
        away_indices.push(@participants[j])
        j -= 1
      end
    end
    round = 1
    match_no = 1
    while round <= rounds_amount do
      i = 0
      while i < half_way do
        if home_indices[i] != 0
          puts "Round #{round}: Match:#{match_no}: #{home_indices[i]} vs #{away_indices[i]}"
          matches.push(Match.create({
              tournament_id: @tournament_id,
              home_team_id: home_indices[i].id,
              away_team_id: away_indices[i].id,
              match_no: match_no,
              round_no: round
          }))
          match_no+=1
        end
        i += 1
      end
      i = 1
      while i < half_way  do
        if i == half_way - 1
          temp = away_indices[away_indices.length - 1]
          away_indices[away_indices.length - 1] = home_indices[1]
          home_indices[1] = temp

        else
          temp = home_indices[i+1]
          home_indices[i+1] = home_indices[1]
          home_indices[1] = temp
        end
        i += 1
      end
      j = half_way - 1
      while j > 0  do
        temp = away_indices[j-1]
        away_indices[j-1] = home_indices[1]
        home_indices[1] = temp
        j -= 1
      end
      puts '----------------------'
      round += 1
    end
    matches
  end
end