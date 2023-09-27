@tool
extends Node
class_name Health

@export var max_hp = 100
@export var destroy_parent_on_death = true
@onready var _hp = max_hp

signal health_changed(hp: int, change: int, max_hp: int)
signal damage_taken(damage: int, new_hp: int)
signal healing_received(healing: int, new_hp: int)
signal die()

func _ready():
	_hp = max_hp

func damage(dmg: int, a = 0):
	_hp -= dmg
	health_changed.emit(_hp , -dmg, max_hp)
	damage_taken.emit(dmg, _hp)
	if _hp <= 0:
		_on_death()
		
func heal(heal: int):
	_hp += heal
	if _hp > max_hp:
		_hp = max_hp
	health_changed.emit(_hp, heal, max_hp)
	healing_received.emit(heal, _hp)

func _on_death():
	die.emit()
	if destroy_parent_on_death:
		get_parent().queue_free()
