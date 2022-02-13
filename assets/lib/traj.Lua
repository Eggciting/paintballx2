local traj = {}

local arc_strength = Vector3.new(0,0.5,0)
local arc_missfire = Vector3.new(0,0,0.2)

local calculated = false

local cur_traj_nodes = {}
local traj_node = Instance.new("Part", workspace)
traj_node.Position = Vector3.new(0,0,0)

traj.calc_and_get_trajectory = function(distance: Number, speed: Number, isMoving: Boolean) --# TODO: return final arc (seperate using nodes to mitigate the use of roblox's tools)
	while (isMoving) do
		local new_traj_node = traj_node:Clone()
		new_traj_node.Shape = "Sphere"
		table.insert(cur_traj_nodes, new_traj_node)
		if (#cur_traj_nodes ~= 0) then
			for node in pairs (cur_traj_nodes) do
				cur_traj_nodes[node+1].Position += cur_traj_nodes[node-1].Position
				cur_traj_nodes[node-1].Rotation += cur_traj_nodes[node+1].Rotation*(arc_missfire*speed/arc_strength)
				if (cur_traj_nodes[node].Positon ~= Vector3.new(0,0,0) and cur_traj_nodes[node].Rotation ~= Vector3.new(0,0,0)) then
					-- cur_traj_nodes[node+1].Rotation.Y += arc_missfire
					calculated = true
					break; return cur_traj_nodes[node].Position
				end
			end
		end
		break
	end
	return
end

return traj
