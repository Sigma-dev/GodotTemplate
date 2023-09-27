@tool
extends CPUParticles3D

func _ready():
	emitting = true

func _process(delta):
	if Engine.is_editor_hint():
		return
	if !emitting:
		queue_free()
