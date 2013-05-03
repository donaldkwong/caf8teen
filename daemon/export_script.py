import sys
import os
import subprocess

def exportScript(script):
  cwd = os.getcwd();
  sketchDir = cwd + '/../' + script;
  outputDir = cwd + '/../apps/' + script;

  params = [];
  params.append('processing-java');
  params.append('--sketch=' + sketchDir);
  params.append('--output=' + outputDir);
  params.append('--platform=macosx');
  params.append('--export');
  params.append('--force');

  subprocess.call(params);
  return;

scripts = ['Caf8teen', 'Caf8teen_NyanCat', 'Caf8teen_PacMan', 'Caf8teen_DynamicText'];
for script in scripts:
  exportScript(script);
