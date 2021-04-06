## +-----------------------------------------------------------------------------------------+
## |
## |  known version pool: list of known versions of tools
## |
## |  usage: V_$(TOOL_NAME)_POOL := 1v0 1v5 2v0 etc.
## |
## +-----------------------------------------------------------------------------------------+
V_GNU_UTIL_POOL         := 1.0.8
V_HEXMOD17_POOL         := v2.0.1.4
V_PERL_POOL             := v6.5.1 v5.8.0
V_JAVA_POOL             := 1.5.0_07 
V_PYTHON_POOL           := 2v6

#------------------------------------------------------------------------------------
# Version of the tools
#------------------------------------------------------------------------------------
V_GNU_UTIL              := 1.0.8
V_MKGEN                 := 1v13

V_HEXMOD17              := v2.0.1.4
V_PERL                  := v5.8.0
V_PRQA                  := 9.4
V_PRQA_CONF             := v1.0.1
V_PYTHON                := 2v6
V_PED                   := 1v19e

#---------------------------------------------------------------------------------------------
#
#   Definition of tool related directories
#
#---------------------------------------------------------------------------------------------
GCC_COMPSUITE_DIR      := $(strip $(TOOLS_DIR))\tools\MinGW
GNU_UTIL_DIR           := $(strip $(TOOLS_DIR))\tools\gnu_utils
GNUUTILSSUITE_DIR      := $(GNU_UTIL_DIR)\$(V_GNU_UTIL)
LNK_DIR                := $(CUR_DIR)\MAK\Linker
MAK_DIR                := $(CUR_DIR)\MAK\MakGen

#---------------------------------------------------------------------------------------------
#
#   Definition of directory and filename for the tools of the Compilersuite
#
#---------------------------------------------------------------------------------------------

GCC_AR                     := $(GCC_COMPSUITE_DIR)\bin\ar.exe
GCC                        := $(GCC_COMPSUITE_DIR)\bin\gcc.exe
GCC_CPP                    := $(GCC_COMPSUITE_DIR)\bin\cpp.exe
GCC_LD                     := $(GCC_COMPSUITE_DIR)\bin\ld.exe
GCC_NM                     := $(GCC_COMPSUITE_DIR)\bin\nm.exe
GCC_STRIP                  := $(GCC_COMPSUITE_DIR)\bin\strip.exe
GCC_OBJCOPY                := $(GCC_COMPSUITE_DIR)\bin\objcopy.exe
FIND_EXE                   := $(CUR_DIR)\MAK\MakUtil\find.exe
CP 		 	               := $(CUR_DIR)\MAK\MakUtil\cp.exe
MV 		 	               := $(CUR_DIR)\MAK\MakUtil\mv.exe
MKDIR 	 	               := $(CUR_DIR)\MAK\MakUtil\mkdir-mingw.exe
TR                         := $(CUR_DIR)\MAK\MakUtil\tr.exe
SORT_EXE                   := $(CUR_DIR)\MAK\MakUtil\sort.exe
CAT_EXE                    := $(CUR_DIR)\MAK\MakUtil\cat.exe
HexmodX_cmd	               := $(CUR_DIR)\MAK\MakUtil\hexmodx\12.2.1\bin\HexmodX.cmd

GROUP_LNK_FILE             := $(LNK_DIR)\group.ld
LOCT_LNK_FILE              := $(LNK_DIR)\locate.ld
GROUP_DEP_FILE             := $(DEP_DIR)\group_linker.dep
LOCT_DEP_FILE              := $(DEP_DIR)\locate_linker.dep
GROUP_CMD_FILE             := $(GEN_DIR)\group_linker.lcf
LOCT_CMD_FILE              := $(GEN_DIR)\locate_linker.lcf
OBJ_LIST_FILE              := $(GEN_DIR)\obj_linker.lcf
RELCT_ELF_FILE             := $(GEN_DIR)\relocate.elf
RELCT_MAP_FILE             := $(GEN_DIR)\relocate.map
PRJ_ELF_FILE               := $(GEN_DIR)\project.elf
PRJ_MAP_FILE               := $(GEN_DIR)\project.map
PRJ_HEX_FILE               := $(GEN_DIR)\project.hex
CMP_CDF_FILE               := $(MAK_DIR)\compile.cdf
PRE_CDF_FILE               := $(MAK_DIR)\preprocess.cdf
LNK_CDF_FILE               := $(MAK_DIR)\link.cdf
HEX_CDF_FILE               := $(MAK_DIR)\hex.cdf
##############################################################################################
#   Macro : GCC_PRE_OPTS
#   Value : "GCC-Compiler-Switches"
#   Note  : Specifies the GCC compiler-switches
#           for preprocessing of a file.
GCC_PRE_OPTS               := -E      \
                              -undef  \
                              -P      \
                              -xc     \
                              -I.\Conf\MICROSAR     \
                              -Wundef


#---------------------------------------------------------------------------------------------
#
#   Definition of filename of the MSDOS-Tools
#
#---------------------------------------------------------------------------------------------

DOSCOPY                := copy
DOSDEL                 := del
DOSMOVE                := move
XCOPY                  := xcopy.exe

#-------------------------------------------------------------------------------------------
#    tools of the gnu util - Suite
#-------------------------------------------------------------------------------------------
MKDIR                   := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\mkdir-mingw.exe
RM                      := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\rm.exe
TR                      := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\tr.exe
EGREP                   := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\grep.exe
COPY                    := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\cp.exe
TOUCH                   := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\touch.exe
CAT                     := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\cat.exe


MKGEN_DIR               := $(strip $(TOOLS_DIR))\tools\MakeGen
MKGEN                   := $(strip $(MKGEN_DIR))\$(strip $(V_MKGEN))\MakeGen.exe
MAKEGEN_OPTS            :=-r$(strip $(PST_DIR))\MAK\Tools\MakeGen\MakeGen_PathInf.rul -m
PYTHON                  := $(strip $(TOOLS_DIR))\tools\python\$(strip $(V_PYTHON))\python.exe
ChangeHexName           := $(strip $(TOOLS_DIR))\tools\ChangeHexName\ChangeHexName.exe
RESOURCE_ANALYSER_DIR   := $(strip $(TOOLS_DIR))\tools\ResourceAnalyse\$(strip $(TOOLCHAIN))
PED                     := $(strip $(TOOLS_DIR))\tools\PED\$(V_PED)\pedkdo.exe
#-------------------------------------------------------------------------------------------
#    subst the path to the tools
#-------------------------------------------------------------------------------------------
PERL                    := $(strip $(TOOLS_DIR))\tools\perl\$(V_PERL)\bin\perl.exe

#-------------------------------------------------------------------------------------------
#    tools of hexview
#-------------------------------------------------------------------------------------------
HEXVIEW                 := $(strip $(TOOLS_DIR))\tools\Hexview\hexview.exe


#-------------------------------------------------------------------------------------------
#    tools of QAC
#-------------------------------------------------------------------------------------------
#QAC_ROOT is defined in evalstu.mak
QAC_ROOT                := $(TOOLS_DIR)\QAC
QAC_PRQA_CLI            := $(QAC_ROOT)\$(V_PRQA)\PRQA-Framework-2.3.0\common\bin\qacli.exe
QAC_PRQA_GUI            := $(QAC_ROOT)\$(V_PRQA)\PRQA-Framework-2.3.0\common\bin\qagui.exe
QAC_PRQA_CONF           := $(QAC_ROOT)\$(V_PRQA)\BCM3_QAC_Configuration\$(V_PRQA_CONF)\prqa\configs\Initial\config
QAC_PY_FILE             := $(QAC_ROOT)\$(V_PRQA)\FileProcess\v1.0\QacAddFile.py

#-------------------------------------------------------------------------------------------
#    define the path to the tools
#-------------------------------------------------------------------------------------------
PRINTF                  := $(strip $(GNU_UTIL_DIR))\$(V_GNU_UTIL)\bin\printf.exe
JAVA                    := java.exe
