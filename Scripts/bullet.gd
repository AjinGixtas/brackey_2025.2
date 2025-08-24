class_name Bullet extends CharacterBody2D
var damage : int = 1
var vel : Vector2
func init(dir : Vector2, statsheet : StatSheet):
	vel = dir * statsheet.bullet_speed
	damage = statsheet.bullet_damage
