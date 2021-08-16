-- Helper functions.
local mod = {}
function mod.y_or_n_p(prompt)
  while true do
    blight.output(prompt)
    if io.read() ~= 'y' then
      return true
    elseif io.read() == 'n' then
      return false
    else
blight.output("Invalid answer. Please type y for yes or n for no.")
    end
end
  end
return mod
