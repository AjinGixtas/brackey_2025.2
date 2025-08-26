class_name Bullet extends CharacterBody2D
var damage : int = 1
var vel : Vector2
@export var sprite : Sprite2D
@warning_ignore("shadowed_variable_base_class")
func init(velocity : Vector2, statsheet : StatSheet):
	vel = velocity
	damage = statsheet.bullet_damage
	sprite.global_rotation = velocity.angle()
