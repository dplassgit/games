import math

def tohex(val, nbits=16):
  return hex((val + (1 << nbits)) % (1 << nbits))

print "sintab byte "
for i in range(0,79):
  theta = (360.0/78.0)*i+2
  val = tohex(int(127*math.sin(math.radians(theta))))
  # print "%d %d $%s," % (i, theta,val[-2:]),
  print "$%s," % val[-2:],
print
print "costab byte "
for i in range(0,79):
  theta = (360.0/78.0)*i+2
  val = tohex(int(127*math.cos(math.radians(theta))))
  # print "%d %d $%s," % (i, theta,val[-2:]),
  print "$%s," % val[-2:],
print
