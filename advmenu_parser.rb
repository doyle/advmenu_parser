require 'pp'

# reads the advmenu.rc file and prints out statistics about what games
# have been played the most
def parse(file_path)
  lines = File.read(file_path).split("\n")

  lines = lines.select{|line| line.match(/^game/)}
  lines = lines.map{|line| line.split(' ')}
  lines = lines.map{|line| [format_title(line[1]), seconds_to_units(line[4].to_i), line[5].to_i]}
  lines = lines.sort{|linea, lineb| lineb[2] <=> linea[2]}
  lines = [['title', 'play time', 'play count']] + lines
  pp lines
end

def format_title(title)
  title = title.gsub('"', "")
  title = title.split("/")[1]
  title
end

# http://stackoverflow.com/questions/2310197/how-to-convert-270921sec-into-days-hours-minutes-sec-ruby
def seconds_to_units(time)
  minutes, seconds = time.divmod(60)
  hours, minutes = minutes.divmod(60)
  days, hours = hours.divmod(24)

  string = ''

  if days > 0
    string << "%d days, " % days
  end

  if hours > 0
    string << "%d hours, " % hours
  end

  if minutes > 0
    string << "%d minutes and " % minutes
  end

  if seconds > 0
    string << "%d seconds" % seconds
  end

  string
end

parse ARGV[0]
