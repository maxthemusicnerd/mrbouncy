extends Node


#Having it work in flats as well would be a huge waste of time. 
#For a matter of convenience we will be using Sharps Only for everything
const NOTES = [
	"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"
]

const CHORD_TYPES {
	"major" : [0,4,7],
	"minor" : [0,3,7],
	"7" : [0,4,7,10],
	"maj7" : [0,4,7,11],
<<<<<<< HEAD
	"m7" : [0,3,7,10]
=======
	"min7" : [0,3,7,10]
>>>>>>> e1f5f17b4c93e994199d9381cf94754455cd5a54
}

#rearranges notes starting from a new tone.
#inputing e would mean [e, f, F# ...]
func rearrange_notes(note_center):
	var modified_array = NOTES

	var stored_array_bits = []
	for note in NOTES:
		if note != note_center:
			stored_array_bits.append(note)
			modified_array.remove(note)
		else: 
			break
	
	stored_array_bits.append_array(modified_array)
	return stored_array_bits


func generate_chord(note_center, chord_type):
	var relative_array = rearrange_notes(note_center)
	var pattern = CHORD_TYPES[chord_type]
	var final_notes = []
	for index in pattern:
		final_notes.append(relative_array[index])
	return final_notes
