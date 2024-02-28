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