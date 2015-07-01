import sys
from sumatra import commands
from sumatra.compatibility import StringIO

modes = list(commands.modes)
modes.sort()

usage = {}

sys.argv[0] = 'smt'

for mode in modes:
    main = getattr(commands, mode)
    usage[mode] = StringIO()
    sys.stdout = usage[mode]
    try:
        main(['--help'])
    except:
        pass
    

sys.stdout = sys.__stdout__

f = open("command_reference.txt", "w")
f.write("=====================\n")
f.write("smt command reference\n")
f.write("=====================\n\n")

for mode in modes:
    sio = usage[mode]
    f.write(mode + '\n')
    f.write('-'*len(mode) + '\n::\n\n    ')
    sio.seek(0)
    f.write("    ".join(sio.readlines()) + '\n')
    sio.close()
f.close()