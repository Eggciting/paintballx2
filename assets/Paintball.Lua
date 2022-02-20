local gas = 0.0
local max_gas = 100.0
local multi = 2

local isSuppressed = false
local hit = false
local isMoving = false
local current_nodes = {}
local time

local point_a = workspace.point_a
local point_b = workspace.point_b
point_b:AddAttribute("Health", 100)

local traj = require(game.ServerScriptSerivce:WaitForChild("Trajectory"))

local charge_gas = function()
    while (gas == 0.0) do
	 gas += 1
	 if (gas == max_gas) then
	     print(gas)
	     break
	 end
    end
    return gas
end

local make_and_get_path = function(speed: Number, b_dist: Number, bullet) --# with this could span out target "prediction"
    local create_node_rate = speed/5
    local paths_folder = Instance.new("Folder", workspace)
    paths_folder.Name = "path_folder"
    local node = Instance.new("Part", workspace)
    node.Name = "NODE"
    node.Shape = "Sphere"
    local connection = Instance.new("Part", workspace)
    connection.Name = "CONNECTION"
    connection.Color = Color3.fromRGB(125, 249, 255)
    local real_time = speed/b_dist
    while wait(create_node_rate) do
	 local new_node = node:Clone()
	 new_node.Position = bullet.Position
	 table.insert(current_nodes, new_node)
	 for i, _ in pairs (current_nodes) do
	     if (x >= 0) then
		  local new_connection = connection:Clone()
		  new_connection.Position = current_nodes[i-1]
		  new_connection.Size:Lerp(current_nodes[i+1].Size, 1) --# 100% fullfil rate
		  if (new_connect.Size ~= Vector3.new(0,0,0)) then
		      new_node.Parent = paths_folder
		      new_connection.Parent = paths_folder
		      break; return { paths_folder, finished == true, b_dist, speed }
		  end
		  return finished
	     end
	 end
    end
end

predict_path = function() --# continue
    local cur_path = make_and_get_path()
    for _, path_instance in pairs (cur_path.paths_folder:GetChildren()) do
	 if (cur_path.finished) then
	     if (path_instance.Name == "NODE") then
		  local read_node_pos = path_instance.Positon
	     end
	     if (path_instance.Name == "CONNECTION") then
		  local read_connection_pos = path_instance.Position 
	     end
	     local p_line = Instance.new("Part", workspace)
	     p_line.Name = "prediciton"
	     p_line.Color = Color3.fromRGB(255, 0, 0)
	     p_line.Position = point_a.Position
	     local tj_measure = traj.calc_and_get_trajectory(cur_path.b_dist, cur_path.speed, isMoving)
	     if (tj_measure.calculated) then
		  print("Trajectory Measured - " ..tj_measure.trajectory) --# is a vec3
	     end
	 end
    end
end

local register_hit = function(travel_speed: Number, b_dist: Number, bullet, dmg_factor: Number, hit: Boolean)
    if (hit) then
	 local object_health = point_b:GetAttribute("Health")
	 object_health -= dmg_factor
	 if (object_health == 0) then
	     print "dead"
	 end
	 make_and_get_path(travel_speed, b_dist, bullet)
    end
    return
end

try_atck_dmg = function()
    local hydrogen = charge_gas()
    local bullet_dist = point_a.Positon - point_b.Position
    local projectile = Instance.new("Part")
    projectile.Positon += Vector3.new(0, 0, -5)
    return (cc == coroutine.wrap(function()
	 while (projectile.Position ~= point_b.Position and not hit) do
	     time += 1.5
	     if (projectile.Positon == point_b.Position) then
		  hit = true
		  break
	     end
	 end
	 local travel_speed = time/bullet_dist
	 if (travel_speed ~= 0) then
	     isMoving = true
	 end
	 local dmg_factor = hydrogen*(travel_speed*multi)
	 register_hit(travel_speed, bullet_dist, projectile, dmg_factor, hit)
    end
    ))
end

try_atck_dmg().resume()