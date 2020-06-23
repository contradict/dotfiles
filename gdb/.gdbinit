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

# https://interrupt.memfault.com/blog/cortex-m-fault-debug
define armex
  set $ufsr = (SCB->CFSR)>>16
  printf "UFSR : 0x%x =", $ufsr
  if $ufsr & 1<<9
    printf " DIVBYZERO"
  end
  if $ufsr & 1<<8
    printf " UNALIGNED"
  end
  if $ufsr & 1<<3
    printf " NOCP"
  end
  if $ufsr & 1<<2
    printf " INVPC"
  end
  if $ufsr & 1<<1
    printf " INVSTATE"
  end
  if $ufsr & 1
    printf " UNDEFINSTR"
  end
  printf "\n"
  set $bfsr = ((SCB->CFSR) >> 8) & 0xFF
  printf "BFSR : 0x%x =", $bfsr
  if $bfsr & 1<<7
    printf " BFARVALID"
  end
  if $bfsr & 1<<5
    printf " LSPERR"
  end
  if $bfsr & 1<<4
    printf " STKERR"
  end
  if $bfsr & 1<<3
    printf " UNSTKERR"
  end
  if $bfsr & 1<<2
    printf " IMPRECISERR"
  end
  if $bfsr & 1<<1
    printf " PRECISERR"
  end
  if $bfsr & 1
    printf " IBUSERR"
  end
  printf "\n"
  set $mmfsr = (SCB->CFSR) & 0xFF
  printf "MMFSR : 0x%x =", $mmfsr
  if $mmfsr & 1<<7
    printf " MMARVALID"
  end
  if $mmfsr & 1<<5
    printf " MLSPERR"
  end
  if $mmfsr & 1<<4
    printf " MSTKERR"
  end
  if $mmfsr & 1<<3
    printf " MUNSTKERR"
  end
  if $mmfsr & 1<<1
    printf " DACCVIOL"
  end
  if $mmfsr & 1
    printf " IACCVIOL"
  end
  printf "\n"
  printf "EXEC_RETURN (LR):\n",
  info registers $lr
  if $lr & 0x4 == 0x0
    printf "Uses PSP 0x%x return.\n", $psp
    set $armex_base = $psp
  else
    printf "Uses MSP 0x%x return.\n", $msp
    set $armex_base = $msp
  end

  printf "xPSR            0x%x\n", *(uint32_t *)($armex_base+28)
  printf "ReturnAddress   0x%x\n", *(uint32_t *)($armex_base+24)
  printf "LR (R14)        0x%x\n", *(uint32_t *)($armex_base+20)
  printf "R12             0x%x\n", *(uint32_t *)($armex_base+16)
  printf "R3              0x%x\n", *(uint32_t *)($armex_base+12)
  printf "R2              0x%x\n", *(uint32_t *)($armex_base+8)
  printf "R1              0x%x\n", *(uint32_t *)($armex_base+4)
  printf "R0              0x%x\n", *(uint32_t *)($armex_base)
  printf "Return instruction:\n"
  x/i *(uint32_t *)($armex_base+24)
  printf "LR instruction:\n"
  x/i *(uint32_t *)($armex_base+20)
end

 

document armex

ARMv7 Exception entry behavior.

xPSR, ReturnAddress, LR (R14), R12, R3, R2, R1, and R0

end

define arm_isa
  if ($cpsr & 0x20)
    printf "Using THUMB(2) ISA\n"
  else
    printf "Using ARM ISA\n"
  end
end
