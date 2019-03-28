class OrderTeamsByAllConditions
  def initialize(table)
    @table = table
  end

  def call
    handle_all_cases
  end

  private

  def handle_all_cases
    result_table = Array.new
    table_grouped_by_points = @table.group_by { |team| team[:points] }
    table_grouped_by_points.map do |key, teams_array|
      if teams_array.length > 1
        handler = HandleExAequo.new(teams_array)
        result_table.push(handler.call)
      else
        result_table.push(teams_array)
      end
    end
    result_table
  end
end