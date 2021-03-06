module(..., package.seeall);

require('Body')
require('walk')
require('Speak')
require('vector')
require('gcm')
require('BodyFSM')
require('HeadFSM')

t0 = 0;
timeout = 5.0;

function entry()
  print(_NAME..' entry');

  t0 = Body.get_time();

  -- stop walking and wait for game to start
  BodyFSM.sm:set_state('bodyStop');
  HeadFSM.sm:set_state('headTrack');

  Speak.talk('Set');

  -- set indicator
  Body.set_indicator_state({1,1,0});
end

function update()
  local state = gcm.get_game_state();

  -- stop walk (in case getup routine is invoked)
  walk.stop();

  if (state == 0) then
    return 'initial';
  elseif (state == 1) then
    return 'ready';
  elseif (state == 3) then
    return 'playing';
  elseif (state == 4) then
    return 'finished';
  end
end

function exit()
end
