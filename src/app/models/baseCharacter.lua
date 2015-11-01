local baseCharacter = class("baseCharacter")
local zsAnimation = import("..models.zsAnimation")

function baseCharacter:ctor(characterName)
	self.characterName = characterName
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
		return false
	end
	self:lockKey(self.characterName)
	-- self:unscheduleUpdate()
	self.go = 0 	--因为在这里调用不了ViewBase中的unscheduleUpdate,用这个代替
	self.testS:setVisible(false)
	local testSprite = display.newSprite(self.spriteFrame):move(x,y)
	testSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_sha"),{removeSelf = 1, onComplete = handler(self,self.canSee)})
	return testSprite
end

function baseCharacter:skillAction(x,y,can)
	if self[self.characterName] == 1 then
		return
	end
	if can == 1 then
		self:lockKey(self.characterName)
		-- self:unscheduleUpdate()
		self.go = 0
		self.testS:setVisible(false)
		local testSprite = display.newSprite(self.spriteFrame):move(x,y)
		testSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_skill"),{removeSelf = 1, onComplete = handler(self,self.canSee)})
		local skillSprite = display.newSprite("j0.png"):move(x+250,y+120)
		skillSprite:playAnimationOnce(display.getAnimationCache(self.characterName.."_boom"),{removeSelf = 1})
		return testSprite,skillSprite
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