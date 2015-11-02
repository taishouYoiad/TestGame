local baseCharacter = import(".baseCharacter")
local ZS = class("ZS")
local zsAnimation = import("..models.zsAnimation")

function ZS:ctor()
	self.zsAnimation = zsAnimation:create()
	self.x = 100
	self.y = 162
	self.Tx = 0
	self.canSkill = 1
	self.go = 1
	self.speed = 10

	self.cooldown = 2
end

function ZS:newZS()
	local ghost = baseCharacter:create("zs")
	self.ghost = ghost
	local testSprite = self.ghost:newCharacter():move(self.x,self.y)
	return testSprite
end

function ZS:step(dt)
	if self.ghost.canSkill <= 0 then
		self.cooldown = self.cooldown - dt
		if self.cooldown <= 0 then
			self.cooldown = 2
			self.ghost:baseStep()
		end
	end
	if self.go == 0 then
		return
	end
	if self.x < self.Tx then
		self.x = self.x + self.speed * dt
		self.ghost.testS:move(self.x,self.y)
	end
end

--((((Action:))))

function ZS:shaAction()
	return self.ghost:shaAction(self.x,self.y)
end

function ZS:skillAction()
	local offset_x = 250
	local offset_y = 120
	return self.ghost:skillAction(self.x,self.y,self.canSkill,offset_x,offset_y)
end

function ZS:jsAction()
	if self.ghost:getLock() == 1 then
		return false
	end
	self.speed = 20
	self.zsAnimation:setWSpeed(0.1)
	self.zsAnimation:setSSpeed(0.05)
	return self:newZS()
end

--((((((垃圾))))))
function ZS:setTx(Tx)
	self.Tx = Tx
end

function ZS:setSpeed(speed)
	self.speed = speed
end

function ZS:getCanSkill()
	return self.canSkill
end

function ZS:setCanSkill(can)
	self.canSkill = can
end

function ZS:getPos()
	return {self.x,self.y}
end

return ZS