TRACKS = {
  "1" => "A City",
  "2" => "A Country",
  "3" => "A State of Mind",
}
Dir["**/*"].select {|f| File.file?(f) && (f != "fix.rb") && (!f.match(/^done/)) }.each do |t|
  track = File.basename(t)[0,1]
  chooser = File.dirname(t)
  puts %x[id3tag -a"#{chooser}" -A"#{TRACKS[track]}" -s"#{TRACKS[track]}" -c"L6T#{track}" -C"Lobster 6 track #{track}" -y"2012" -t"#{track}" -T"3" -g"Lobster" #{t}]
end
