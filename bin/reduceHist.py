#!/usr/bin/env python2
# vim: set et ai ts=2 sw=2:
import os, re, sys

def processFilesDict(theDict, inputlines):
  patternForTimestamp = re.compile(r"\A^#(\d{10})$\s", re.M)
  linecounter=0
  dictEntry=dict()
  command=''
  for line in inputlines:
    matchobject=patternForTimestamp.match(line)
    if matchobject:
      if command:
        theDict[command]=dictEntry
        dictEntry=dict()
      dictEntry['timestamp']=matchobject.group(1)
      dictEntry['line']=linecounter
      linecounter+=1
      command=''
    else:
      command=command + line
  if command:
    theDict[command]=dictEntry


if __name__ == "__main__":
  import argparse
  parser = argparse.ArgumentParser(description='Remove duplicate lines in bash history files. The files must contain timestamp entries to be processed correctly.')
  parser.add_argument("-o", "--outputfile", action="store", dest="outputfile", help="write processed entries to FILE", metavar="FILE")
  parser.add_argument('files', nargs='*', help='bash history input files or stdin')
  parser.set_defaults()
  options = parser.parse_args()
  import fileinput
  entries={}
  processFilesDict(entries, fileinput.input(files=options.files))
  entriesSortedByLine=sorted(entries.viewitems(), cmp=lambda x,y: cmp(x[1]['line'], y[1]['line']))
  def writeToFileObject(fileobject, entries):
    for command, attrs in entries:
      print >> fileobject, "#%s\n%s" % (attrs['timestamp'], command),
  if options.outputfile:
    with open(options.outputfile, 'w+') as output:
      writeToFileObject(output, entriesSortedByLine)
  else:
    writeToFileObject(sys.stdout, entriesSortedByLine)

