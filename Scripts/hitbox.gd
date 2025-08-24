class_name Hitbox extends Area2D
@export var target_group : String
var damage : int = 1
func init(dmg : int):
	damage = dmg
func _on_area_entered(area : Area2D):
	if not (area.is_in_group("Hurtbox") and area.is_in_group(target_group)): return
	(area as Hurtbox).take_damage(damage)
