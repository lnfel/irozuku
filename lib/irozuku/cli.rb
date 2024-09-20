require "thor"
require "irozuku"

module Irozuku
  class CLI < Thor
    desc "write STRING", "Writes a string"
    def write(string)
      puts Irozuku.write(string)
    end
  end
end
