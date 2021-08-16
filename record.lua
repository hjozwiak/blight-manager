local utils = require "utils"
-- A record structure for management of packs.
-- A record consists of the following fields:
-- * a name by which to launch the experience.
-- * the stem of the url to get the pack
-- * the username of the person
-- * the repository of the package itself.

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
      return true
    end
  end
  return false
end

function Record:create_alias(group)
  local format = string.format
  local regex = regex.new(format("^%s$", self.launch_command))
  local cb = function (_)
    -- presence check
    if not self:is_present() then
      if utils.y_or_n_p("The package is not yet installed. Would you like to install it?" == "y") then
        blight.output("Installing the plugin...")
        plugin.add(format("https://%s/%s/%s", self.repo_base, self.username, self.repo_name))
      else
        blight.output("Sorry, this package cannot be used.")
        return nil
      end

      else
        plugin.load(format("%s", self.repo_name))
    end
  end
  -- Now to create the actual alias
  group:add(regex, cb)
end

function Record:print()
  blight.output("The plugin", self.repo_name, ", found at https://", self.repo_base, "/", self.username, "/", self.repo_name, " can be launched with the alias ", self.launch_command, ".")
  if self:is_present() then
    blight.output("The plugin is available for use.")
  else
    blight.output("The plugin needs to be fetched.")
  end
end
return Record
