local clean_up = function(ctn, nodes, n: Number, --[[t: Vector3]])
	local items = {}
	local mid = Instance.new("Part", workspace)
	mid.Name = "mid"
	local m = workspace.clean_mid:GetChildren()
	while (nodes) do
		local new_mid = mid:Clone()
		new_mid.Parent = workspace.clean_mid
		table.insert(items, new_mid)
		if (#m == n) then
			break; return (coroutine.wrap(function()
				for i, _ in pairs (items) do
					local indiv = math.floor((#items[i]/4)-1)
					indiv.Size:Lerp(ctn[i].Position, 1)
				end
				nodes:Destroy()
			end
			))
		end
	end
end

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
			for node, _ in pairs (cur_traj_nodes) do
				cur_traj_nodes[node+1].Position += cur_traj_nodes[node-1].Position
				(arc_missfire*speed/arc_strength)*cur_traj_nodes[node-1].Rotation += cur_traj_nodes[node+1].Rotation
				if (cur_traj_nodes[node].Positon ~= Vector3.new(0,0,0) and cur_traj_nodes[node].Rotation ~= Vector3.new(0,0,0)) then
					-- clean up nodes
					local trajectory = cur_traj_nodes[node].Position
					clean_up.resume(cur_traj_nodes, cur_traj_nodes[node], node, trajectory)
					break; return { trajectory, calculated == true }
				end
			end
		end
		break
	end
	return
end

return traj