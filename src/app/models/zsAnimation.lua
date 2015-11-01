local baseAnimation = import(".baseAnimation")
local zsAnimation = class("zsAnimation",baseAnimation)

--制作战士animation
function zsAnimation:ctor() 
	self.sSpeed = 0.15
	self.wSpeed = 0.15
	local t = {{0,self.wSpeed,"zs_walk"},{4,self.sSpeed,"zs_sha"},{7,0.15,"zs_skill"}}
	local filename = "zs.png"
	self:createAnimation(filename,t)
	local skillInfo = {"j","zs_boom"}
	self:createTestSkill(skillInfo)
end

function zsAnimation:setSSpeed(sSpeed)
	self:changeSpeed("zs.png",{4,sSpeed,"zs_sha"})
end

function zsAnimation:setWSpeed(wSpeed)
	self:changeSpeed("zs.png",{0,wSpeed,"zs_walk"})
end


return zsAnimation