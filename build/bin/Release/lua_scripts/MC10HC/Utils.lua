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