class_name Player extends Node2D
@export var positional_component : PlayerPositionalCOmponent
@export var gun_behavior_control : GunBehaviorControl
@export var gun_display_control : GunDisplayControl
@export var heat_manager : HeatManager
@export var bullet_display : BulletDisplay
@export var upgrade_director : UpgradeDirector
@export var health_manager : HealthManager


func _on_took_damage():
	health_manager.change_health(-1)
