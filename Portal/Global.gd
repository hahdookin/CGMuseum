extends Node

var portal_camera: Camera
var main_viewport: Viewport
var current_portal: CamPortal

# Called when the node enters the scene tree for the first time.
func _ready():
    main_viewport = get_viewport()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
