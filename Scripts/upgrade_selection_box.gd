class_name UpgradeSelectionBox extends Control

const SHOT_TYPE := ["A", "B", "C"] # A - Normal, B - Pierce, C - Explosive
const SHOT_NUMB := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
const FIRE_TYPE := ["!", "@", "#"] # ! - Blast, @ - Spray, # Burst
const base_type := { "A": 1.0, "B": 1.2, "C": 1.5 }
const base_fire := { "!": 1.3, "@": 1.0, "#": 1.1 }

var round_name : String
var round_strength : float
@export var btn_idx : int
@export var label : RichTextLabel
func init():
	round_name = SHOT_TYPE.pick_random() + '_' + SHOT_NUMB.pick_random() + '_' + FIRE_TYPE.pick_random()
	round_strength = calculate_strength(round_name)
	label.text = "%s\n%s" % [round_name, str(round_strength)]

func calculate_strength(name: String) -> float:
	var parts = name.split("_")
	var shot_type = parts[0]; var shot_numb = int(parts[1]); var fire_type = parts[2]
	var hash = name.hash() % 2048; var random_offset = (float(hash) / 1000.0) * 0.2 + 0.9
	return (shot_numb * 10.0) * base_type * base_fire * random_offset
