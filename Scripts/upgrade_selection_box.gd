class_name UpgradeSelectionBox extends Control

const SHOT_TYPE := ["A"] # A - Normal, B - Pierce, C - Explosive
const SHOT_NUMB := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
const FIRE_TYPE := ["!", "@"] # ! - Blast, @ - Spray
const base_type := { "A": 1.0, "B": 1.2, "C": 1.5 }
const base_fire := { "!": 1.3, "@": 1.0 }
const type_thumbnail := { 
	"A": preload("res://Arts/RoundThumbnailA.png"), 
	"B": preload("res://Arts/RoundThumbnailB.png"), 
	"C": preload("res://Arts/RoundThumbnailC.png") 
}
const fire_thumbnail := {
	"!": preload("res://Arts/BlastThumbnail.png"), "@": preload("res://Arts/SprayThumbnail.png")
}

var round_name : String
var round_strength : float
@export var btn_idx : int
@export var upgrade_director : UpgradeDirector
@export var label : RichTextLabel
@export var fire_type_texture : TextureRect
@export var bullet_type_texture : TextureRect
func init():
	var shot_type = SHOT_TYPE.pick_random()
	var fire_type = FIRE_TYPE.pick_random()
	var shot_numb = SHOT_NUMB.pick_random()
	fire_type_texture.texture = fire_thumbnail[fire_type]
	bullet_type_texture.texture = type_thumbnail[shot_type]
	label.text = "x" + str(shot_numb)
	round_name = shot_numb + '_' + shot_type + '_' + fire_type
	round_strength = calculate_strength(round_name)

@warning_ignore("shadowed_variable_base_class")
func calculate_strength(name: String) -> float:
	var parts := name.split("_")
	var shot_numb := int(parts[0]); var shot_type := parts[1]; var fire_type := parts[2]
	var hash_result := name.hash() % 2048; 
	var random_offset := (float(hash_result) / 1000.0) * 0.2 + 0.9
	return (shot_numb * 10.0) * base_type[shot_type] * base_fire[fire_type] * random_offset

func _on_button_pressed():
	upgrade_director.select_new_upgrade(btn_idx)
