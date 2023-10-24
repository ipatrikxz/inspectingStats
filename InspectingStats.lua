AN, ANS = ...;

function ANS:CalculateStats()
    local unit = "target"
    local targetName = UnitName(unit)

    if targetName then
        local totalStats = {
            targetName = targetName,
            Mastery = 0,
            Crit = 0,
            Haste = 0,
            Vers = 0
        }

        -- Loop through equipped items
        for i = 1, 19 do
            local itemLink = GetInventoryItemLink(unit, i)

            if itemLink then
                local item = GetItemStats(itemLink)

                if item then
                    totalStats.Crit = totalStats.Crit + (item['ITEM_MOD_CRIT_RATING_SHORT'] or 0)
                    totalStats.Haste = totalStats.Haste + (item['ITEM_MOD_HASTE_RATING_SHORT'] or 0)
                    totalStats.Mastery = totalStats.Mastery + (item['ITEM_MOD_MASTERY_RATING_SHORT'] or 0)
                    totalStats.Vers = totalStats.Vers + (item['ITEM_MOD_VERSATILITY'] or 0)
                end
            end
        end

--[[         print('------------' .. targetName .. '-------------')
        print('Crit: ' .. totalStats.Crit)
        print('Haste: ' .. totalStats.Haste)
        print('Mastery: ' .. totalStats.Mastery)
        print('Versatility: ' .. totalStats.Vers) ]]

        return totalStats
    end
end

-- Function to handle the /stats command
local function StatsCommandHandler(msg)
    if UnitName('target') then
        ANS:IS_InspectStats()
    else
        print("/stats Usage: You need to target and inspect ")
    end
end

-- Register the slash command
SLASH_STATS1 = "/stats"
SlashCmdList["STATS"] = StatsCommandHandler
