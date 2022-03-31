local Chemicals = require(game.ServerScriptService:WaitForChild("chems"))
local Player = require(game.ServerScriptService:WaitForChild("Player")
-- returns data ranging from atomic name to atomic number to states 

price_items = function()
    local element_cost = nil
    -- append price to chemicals/elements
    local in_shop = {Chemicals:GetAllElements().chem_names}
    local avg_price = 20 -- organs
    local ElemItem = Instance.new("StringValue", game.ReplicatedStorage)
    for i, _ in pairs(in_shop)
        while (i ~= #in_shop) do
            clonedEI = ElemItem:Clone()
            clonedEI.parent = Instance.new("Folder", workspace)
            if (i == #in_shop) then
                break;
            end
        end
        clonedEI.Name = in_shop[i]
        clonedEI:SetAttribute("Price", avg_price)
    end
end

price_items()

pseudo_purchase = function()
    local item = game.ReplicatedStorage:FindFirstChild()
    Player:Metadata().organs -= item:GetAttribute("Price")
    print(player.organs)
end

pseudo_purchase()