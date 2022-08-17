extends Spatial

onready var player = $Player
onready var portal_pair = $PortalPair

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#    portal_pair._set_player_transform(player)
    if Input.is_action_just_pressed("ui_accept"):
        player.get_node("Pivot/Camera").current = not player.get_node("Pivot/Camera").current
