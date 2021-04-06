#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by UAES, China & Robert Bosch GmbH, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : CONFIG.MAK
#
#   Version       : 1.0.0
#
#   Company       : UAES, China & Robert Bosch GmbH, Germany
#
#   Department    : UAES/XE/ESW
#
#   Author(s)     :    Yuan Tao
#
#   Last Updated  : 04.06.2021
#
#   Functionality : configuration of general BDU SW build
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   History:
#
#   Version   Date         Author   Description
#   ------------------------------------------------------------------------------------------
#   1.0.0   04.06.2021      Yuan Tao
#              N: Created as a cross-platform software build environment
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##############################################################################################
#   Macro : VERBOSE
#   Value : {empty} | "yes" (Default : {empty})
#   Note  : Activates verbose mode of make run.
VERBOSE                    :=

##############################################################################################
#   Macro : MAKEVERSION
#   Note  : indicate the version used.

MAKEVERSION                := 5.0.0

##############################################################################################
#   Macro : PARALLEL_EXECUTION
#   Value : {empty} | "2, 3, 4..." (Default : {empty})
#   Note  : This is the number of recipes to execute compiling at once, 
#   
PARALLEL_EXECUTION         := 8

##############################################################################################
#   Macro : ESTE_DIR
#   Note  : indicate home dir of SWB Makefile.
TOOLS_DISK                 := C:
TOOLS_DIR                  := $(TOOLS_DISK)\BCM_SWB
MAK_DIR                    := $(TOOLS_DISK)\BCM_SWB\makefile

##############################################################################################
#   Macro : PLATFORM NAME
#   Value : {empty} | Platform Name , eg. BCM3.0, BDU8_1,  etc(Default : {empty})
#   Note  : Name of platform
PLATFORM                   := BDU8_1
PROGRAMNAME                := $(PLATFORM)
# TODO:  add a rule mapping makefile to fulfill the configuration mapping from PLATFORM to MCU_TYPE, TOOLCHAIN, COMMON_INC_DIRS

##############################################################################################
#   Macro : MCU_TYPE
#   Value : {ppc563xm|i386}
#   Note  : Specifies MCU type
#
MCU_TYPE                   := tricore

##############################################################################################
#   Macro : MCU_ID
#   Value : {SPC582B50|SPC582B54|SPC582B60|SPC584B60|SPC584B64|SPC584B70|SPC584C70|SPC584C74|SPC584C80|SPC58EC70|SPC58EC74|SPC58EC80}
#               {SPC584G80|SPC584G84|SPC58EG80|SPC58EG84|SPC58NG80|SPC58NG84}
#            {TC399XP|TC397XP|TC387|TC377|TC375}
#   Note  : Specifies MCU ID
#
MCU_ID                     := TC399XP

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
ENTRY_FUNCTION             := 

##############################################################################################
###  Macro for User Macro Labels 
###e.g.: SYSTEM_H=\"system.h\"  GHS (seperate with blank)
USER_MACRO                 := 

##############################################################################################
###  Macro for User CC options 
###e.g.: -c99 -ghstd=none(seperate with blank)
USER_CC_OPTS               := -Iud/Bsw/Lin/Implementation -I_gen/swb/filegroup/includes/project

##############################################################################################
###  Macro for User Link libs 
###e.g.: -lsys -lmath(seperate with blank)
USER_LINK_LIBS             :=  
USER_LINK_ONE              := _gen/swb/module/build/rel_linker_cmd.lcf -map=_gen/swb/module/build/relocatable.map
USER_LINK_TWO              := _gen/swb/module/build/prj_linker_cmd.lcf -map=_gen/swb/module/build/MDGB_BasePVER.map