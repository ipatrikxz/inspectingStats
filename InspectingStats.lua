local AN, ANS = ...;

ANS.inspectInProgress = false
ANS.currentInspectUnitName = nil

function ANS:Initialize()
    self.statsManager = StatManager:New()
    self.uiManager = UIManager:New()
end

function ANS:OnInspect()
    if not self.inspectInProgress then
        local unitName = UnitName("target")

        if not unitName then
            print("InspectStats: You must inspect a player first.")
            return
        end

        self:Initialize()
        self.currentInspectUnitName = unitName
        self.inspectInProgress = true
        self.uiManager:ShowStats()
    else
        print('InspectStats: You already inspecting this unit.')
    end
end
