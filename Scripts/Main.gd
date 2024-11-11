extends Spatial

onready var ini = preload("res://Scenes/Inimigo.tscn")
onready var vidas = preload("res://Scenes/Powerups_vida.tscn")
onready var bala = preload("res://Scenes/Powerups_municao.tscn")



func _ready():
	pass


func _on_HUD_perde():
	$reinicio.start()


func _on_reinicio_timeout():
	get_tree().reload_current_scene()


func _on_embaralha_timeout():
	$geraini.set_wait_time(rand_range(20,50))
	$geramunicao.set_wait_time(rand_range(30,55))
	$geravidas.set_wait_time(rand_range(40,55))


func _on_geraini_timeout():
	var novoini = ini.instance()
	add_child(novoini)
	novoini.translation.x = rand_range(-50,50)
	novoini.translation.y = 0
	novoini.translation.z = rand_range(-50,50)


func _on_geravidas_timeout():
	var novavida = vidas.instance()
	add_child(novavida)
	novavida.translation.x = rand_range(-50,50)
	novavida.translation.y = 0.3
	novavida.translation.z = rand_range(-50,50)


func _on_geramunicao_timeout():
	var novabala = bala.instance()
	add_child(novabala)
	novabala.translation.x = rand_range(-50,50)
	novabala.translation.y = 0.3
	novabala.translation.z = rand_range(-50,50)
