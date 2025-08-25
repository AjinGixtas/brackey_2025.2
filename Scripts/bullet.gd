class_name Bullet extends CharacterBody2D
var damage : int = 1
var vel : Vector2
func init(velocity : Vector2, statsheet : StatSheet):
	vel = velocity
	damage = statsheet.bullet_damage
