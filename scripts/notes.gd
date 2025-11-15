extends Node

class_name MusicNotes

#Having it work in flats as well would be a huge waste of time. 
#For a matter of convenience we will be using Sharps Only for everything
const NOTES = [
	"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"
]

const CHORD_TYPES = {
	"major" : [0,4,7],
	"m" : [0,3,7],
	"7" : [0,4,7,10],
	"maj7" : [0,4,7,11],
	"m7" : [0,3,7,10]
}

#rearranges notes starting from a new tone.
#inputing e would mean [e, f, F# ...]
func rearrange_notes(note_center):
	var start_index = NOTES.find(note_center)
	var reordered = NOTES.slice(start_index, NOTES.size()) + NOTES.slice(0, start_index)
	return reordered


func generate_chord(note_center, chord_type):
	var relative_array = rearrange_notes(note_center)
	var pattern = CHORD_TYPES[chord_type]
	var final_notes = []
	for index in pattern:
		final_notes.append(relative_array[index])
	return final_notes
