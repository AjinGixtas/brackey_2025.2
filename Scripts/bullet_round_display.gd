extends Control

@export var bullet_type : TextureRect
@export var fire_type : TextureRect
@export var label : Label
@export var index : int
@export var gun_behavior_controller : GunBehaviorControl
@export var anim_player : AnimationPlayer
func init(_gun_behaviour_controller : GunBehaviorControl, bullet_idx : int):
	index = bullet_idx
	gun_behavior_controller = _gun_behaviour_controller
	gun_behavior_controller.player.upgrade_director.bullet_swapped.connect(update_display)
	update_display()
func update_display():
	var bullet_datas := gun_behavior_controller.mag_bullets[index].split('_')
	label.text = "x" + bullet_datas[0]
	bullet_type.texture = bullet_thumbnail[bullet_datas[1]]
	fire_type.texture = fire_thumbnail[bullet_datas[2]]
func self_remove():
	anim_player.play("remove")
const bullet_thumbnail := {
	"A": preload("res://Arts/RoundThumbnailA.png"),
	"B": preload("res://Arts/RoundThumbnailB.png"),
	"C": preload("res://Arts/RoundThumbnailC.png")
}
const fire_thumbnail := {
	"!": preload("res://Arts/BlastThumbnail.png"),
	"@": preload("res://Arts/SprayThumbnail.png")
}
