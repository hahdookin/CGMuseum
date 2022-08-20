tool
extends Spatial

export(Vector3) var wind_dir = Vector3(0, 0, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
    $MeshInstance.get_active_material(0).set_shader_param("u_rotation_amount", $MeshInstance.rotation.y)
    $MeshInstance2.get_active_material(0).set_shader_param("u_rotation_amount", $MeshInstance2.rotation.y)
    $MeshInstance3.get_active_material(0).set_shader_param("u_rotation_amount", $MeshInstance3.rotation.y)
