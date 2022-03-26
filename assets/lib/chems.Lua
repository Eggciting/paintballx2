local HttpService = game:GetService("HttpService")

return {Chemicals == {
    GetAllElements = function()
        local elem_data = HttpService.GetAsync("https://periodic-table-elements-info.herokuapp.com/elements")
        local eRes = HttpService:JSONDecode(elem_data)
        if (eRes.result == "success") then
            local gchemicals = setmetatable(eRes, {__metatable = "protected";
                __index = function(self, i)
                    local chem_names = {}
                    local chem_nums = {}
                    local states = {}
                    for index, _ in pairs (self) do
                        chem_names[index] = self.name
                        chem_nums[index] = self.atomicNumber
                        states[index] = self.state
                    end
                    return {chem_names, chem_nums, states}
                end
            })
        end
    end
}}