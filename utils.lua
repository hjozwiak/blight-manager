-- Helper functions.
local mod = {}
local format = string.format

function mod.handle_launch(matches)
  local cmd = matches[1]
  local exp = Experience.find_by_launch_command(experiences, cmd)
  if exp ~= nil then 
  -- presence check
  if not exp:is_present() then

    plugin.add(format("https://%s/%s/%s", exp.repo_base, exp.username, exp.repo_name))
  else
    plugin.load(format("%s", exp.repo_name))
  end
  else
    blight.output("Something bad happened and the experience was not found.")
    end
end


return mod
