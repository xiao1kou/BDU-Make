#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by UAES, China & Robert Bosch GmbH, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : CONFIG.MAK
#
#   Version       : 1.0.1
#
#   Company       : UAES, China & Robert Bosch GmbH, Germany
#
#   Department    : UAES/NE1/ESW
#
#   Author(s)     :    Tan Jie
#
#   Last Updated  : 08.09.2011
#
#   Functionality : configuration of general ECU SW build
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   History:
#
#   Version   Date         Author   Description
#   ------------------------------------------------------------------------------------------
#   1.0.0   08.09.2011      Tan Jie
#              N: Created as a cross-platform software build environment
#   1.0.1   03.13.2012      Yang.Xiao
#              P: Add SUBPST 720 folder
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##############################################################################################
#   Macro : VERBOSE
#   Value : {empty} | "yes" (Default : {empty})
#   Note  : Activates verbose mode of make run.
VERBOSE                    :=

##############################################################################################
#   Macro : MAKEVERSION
#   Note  : indicate the version used.

MAKEVERSION                := 2.0.3

##############################################################################################
#   Macro : PARALLEL_EXECUTION
#   Value : {empty} | "2, 3, 4..." (Default : {empty})
#   Note  : This is the number of recipes to execute compiling at once, 
#   
PARALLEL_EXECUTION         := 4

##############################################################################################
#   Macro : ESTE_DIR
#   Note  : indicate home dir of SWB Makefile.
TOOLS_DISK                 := C:
TOOLS_DIR                  := $(TOOLS_DISK)\BCM_SWB
MAK_DIR                    := $(TOOLS_DISK)\BCM_SWB\makefile

##############################################################################################
#   Macro : PLATFORM NAME
#   Value : {empty} | Platform Name , eg. BCM2.0, M7817, MED1782, etc(Default : {empty})
#   Note  : Name of platform
PLATFORM                   := BCM3_5

# TODO:  add a rule mapping makefile to fulfill the configuration mapping from PLATFORM to MCU_TYPE, TOOLCHAIN, COMMON_INC_DIRS

##############################################################################################
#   Macro : MCU_TYPE
#   Value : {ppc563xm|i386}
#   Note  : Specifies MCU type
#
MCU_TYPE                   := ppc

##############################################################################################
#   Macro : MCU_ID
#   Value : {SPC582B50|SPC582B54|SPC582B60|SPC584B60|SPC584B64|SPC584B70|SPC584C70|SPC584C74|SPC584C80|SPC58EC70|SPC58EC74|SPC58EC80}
#               {SPC584G80|SPC584G84|SPC58EG80|SPC58EG84|SPC58NG80|SPC58NG84}
#   Note  : Specifies MCU ID
#
MCU_ID                     := SPC58NG84

##############################################################################################
#   Macro : TOOLCHAIN NAME
#   Value : {empty} | gcc | ghs | other ToolChain Name (Default : {empty})
#   Note  : Name of tool chain, if {empty}, gcc is used. For target ppc563xm,currently only ghs
#           supported 
TOOLCHAIN                  := ghs

##############################################################################################
#   Macro : COMMON_INC_DIRS
#   Value : {empty} | common include dirs (Default : {empty})
#   Note  : common include dirs                   
COMMON_INC_DIRS            := 

##############################################################################################
#   Macro : CUSTOMER_INCLUDES
#   Value : {empty} | Customer include dirs (Default : {empty})
#   Note  : customer include dirs
CUSTOMER_INCLUDES          :=

##############################################################################################
### Indicate whether to perform resource analysis  
###
PERFORM_RESOURCE_ANALYSIS  := x
                            
##############################################################################################
###  Command for execution before normal make process starts
###
USER_PRE_PROCESS           :=

##############################################################################################
###  Command for execution after normal make process finished
###
USER_POST_PROCESS          :=

##############################################################################################
###  Macro for entry symbol 
###
ENTRY_FUNCTION             := _start_c2

##############################################################################################
###  Macro for User Macro Labels 
###e.g.: SYSTEM_H=\"system.h\"  GHS (seperate with blank)
USER_MACRO                 := 

##############################################################################################
###  Macro for User CC options 
###e.g.: -c99 -ghstd=none(seperate with blank)
USER_CC_OPTS               := 

##############################################################################################
###  Macro for User Link libs 
###e.g.: -lsys -lmath(seperate with blank)
USER_LINK_LIBS             := 

##############################################################################################
###  Macro for generate S-Record file 
###e.g.: Blank: No Run file generated   Non-Blank: Gen Run file
GEN_RUN_FILE               := 

##############################################################################################
###  Macro for define project type 
### Value : ({empty} | ASW | TSW )
PRJ_TYPE_DEF               := ASW

##############################################################################################
###  Macro for define TSW PAD range 
### 
ifeq ($(PRJ_TYPE_DEF),TSW)
TSW_PAD_STARTADDR          := 0x1000000
TSW_PAD_ENDADDR            := 0x103FFFF
endif

##############################################################################################
###  Macro for define CRC range 
### 
ASWCRC_STARTADDR          := 0x1040000
ASWCRC_ENDADDR            := 0x15BFFFB
CRC_ADDR                  := 0x15BFFFE
DEL_ADDR                  := 0x103FFFF
CRC_CHECKSUM              := 14