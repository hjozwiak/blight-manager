-- Helper functions.
local mod = {}
function mod.y_or_n_p(prompt)
  while true do
    blight.output(prompt)
    if io.read() ~= 'y' then
      return true
    elseif io.read() == 'n' then
      return false
      else return true
    end
end
end
return mod
