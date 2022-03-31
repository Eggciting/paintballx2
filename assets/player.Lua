local loadOrgans = function()
    
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
                    equipped_organs[inc].dura = 100
                end
                loadOrgans(hasAllOrgans)
            end
        end

        return {organs}
    end
}}