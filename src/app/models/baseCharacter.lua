local baseCharacter = class("baseCharacter")
local zsAnimation = import("..models.zsAnimation")

function baseCharacter:ctor(characterName)
	self.characterName = characterName
	self.canSkill = 1
end

function baseCharacter:newCharacter()
	local testSprite = display.newSprite(self.spriteFrame)
	testSprite:playAnimationForever(display.getAnimationCache(self.characterName.."_walk"))
	self.testS = testSprite
	return testSprite
end
--((((Action:))))

function baseCharacter:shaAction(x,y)
	if self[self.characterName] == 1 then
		return
	end
	self:lockKey(self.characterName)
	-- self:unscheduleUpdate()
	self.go = 0 	--因为在这里调用不了ViewBase中的unscheduleUpdate,用这个代替
	self.testS:setVisible(false)
	local testSprite = display.newSprite(self.spriteFrame):move(x,y)
	testSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_sha"),{removeSelf = 1, onComplete = handler(self,self.canSee)})
	return testSprite,1
end

function baseCharacter:hitedAction(x,y)
	self.go = 0 	--因为在这里调用不了ViewBase中的unscheduleUpdate,用这个代替
	self.testS:setVisible(false)
	local testSprite = display.newSprite(self.spriteFrame):move(x,y)
	testSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_hitted"),{removeSelf = 1, onComplete = handler(self,self.canSee)})
	return testSprite
end


function baseCharacter:skillAction(x,y,can,offset_x,offset_y)
	if self[self.characterName] == 1 then
		return
	end
	if self.canSkill == 1 then
		self:lockKey(self.characterName)
		-- self:unscheduleUpdate()
		self.go = 0
		self.testS:setVisible(false)
		local testSprite = display.newSprite(self.spriteFrame):move(x,y)
		testSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_skill"),{removeSelf = 1, onComplete = handler(self,self.canSee)})
		local skillSprite = display.newSprite("j0.png"):move(x+offset_x,y+offset_y)
		skillSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_boom"),{removeSelf = 1})
		self.canSkill = 0
		return testSprite,skillSprite,1
	end
end

function baseCharacter:baseStep()
	if self.canSkill == 0 then
		-- self.cooldown = self.cooldown - dt
		-- if self.cooldown <= 0 then
		self.canSkill = 1
			-- self.cooldown = 2
		-- end
	end
end

function baseCharacter:canSee() --Action的回调
	local this = self
	this.testS:setVisible(true)
	self.go = 1
	this:releaseKey(self.characterName)
end

--((((锁))))
function baseCharacter:getLock()
	return self[self.characterName]
end

function baseCharacter:lockKey(key)
	self[key] = 1
end

function baseCharacter:releaseKey(key)
	self[key] = 0
end



return baseCharacter