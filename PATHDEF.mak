# *<BASDKey>
# ***********************************************************************************************************************
# *
# * COPYRIGHT RESERVED, United Automotive Electronic Systems Co.,Ltd, 2016. All rights reserved.
# * The reproduction, distribution and utilization of this document as well as the communication of its contents to
# * others without explicit authorization is prohibited. Offenders will be held liable for the payment of damages.
# * All rights reserved in the event of the grant of a patent, utility model or design.
# *
# ***********************************************************************************************************************
# * Template Information
# *  V1.0   05.05.2016  SongYH
# *  Created for UAES-TC Non-AutoSAR base software development.
# ***********************************************************************************************************************
# * Administrative Information 
# * $Domain____:BASD$
# * $Namespace_:\ut_MakGen\DEFN$
# * $Class_____:MAK$
# * $Name______:DEFN$
# * $Variant___:U1.0.0$
# * $Revision__:0$
# ***********************************************************************************************************************
#</BASDKey>



# TOOL_ROOT 	:= $(UMAKE_GCC_TOOL_DIR)
TOOL_ROOT 	:= C:\ghs\comp_202055


CC 			:= $(TOOL_ROOT)\cctri.exe
CC_LCF 		:= C:\BCM_SWB\tools\MinGW\bin\gcc.exe
#$(TOOL_ROOT)\cctri.exe
CC_HEX 		:= $(TOOL_ROOT)\gsrec.exe
CC_A 		:= $(TOOL_ROOT)\cctri.exe -update_archive

SWB_DIR     := C:\BCM_SWB\tools
FIND_EXE 	:= MAK\MakUtil\find.exe
CP 		 	:= MAK\MakUtil\cp.exe
MV 		 	:= MAK\MakUtil\mv.exe
MKDIR 	 	:= MAK\MakUtil\mkdir-mingw.exe
TR          := MAK\MakUtil\tr.exe
SORT_EXE    := MAK\MakUtil\sort.exe
CAT_EXE     := MAK\MakUtil\cat.exe
HexmodX_cmd	:= MAK\MakUtil\hexmodx\12.2.1\bin\HexmodX.cmd

TRICORE_OBJ := $(TOOL_DIR)\bin\tricore-objcopy.exe
TRICORE_CPP := $(TOOL_DIR)\bin\tricore-cpp.exe
TRICORE_GCC := $(TOOL_DIR)\bin\tricore-gcc.exe
TRICORE_LD  := $(TOOL_DIR)\bin\tricore-ld.exe

SRC_DIR := $(CUR_DIR)\_gen\SB_SBL\source
OBJ_DIR := $(CUR_DIR)\_gen\SB_SBL\object
INC_DIR := $(CUR_DIR)\_gen\SB_SBL\header
DEP_DIR := $(CUR_DIR)\_gen\SB_SBL\dependency
GEN_DIR := $(CUR_DIR)\_gen\SB_SBL\command
LNK_DIR := $(CUR_DIR)\MAK\Linker
MAK_DIR := $(CUR_DIR)\MAK\MakGen

GROUP_LNK_FILE := $(LNK_DIR)\group.ld
LOCT_LNK_FILE  := $(LNK_DIR)\locate.ld
GROUP_DEP_FILE := $(DEP_DIR)\group_linker.dep
LOCT_DEP_FILE  := $(DEP_DIR)\locate_linker.dep
GROUP_CMD_FILE := $(GEN_DIR)\group_linker.lcf
LOCT_CMD_FILE  := $(GEN_DIR)\locate_linker.lcf
OBJ_LIST_FILE  := $(GEN_DIR)\obj_linker.lcf
RELCT_ELF_FILE := $(GEN_DIR)\relocate.elf
RELCT_MAP_FILE := $(GEN_DIR)\relocate.map
PRJ_ELF_FILE   := $(GEN_DIR)\project.elf
PRJ_MAP_FILE   := $(GEN_DIR)\project.map
PRJ_HEX_FILE   := $(GEN_DIR)\project.hex
CMP_CDF_FILE   := $(MAK_DIR)\compile.cdf
PRE_CDF_FILE   := $(MAK_DIR)\preprocess.cdf
LNK_CDF_FILE   := $(MAK_DIR)\link.cdf
HEX_CDF_FILE   := $(MAK_DIR)\hex.cdf




#*<BASDKey>
# ***********************************************************************************************************************
# * $History___:
# * 
# * U1.0.0; 0     22.11.2018 UAES/TC/ESW2 Ma Guocheng
# *   File first created.
# *
# * $
# ***********************************************************************************************************************
#</BASDKey>