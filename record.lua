-- A record structure for management of packs.
-- A record consists of the following fields:
-- * a name by which to launch the experience.
-- * the stem of the url to get the pack
-- * the username of the person
-- the repository of the package itself.

local Record = {}
Record.__index = Record
-- The instantiation function for the record struct.
function Record.create(launch_command, repo_base, username, repo_name)
  local this = setmetatable({}, Record)
  this.launch_command = launch_command
  this.repo_base = repo_base
  this.username = username
  this.repo_name = repo_name
  return this
end
function Record:is_present()
  local plugins = plugin.get_all()
  for _,plugin in ipairs(plugins) do
    if self.repo_name == plugin then
      blight.output("The plugin is available for use.")
    end
  end
  blight.output("This plugin is not yet installed.")
end

function Record:print()
  blight.output("The plugin ", self.repo_name, ", found at https://", self.repo_base, "/", self.username, "/", self.repo_name, " can be launched with the alias ", self.launch_command, ". ", self:is_present())
end
return Record
