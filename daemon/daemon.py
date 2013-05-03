import json
import urllib
import time

import config
import processing
import network

# Uncomment to test with mock data
# network = __import__('networkmocks')

COMMAND_STATUS_PENDING  = 0;
COMMAND_STATUS_EXECUTED = 1;
COMMAND_STATUS_ERROR    = 2;
COMMAND_STATUS_UNKNOWN  = 3;

#
# Run the specfied command
#
def runCommand(command):
  print 'Running command ' + str(command);
  if command['command'] == 'cycle':
    return runCycleCommand(command);
  return COMMAND_STATUS_UNKNOWN;

#
# Run a cycle command
#
def runCycleCommand(command):
  status = COMMAND_STATUS_ERROR;
  arguments = command['arguments'];
  script = command['arguments'][0] if len(arguments) > 0 else None;
  params = command['arguments'][1] if len(arguments) > 1 else None;
  if script:
    # Kill any existing processing apps before starting one up
    processing.killCurrentProcessingApp();
    # Launch the processing app
    if processing.launchApp(script, params):
      status = COMMAND_STATUS_EXECUTED;
  return status;

#
# The main app loop
#
def main():
  sleepDuration = 5;

  while True:
    try:
      commandsString = network.getCommandsString();
      commands = json.loads(commandsString);
      statuses = {};

      print 'Received ' + str(len(commands)) + ' commands to run';
      for command in commands:
        if command['status'] != COMMAND_STATUS_PENDING:
          print 'Skipping non-pending command ' + str(command);
          continue;
        status = runCommand(command);
        statuses['statuses[' + str(command['oid']) + ']'] = status;
        
      sendStatus = network.sendCommandStatusString(urllib.urlencode(statuses));
    except:
      print 'Caught exception';
    print 'Sleeping for ' + str(sleepDuration) + ' seconds';
    time.sleep(sleepDuration);
  return;

#
# Start the app!
#
main();
