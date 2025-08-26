class_name Crawlie extends Node2D
@export var move_speed = 32
var enemy_director : EnemyDirector
var point_amount : int
@warning_ignore("shadowed_variable")
func init(enemy_director : EnemyDirector, point_amount : int):
	self.enemy_director = enemy_director
	self.point_amount = point_amount
func _process(delta):
	var move_vec : Vector2 = global_position.direction_to(enemy_director.player.positional_component.global_position) * move_speed
	global_position += move_vec * delta

func _on_died():
	enemy_director.enemy_killed(point_amount)
	queue_free()
