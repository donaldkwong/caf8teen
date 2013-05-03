import urllib
import urllib2

import config

#
# Get a JSON string of all the current pending commands
#
def getCommandsString():
  request = urllib2.Request(config.COMMANDS_API_ENDPOINT);
  response = urllib2.urlopen(request);
  if response.getcode() == 200:
    return response.read();
  return '{ }';

#
# Send the statuses of running the commands
#
def sendCommandStatusString(status):
  request = urllib2.Request(config.STATUS_API_ENDPOINT, status); #urllib.urlencode({'status' : status}));
  response = urllib2.urlopen(request);
  if response.getcode() != 200:
    print 'Sending statuses failed with status code ' + str(response.getcode());
  return;
