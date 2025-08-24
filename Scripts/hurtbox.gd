class_name Hurtbox extends Area2D
@export var current_health : int
@export var node_user : Node
func take_damage(dmg : int):
	current_health -= dmg
	print("Took ", dmg, " dmg!")
	if current_health <= 0: die()
signal died
func die():
	died.emit()
