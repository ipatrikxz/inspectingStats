local AN, ANS = ...;
StatManager = {}

function StatManager:New()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end

function StatManager:CalculateStats(targetName)
    local totalStats = {
        targetName = targetName,
        Mastery = 0,
        Crit = 0,
        Haste = 0,
        Vers = 0
    }

    for i = 1, 19 do
        local itemLink = GetInventoryItemLink('target', i)

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

    return totalStats
end
