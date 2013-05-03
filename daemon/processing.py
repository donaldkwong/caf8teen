import config
import subprocess

#
# Kill existing processing app
#
def killCurrentProcessingApp():
  # Look for Processing in process list using 'ps'
  output = subprocess.check_output(['ps', '-eax']);
  lines = output.split('\n');
  for line in lines:
    if 'caf8teen' in line and 'JavaApplicationStub' in line:
      columns = line.split(' ');
      if columns.count > 0:
        pid = int(columns[0]);
        if pid > 0:
          print 'Killing current Processing app with pid: ' + str(pid);
          subprocess.call(['kill', str(pid)]);
  return;

#
# Launch the specified Processing standalone app
#
def launchApp(appName):
  return subprocess.call(['open', config.PROCESSING_APPS_DIR + appName + '/' + appName + '.app']) == 0;

#
# Build the specified Processing sketch dir into a standalone appname
#
def buildApp(sketchDir):
  # TODO: execute the following process.  Figure out where the sketch file will be placed first.
  # processing-java --sketch=/Users/donwong/github/caf8teen/Caf8teen --output=/Users/donwong/github/caf8teen/apps/Caf8teen --export --platform=macosx --force
  return True;
