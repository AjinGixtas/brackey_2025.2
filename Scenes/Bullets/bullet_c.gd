class_name BulletC extends Bullet
@export var moving : bool = true
@warning_ignore("unused_parameter")
func _process(delta):
	if (moving): 
		velocity = vel
		move_and_slide()
@warning_ignore("unused_parameter")
func _on_hitbox_area_entered(area):
	aplayer.play("hit")
