function sample (a, b, n)
  local t = {}

  for i = a, b do
      t[i] = i                       
  end
  for i = 1, n do
      table.remove(t, math.random(#t))
  end
  return(t)
end

function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

function damage_calc(num)
   return num + math.random(-num/20, num/20)
end

function calculate_targets(num_desired, num_targets)
   return math.min(num_desired, num_targets-1)
end

function slice(tbl, indexes, discart_value)
   local new = {}
   for i = 1, #indexes do
       if indexes[i] ~= discart_value then
           new[i] = tbl[i]
       end
   end
   if new == {} then
       return nil
   else
       return new
   end
end

function sample_r(star, en, n)
   local random_numbers = {}
   for i = 1, n, 1 do
       random_numbers[i] = math.random(star, en)
   end
   return random_numbers
end
function delete_creatures(id, creature)
   local InRange = creature:GetCreaturesInRange(100, id)
   for index, Mob in pairs(InRange) do
       Mob:Kill(Mob)
   end
end