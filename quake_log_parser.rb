class QuakeLogParser
  def initialize(log_file)
    @log_file = log_file
    @games = {}
  end

  def parse_log
    current_game = nil
    is_game_start = false

    File.foreach(@log_file) do |line|
      if line.include?("InitGame:")
        current_game = parse_init_game(line)
        is_game_start = true
      elsif line.include?("ShutdownGame:")
        parse_shutdown_game(current_game)
        current_game = nil
        is_game_start = false
      elsif is_game_start && line.strip.empty?
        is_game_start = false
      elsif current_game
        parse_kill(line, current_game)
      end
    end
  end

  def parse_init_game(line)
    @games["game_#{@games.keys.size + 1}"] = { total_kills: 0, players: [], kills: {}, kills_by_means: Hash.new(0) }
  end

  def parse_shutdown_game(current_game)
    current_game ||= @games.values.last
  end

  def parse_kill(line, current_game)
    killed_match = line.match(/:\s([A-Za-z\s]+)\skilled\s([A-Za-z\s]+)\sby/)
    cause_match = line.match(/by\s(.+?)$/)
    return unless killed_match && cause_match

    killed_player = killed_match[2]
    killer_player = killed_match[1]
    cause_of_death = cause_match[1].strip

    if killed_player == "<world>"
      current_game[:kills][killer_player] -= 1
    else
      current_game[:kills][killer_player] ||= 0
      current_game[:kills][killer_player] += 1
      current_game[:kills_by_means][cause_of_death] += 1
    end
    current_game[:total_kills] += 1 unless killed_player == "<world>"

    return if [killed_player, killer_player].include?("<world>")

    current_game[:players] << killer_player unless current_game[:players].include?(killer_player)
    current_game[:players] << killed_player unless current_game[:players].include?(killed_player)
  end


  def print_report
    @games.each do |game_id, game_data|

      puts "#{game_id}:"
      puts "Total kills: #{game_data[:total_kills]}"
      puts "Players: #{game_data[:players].join(', ')}"
      puts "Kills:"
      game_data[:kills].each do |player, kills|
        puts "#{player}: #{kills}"
      end
      puts "Kills by means:"
      game_data[:kills_by_means].each do |cause, count|
        puts "#{cause}: #{count}"
      end
      puts "------------------------"
    end
  end
end

parser = QuakeLogParser.new("qgames.log")
parser.parse_log
parser.print_report
