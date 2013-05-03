MOCK_DATA_DIR = './__mock_data__/';

#
# Get a JSON string of all the current pending commands
#
def getCommandsString():
  print 'Returning mock command response';
  return open(MOCK_DATA_DIR + 'commands.json').read();

#
# Send the statuses of running the commands
#
def sendCommandStatusString(status):
  print 'Mock sending status';
