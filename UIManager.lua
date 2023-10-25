local AN, ANS = ...;
UIManager = {
    statsFrame = {
        frameCount = 0, -- To keep track of the number of frames
        maxFrameCount = 2,
        maxColumns = 3, -- Adjust the number of columns as needed
        frameSizeX = 150,
        frameSizeY = 120,
        spacingX = 10,
        spacingY = 10,
        spawnY = 0,
        spawnX = 160,
    },
}

function UIManager:New()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end

function UIManager:ShowStatsFrame()
    self:InitFrame()
    self:InitStatsText()
end

function UIManager:InitFrame()
    if self.statsFrame.frameCount + 1 <= self.statsFrame.maxFrameCount then
        local currentColumn = self.statsFrame.frameCount % self.statsFrame.maxColumns
        local currentRow = math.floor(self.statsFrame.frameCount / self.statsFrame.maxColumns)
    
        local frameSpawnOffsetX = currentColumn * (self.statsFrame.frameSizeX + self.statsFrame.spacingX)
        local frameSpawnOffsetY = currentRow * (self.statsFrame.frameSizeY + self.statsFrame.spacingY)
      
        -- Stats Frame
        self.frame = CreateFrame("Frame", "InspectStatsFrame_" .. self.statsFrame.frameCount, InspectPaperDollFrame, 'BasicFrameTemplate')
        self.frame:SetSize(self.statsFrame.frameSizeX, self.statsFrame.frameSizeY)
        self.frame:SetPoint("BOTTOMRIGHT", self.statsFrame.spawnX + frameSpawnOffsetX, frameSpawnOffsetY)
    
        -- CloseButton
        self.frame.CloseButton:SetScript("OnClick", function ()
            self:HandleCloseStatsWindow()
            self.frame:Hide()
        end)
    
        -- Increment the frame count
        self.statsFrame.frameCount = self.statsFrame.frameCount + 1
    end
end

function UIManager:InitStatsText()
    local stats = StatManager:CalculateStats(ANS.currentInspectUnitName) -- Fetch stats from the StatManager
    local textOffsetY = -10
    local textOffsetYGap = 20
    local initialTextOffsetY = -25

    -- Define a table of stat labels and their names
    local statLabels = {
        { name = "Crit", label = "Crit" },
        { name = "Haste", label = "Haste" },
        { name = "Mastery", label = "Mastery" },
        { name = "Vers", label = "Versatility" },
    }

    -- Create text label for target name
    local labelTargetName = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelTargetName:SetPoint("TOP", 0, -5)
    labelTargetName:SetText(stats.targetName)

    -- Create text labels to display stats
    for _, stat in ipairs(statLabels) do
        local label = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("TOPLEFT", self.frame, 15, initialTextOffsetY + textOffsetY)
        label:SetText(stat.label .. ": " .. (stats[stat.name] or 0))
        textOffsetY = textOffsetY - textOffsetYGap
    end
end

function UIManager:HandleCloseStatsWindow()
    if self.statsFrame.frameCount - 1 >= 0 then
        self.statsFrame.frameCount = self.statsFrame.frameCount - 1
    end
    ANS.inspectInProgress = false
    ANS.currentInspectUnitName = nil
end