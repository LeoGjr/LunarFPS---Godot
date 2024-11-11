extends KinematicBody

var vidas = 5
var velocidade = 2
var pontoplayer = 10

var dano = 10
var dataque = 4
onready var player = get_node("/root/Main/Player")

func _ready():
	pass

func _physics_process(delta):
	var dir = (player.translation - translation).normalized()
	dir.y = 0
	move_and_slide(dir * velocidade, Vector3.UP)

func toma_dano(dano):
	vidas -= dano
	if vidas <= 0:
		morre()
		
func morre():
	player.toma_pontos(pontoplayer)
	queue_free()
	
func atacar():
	player.toma_dano(dano)

func _on_Timer_timeout():
	if translation.distance_to(player.translation) <= dataque:
		atacar()
