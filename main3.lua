--$Author:Alexander Yakolev, 2018
--$Version:1.0
local pink = require('pink.pink')
require "noinv"

local story = pink.getStory('test.ink')
--[[
while true do
  -- 2) Game content, line by line
  while story.canContinue do
    pn (story.continue())
  end
  -- 3) Display story.currentChoices list, allow player to choose one
  for i = 1, #story.currentChoices do
    print(i .. "> " .. story.currentChoices[i].text)
  end
  if #story.currentChoices == 0 then break end -- cannot continue and there are no choices
  local answer=io.read()
  print (story.currentChoices[tonumber(answer)].choiceText)
  story.chooseChoiceIndex(answer)
end]]

main = room {
  nam = "Ink module",
  decor = function()
    while story.canContinue do
      pn (story.continue())
    end
    stead.deref('main').obj = {}
    for i = 1, #story.currentChoices do
      table.insert(main.obj, {
        nam = i;
        dsc = story.currentChoices[i].text;
        choiceText = story.currentChoices[i].choiceText;
        index = i;
        act = function(this)
          story.chooseChoiceIndex(this.index)
          walk('main')
          return this.choiceText
        end
      })
    end
  end
}
