class_name UpgradeSelectionBox extends Control

const SHOT_TYPE := ["A", "B", "C"] # A - Normal, B - Pierce, C - Explosive
const SHOT_NUMB := ["1", "2", "3", "4", "5", "7", "8", "9", "10"]
const FIRE_TYPE := ["!", "@"] # ! - Blast, @ - Spray
const base_type := { "A": 1.0, "B": 1.2, "C": 1.4 }
const base_fire := { "!": 1.0, "@": 1.0 }
const type_thumbnail := { 
	"A": preload("res://Arts/RoundThumbnailA.png"), 
	"B": preload("res://Arts/RoundThumbnailB.png"), 
	"C": preload("res://Arts/RoundThumbnailC.png") 
}
const type_tooltip := { "A": "Normal bullet", "B": "Piercing bullet", "C": "Explosive bomb" }
const fire_thumbnail := {
	"!": preload("res://Arts/BlastThumbnail.png"), "@": preload("res://Arts/SprayThumbnail.png")
}
const fire_tooltip := { "!": "Blast all bullets at once", "@": "Spray bullets continuously"}

var round_name : String
var round_strength : float
@export var btn_idx : int
@export var upgrade_director : UpgradeDirector
@export var label : RichTextLabel
@export var fire_type_texture : TextureRect
@export var bullet_type_texture : TextureRect
func init():
	var shot_type = pick_biased(SHOT_TYPE, 1.8)
	var fire_type = pick_biased(FIRE_TYPE, 1)
	var shot_numb = pick_biased(SHOT_NUMB, 6.0)
	fire_type_texture.texture = fire_thumbnail[fire_type]
	fire_type_texture.tooltip_text = fire_tooltip[fire_type]
	bullet_type_texture.texture = type_thumbnail[shot_type]
	bullet_type_texture.tooltip_text = type_tooltip[shot_type]
	label.text = "x" + str(shot_numb)
	label.tooltip_text = "x" + shot_numb

	round_name = shot_numb + '_' + shot_type + '_' + fire_type
	round_strength = calculate_strength(round_name)

@warning_ignore("shadowed_variable_base_class")
func calculate_strength(name: String) -> float:
	var parts := name.split("_")
	var shot_numb := int(parts[0]); var shot_type := parts[1]; var fire_type := parts[2]
	var hash_result := name.hash() % 2048; 
	var random_offset := (float(hash_result) / 1000.0) * 0.2 + 0.9
	print("random_offset = ", random_offset)
	return (shot_numb * 10.0) * base_type[shot_type] * base_fire[fire_type] * random_offset

func _on_button_pressed():
	upgrade_director.select_new_upgrade(btn_idx)

func pick_biased(array: Array, bias: float = 2.0) -> Variant:
	var r = pow(randf(), bias)
	var index = int(floor(r * array.size()))
	return array[index]
