#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by UAES, China & Robert Bosch GmbH, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : tricore_ghs_config.MAK
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
#   Functionality : configuration for TriCore ECU using GHS tool chain SW build
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   History:
#
#   Version   Date         Author   Description
#   ------------------------------------------------------------------------------------------
#   1.0.0   04.06.2021      Yuan Tao
#              N: New file for Tricore Build.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#---------------------------------------------------------------------------------------------
#
#  TriCore_ghs configuration
#
#---------------------------------------------------------------------------------------------
##############################################################################################
#   Macro : COMPSUITE_DIR
#   Note  : must be provided for each arch target!! Specifies compiler path for building v850e software
# 
COMPSUITE_DIR               := $(TOOLS_DISK)\ghs\comp_202015

##############################################################################################
#   Macro : START_OBJ_FILENAME
#   Value : {xxxx.o|empty|no} default:{empty},i.e. crt0.o in GHS standard library used as start file
#   Note  : Specifies the start obj file to be linked first. In principle, the entry point should reside in it
#
START_OBJ_FILENAME          :=

##############################################################################################
#   Macro : ENTRY_SYMBOL
#   Value : {xxxx|empty|no} default:{empty}, i.e. symbol _start used as the entry symbol
#   Note  : Specifies entry symbol of the final ELF. 
#
ENTRY_SYMBOL                := $(ENTRY_FUNCTION)

##############################################################################################
#   Macro : ENTRY_SYMBOL
#   Value : {xxxx|empty|no} default:{empty}, i.e. symbol _start used as the entry symbol
#   Note  : Specifies entry symbol of the final ELF. 
#
CORE_TYPE                   := tc1v162

##############################################################################################
#   Macro : MACRO_LABELS
#   Value : {LABEL[=xxx]} no default value
#   Note  : Specifies the macro labels used during compilation
# 
MACRO_LABELS                :=                             \
								GHS                        \
                                __ghs__                    \
								$(USER_MACRO)


##############################################################################################
#   Macro : CC_OPTS
#   Value : no default value
#   Note  : Compiling options for application modules. Do not edit this option arbitarily
#
CC_OPTS                     :=  \
                               -cpu=$(CORE_TYPE) \
                               --diag_error=12 \
                               -individual_attribute_data_sections \
							   -individual_pragma_data_sections \
                               -individual_data_sections \
                               -individual_section_name_extra_dot \
							   -gnu99 \
                               -c \
                               -language=c \
                               --no_commons \
                               -passsource \
                               --prototype_errors \
                               -Wshadow \
                               --warnings \
                               --ghstd=last \
                               -Wundef \
                               -Ospeed \
                               -Omax \
                               -ffunc \
                               -I- \
							   -g \
							   -dwarf2 \
							   $(USER_CC_OPTS)


##############################################################################################
#   Macro : CC_OPTS_CORE
#   Value : no default value
#   Note  : Compiling options for core modules. Do not edit this option arbitarily 
#
CC_OPTS_CORE                := $(CC_OPTS)

##############################################################################################
#   Macro : LINKOPTS
#   Value : no default value
#   Note  : Linker options. Do not edit this option arbitarily
#
LINKOPTS_ONE                  :=   \
                               -cpu=$(CORE_TYPE) \
							   -D__ghs__ \
							   -L$(COMPSUITE_DIR)\lib\tri162 \
							   -lmath_sf \
							   -lmath_sd \
							   -lind_sf \
							   -lind_sd \
							   -lansi \
							   -lsys \
							   $(USER_LINK_LIBS) \
                               -larch \
                               -individual_attribute_data_sections \
							   -individual_pragma_data_sections \
							   -individual_data_sections \
							   -individual_section_name_extra_dot \
							   -nostdlib \
							   -nostartfiles \
							   -relobj \
							   -Ospeed \
							   -Omax \
							   -ffunc \
							   -delete \
							   -Mn \
							   -Mx \
							   -Mu \
							   -T \
							   $(USER_LINK_ONE)

LINKOPTS_TWO                  :=   \
                               -cpu=$(CORE_TYPE) \
							   -D__ghs__ \
							   -L$(COMPSUITE_DIR)\lib\tri162 \
							   -lmath_sf \
							   -lmath_sd \
							   -lind_sf \
							   -lind_sd \
							   -lansi \
							   -lsys \
							   $(USER_LINK_LIBS) \
                               -larch \
                               -individual_attribute_data_sections \
							   -individual_pragma_data_sections \
							   -individual_data_sections \
							   -individual_section_name_extra_dot \
							   -nostdlib \
							   -nostartfiles \
							   -relobj \
							   -Ospeed \
							   -Omax \
							   -ffunc \
							   -delete \
							   -Mn \
							   -Mx \
							   -Mu \
							   -T \
							   $(USER_LINK_TWO)