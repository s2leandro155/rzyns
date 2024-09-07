local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local spell = Spell("instant")

local function calculateMagicShieldCapacity(player, Level, MagicLevel)
	local grade = player:upgradeSpellsWOD("Magic Shield")
	if grade >= WHEEL_GRADE_REGULAR then
		local base = 8 * MagicLevel + 8.6 * Level
	else
		local base = 7 * MagicLevel + 7.6 * Level
	end
	local base = 7 * MagicLevel + 7.6 * Level
	local bonus = math.max(300, 0.4 * Level)
	local MagicShieldCapacity = base + bonus
	print(MagicShieldCapacity)
	return MagicShieldCapacity
end

function spell.onCastSpell(creature, var)
	local condition = Condition(CONDITION_MANASHIELD)
	condition:setParameter(CONDITION_PARAM_TICKS, 180000)
	local player = creature:getPlayer()
	local grade = player:upgradeSpellsWOD("Magic Shield")
	local shield = calculateMagicShieldCapacity(player, player:getLevel(), player:getMagicLevel())
	if player then
		condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), shield))
	end
	creature:addCondition(condition)
	return combat:execute(creature, var)
end

spell:name("Magic Shield")
spell:words("utamo vita")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_MAGIC_SHIELD)
spell:id(44)
spell:cooldown(14 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(14)
spell:mana(50)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()
