extends Node


#Having it work in flats as well would be a huge waste of time. 
#For a matter of convenience we will be using Sharps Only for everything
const NOTES = [
	"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"
]

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
