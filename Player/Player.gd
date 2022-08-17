extends KinematicBody

class_name Player

onready var camera = $Pivot/Camera

# FOV's for normal vs zooming
export(float) var normal_fov := 70.0
export(float) var zoom_fov := 35.0

# Movement speed for normal vs zooming
export(float) var move_speed := 5.0
export(float) var zoom_move_speed := 2.5

var velocity := Vector3.ZERO
var zooming := false
var interact_distance := 2.0 # Length of ray from player to interactable object
var mouse_sensitivity := 0.002 # radians/pixel
var zoom_mouse_sensitivity := 0.0005

#export(NodePath) var portal_camera_path: NodePath
func _ready():
    g.portal_camera = $PortalViewport/PortalCamera #get_node(portal_camera_path)

func _input(event) -> void:
    if event.is_action_pressed("ui_cancel"):
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    if event.is_action_pressed("shoot") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        var sensitivity := zoom_mouse_sensitivity if zooming else mouse_sensitivity
        rotate_y(-event.relative.x * sensitivity)
        $Pivot.rotate_x(-event.relative.y * sensitivity)
        $Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func get_input() -> Vector3:
    var input_dir := Vector3.ZERO
    # desired move in camera direction
    if Input.is_action_pressed("move_forward"):
        input_dir += -global_transform.basis.z
    if Input.is_action_pressed("move_backward"):
        input_dir += global_transform.basis.z
    if Input.is_action_pressed("strafe_left"):
        input_dir += -global_transform.basis.x
    if Input.is_action_pressed("strafe_right"):
        input_dir += global_transform.basis.x
    input_dir = input_dir.normalized()
    return input_dir

func get_looking_direction():
    var screen = get_viewport().size / 2
    var from = camera.project_ray_origin(screen)
    var dir = camera.project_ray_normal(screen)
    return camera.global_rotation

func interact():
    var screen = get_viewport().size / 2
    var from = camera.project_ray_origin(screen)
    var dir = camera.project_ray_normal(screen)
    var space_state = get_world().direct_space_state

    var result = space_state.intersect_ray(from, from + dir * interact_distance, [self], 1 << 1)
#    if not result.empty() and result.collider is PlayerInteractable:
#        result.collider._on_player_interact(self)
#        print(str(global_transform.origin.distance_to(result.position)))
#    else:
#        print("Miss")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    # Interaction
    if Input.is_action_just_pressed("shoot"):
        interact()
    
    # Handle zoom related variables
    zooming = Input.is_action_pressed("zoom")
    var desired_speed := move_speed
    var desired_fov := normal_fov
#    var portal_desired_fov := normal_fov
    if zooming:
        desired_speed = zoom_move_speed
        desired_fov = zoom_fov
        
    # Update camera zoom
    camera.fov = lerp(camera.fov, desired_fov, 0.1)
    $StencilViewport/StencilCamera.fov = lerp($StencilViewport/StencilCamera.fov, desired_fov, 0.1);
    g.portal_camera.fov = lerp(g.portal_camera.fov, desired_fov, 0.1)
    
    # Movement
    var desired_velocity := get_input() * desired_speed
    velocity.x = desired_velocity.x
    velocity.z = desired_velocity.z
    var snap = Vector3.DOWN
    velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, deg2rad(52))
