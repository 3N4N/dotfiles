import sys

env = sys.platform

if env == "cygwin" or env == "linux":
    gdb.execute("source ~/.config/gdb/modules/gef.py")
elif env == "win32":
    gdb.execute("source ~/.config/gdb/gdbinit")
