# -*- ksh -*-

set history filename ~/.gdb/history
set history save
add-auto-load-safe-path .

source ~/.gdb/python_printers.ksh
source ~/.gdb/plot1d.gdb
source ~/.gdb/stl-views-1.0.3.gdb

python
import sys, os
sys.path.insert(0, os.path.join(os.environ.get('HOME', '/home'), '.gdb/'))
from eigen_printers import register_eigen_printers
register_eigen_printers (None)
from libstdcxxv6_printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
import libpython
end
