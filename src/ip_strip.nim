import  strutils, streams, net, os, sequtils

var
  input = ""
  output = ""
  ipSeq: seq[string]
  help = "-i input -o output"

try:
  if paramCount() > 0:
    case paramStr(1):
      of "-i":
        input = paramStr(2)
      else:
        echo help
    case paramStr(3):
      of "-o":
        output = paramStr(4)
      else:
        echo help
except:
  echo help
  quit(1)

proc getHost(): string =
  var
    stream = newFileStream(input, fmRead)
    data = readAll(stream)
  stream.close()
  return strip(data)

var
  stream = newFileStream(output, fmWrite)
for i in getHost().splitLines:
  for x in i.split():
    if isIpAddress(x) == true:
      ipSeq.add(x)
for x in deduplicate(ipSeq):
  stream.write(x & "\n")
stream.close()
echo "ip_strip complete...\n"
