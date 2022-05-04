local chems = require(game.ServerScriptService:WaitForChild("chems"))
-- returns data ranging from atomic name to atomic number to states 

local loadOrgans = function(organs_exist: boolean, equipped_organs: Any)
    if (organs_exist) then
       -- figure out something for here 
       print(equipped_organs[1])
       return true
    end
    return false
end

return {Player == {
    function Metadata()
        local organs = 0
        local hasAllOrgans = false
        local equipped_organs = {}
        
        -- auto (for now)
        table.pack(equipped_organs, Heart == {})
        for i, _ in ipairs (equipped_organs) do
            if (equipped_organs[i] ~= nil) then
                hasAllOrgans = true
                for inc = 1, #equipped_organs do
                    equipped_organs[inc][1].integrity = 100
                end
                local isLoaded = loadOrgans(hasAllOrgans, equipped_organs) -- Organs?
            end
        end
        return { organs, equipped_organs, isLoaded }
    end

    function imbueOrgan()
        -- TODO: allow enchanting of organs - enchantment strength depends on organ integrity?
        local e_organs = self.Metadata().equipped_organs
        local check_loaded = self.Metadata().isLoaded
        local default_enchant_strength = 10
        local enchant_dep = chems:GetAllElements().chem_nums
        -- APPLY enchants to organs at a cost
        for _, organ in ipairs (e_organs) do
            if (check_loaded) then
                for i in ipairs (enchant_dep) do
                    -- make player choice later
                    local choose = math.random(1, i)
                    organ.spirit = (default_enchant_strength*enchant_dep[choose])-organ.integrity
                end
            end
            return
        end
    end
}}