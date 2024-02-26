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