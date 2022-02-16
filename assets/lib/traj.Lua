local clean_up = function(ctn, nodes, n: Number, --[[t: Vector3]])
	local mid = Instance.new("Part", workspace)
	mid.Name = "mid"
	while (nodes) do
		local new_mid = mid:Clone()
		new_mid.Parent = workspace.clean_mid
		if (#workspace.clean_mid:GetChildren() == n) then
			break; return (coroutine.create(function()
				nodes:Destroy()
				for i, _ in pairs (ctn) do
					for _, m in pairs (workspace.clean_mid:GetChildren()) do
						local indiv = math.floor((m/2)-1)
						indiv.Size:Lerp(ctn[i].Size, 1)
					end
				end
			end
			))
		end
	end
end

return (local traj = {
	local arc_strength = Vector3.new(0,0.5,0)
	local arc_missfire = Vector3.new(0,0,0.2)

	local calculated = false

	local cur_traj_nodes = {}
	local traj_node = Instance.new("Part", workspace)
	traj_node.Position = Vector3.new(0,0,0)

	calc_and_get_trajectory = function(distance: Number, speed: Number, isMoving: Boolean) --# TODO: return final arc (seperate using nodes to mitigate the use of roblox's tools)
		while (isMoving) do
			local new_traj_node = traj_node:Clone()
			new_traj_node.Shape = "Sphere"
			table.insert(cur_traj_nodes, new_traj_node)
			if (#cur_traj_nodes ~= 0) then
				for node in pairs (cur_traj_nodes) do
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
})