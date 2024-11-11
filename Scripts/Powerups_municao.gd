extends Area

func _ready():
	pass


func _on_Powerups_municao_body_entered(body):
	if body.name == "Player":
		body.toma_municao(10)
		queue_free()
