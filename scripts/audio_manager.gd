extends Node2D

var track1
var track2
var track3
var sfx
var beatcounter

var current_beat = 1
var current_measure = 1
var current_chord

var song_seconds_per_beat
var file
var track_details

var Music = MusicNotes.new()

func _ready() -> void:
	track1 = $Track1
	track2 = $Track2
	track3 = $Track3
	sfx = $SFX
	beatcounter = $Beatcounter
	
	file = FileAccess.open("res://audio/music/Schmoovement.csv", FileAccess.READ)
	track_details = read_csv(file)
	current_chord = (track_details[1])[2]
	
	song_seconds_per_beat = 60 / track1.stream.bpm
	beatcounter.start(song_seconds_per_beat)

func read_csv(file):
	var result = []
	while not file.eof_reached():
			var line = file.get_line().strip_edges()
			if line == "":
				continue  # Skip empty lines
			var row = line.split(",")  # Split CSV columns
			result.append(row)
	return result


func _physics_process(delta: float) -> void:
	pass


func pick_random_item(arr: Array):
	var idx = randi() % arr.size()
	return arr[idx]


func play_note():
	var chord_name = parse_chord_symbol(current_chord)
	if chord_name["rest"] == "":
		chord_name["rest"] = "major"
	var note_list = Music.generate_chord(chord_name["note"], chord_name["rest"])
	var note = pick_random_item(note_list)
	print(note_list)
	var path = "res://audio/sfx/notes/" + note + ".wav"
	var stream = load(path)
	sfx.stream = stream
	sfx.play()


func parse_chord_symbol(chord_name):
	var note = ""
	var rest = ""
	if chord_name.length() > 1 and (chord_name[1] == "#" or chord_name[1] == "b"):
		note = chord_name.substr(0, 2)
		rest = chord_name.substr(2, chord_name.length() - 2)
	else:
		note = chord_name[0]
		rest = chord_name.substr(1, chord_name.length() - 1)
	print(note, rest)
	return {"note": note, "rest": rest}


func _on_beatcounter_timeout() -> void:
	if current_beat + 1 >= len(track_details) - 1:
		current_beat = 1
	current_beat += 1
	if current_beat % 4 == 0:
		current_measure += 1
	if (track_details[current_beat + 1])[2] != "":
		current_chord = (track_details[current_beat + 1])[2]
	beatcounter.start(song_seconds_per_beat)
