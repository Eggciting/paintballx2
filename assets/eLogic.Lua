local Chemicals = require(game.ServerScriptService:WaitForChild("chems"))
-- returns data ranging from atomic name to atomic number to states 

price_items = function()
    local Element_Cost = nil
    local All_Elements = Chemicals:GetAllElements()
    -- append price to chemicals/elements
    local in_shop = {All_Elements.chem_names}
    local avg_price = 20 -- organs
    local elemItem = Instance.new("StringValue", game.ReplicatedStorage)
    for i, _ in pairs (in_shop) do
        local clonedEI = elemItem:Clone()
        clonedEI.Name = in_shop[i]
        clonedEI:SetAttribute("Price", avg_price)
    end
end

price_items()

pseudo_purchase = function()
    local item = game.ReplicatedStorage:FindFirstChild()
    player.organs -= item:GetAttribute("Price")
    print(player.organs)
end

pseudo_purchase()