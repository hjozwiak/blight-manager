-- Helper functions.
local mod = {}
local format = string.format
function mod.handle_launch(matches)
  local cmd = matches[1]
  local rec = Record.find_by_launch_command(experiences, cmd)
  if rec ~= nil then 
  -- presence check
  if not rec:is_present() then

    plugin.add(format("https://%s/%s/%s", rec.repo_base, rec.username, rec.repo_name))
  else
    plugin.load(format("%s", rec.repo_name))
  end
  else
    blight.output("Something bad happened and the record was not found.")
    end
end


return mod
