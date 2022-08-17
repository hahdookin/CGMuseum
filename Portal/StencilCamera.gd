extends Camera

# The stencil camera can only view object on the portal view layer (5).
# By having stencil objects render as white while everything else renders black,
# the stencil camera creates a mask showing where the player should be seeing a
# view from the portal's camera.

export(NodePath) var main_cam_path: NodePath

var main_cam: Camera

func _ready():
    main_cam = get_node(main_cam_path)

func _process(delta):
    # Have the stencil camera follow the main camera
    global_transform = main_cam.global_transform
