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
  this.reo_base = repo_base
  this.username = username
  this.repo_name = repo_name
  return this
end
function Record:print()
blight.output("The package ", self.launch_command, " is available from the following git repository: https://", self.repo_base, "/", self.username, "/", self.repo_name)
end

return Record 
