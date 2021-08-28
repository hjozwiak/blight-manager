local utils = require "utils"
-- A experience structure for management of packs.
-- An experience consists of the following fields:
-- * a name by which to launch the experience.
-- * the stem of the url to get the experience
-- * the username of the author
-- * the repository of the experience itself.

local Experience = {}
Experience.__index = Experience
-- The instantiation function for the Experience struct.
function Experience.create(launch_command, repo_base, username, repo_name)
  local this = setmetatable({}, Record)
  this.launch_command = launch_command
  this.repo_base = repo_base
  this.username = username
  this.repo_name = repo_name
  return this
end
-- Find an Experience by its launch command.
-- table is a table of things to search through
-- cmd is the launch command
-- returns the first experience that matches cmd, nil if no such record was ever found.
function Experience.find_by_launch_command(table, cmd)
  for _,candidate in ipairs(table) do
    if candidate.launch_command == cmd then
      return candidate
    end
  end
  return nil
end

function Experience:is_present()
  local plugins = plugin.get_all()
  for _,plugin in ipairs(plugins) do
    if self.repo_name == plugin then
      return true
    end
  end
  return false
end

function Experience:create_alias(group)
  local format = string.format
  local regexp = format("^%s$", self.launch_command)
  -- Now to create the actual alias
  group:add(regexp, utils.handle_launch)
end
function Experience:print()
  blight.output("The experience", self.repo_name, ", found at https://", self.repo_base, "/", self.username, "/", self.repo_name, " can be launched with the alias ", self.launch_command, ".")
  if self:is_present() then
    blight.output("The experience is available for use.")
  else
    blight.output("The experience needs to be fetched.")
  end
end
return Record
