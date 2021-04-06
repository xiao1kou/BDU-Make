#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by Robert Bosch GmbH, Schwieberdingen, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : PROGNAME.MAK
#
#   Version       : 2.5.2
#
#   Company       : Robert Bosch GmbH, Schwieberdingen, Germany
#
#   Department    : GS-EC/EMT2
#
#   Author(s)     : Martina Michel
#                   Ralf Hammer
#
#   Last Updated  : 04.04.2005
#
#   Functionality : Definition of the program name characteristics.
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   History:
#
#   Version   Date         Author   Description
#   ------------------------------------------------------------------------------------------
#   2.3       02.06.2005   RH       AFB 521 - $(Shell) command in Make
#                                   AFB 529 - Damos 3v6 Einbindung und Makeanpassungen
#                                   AFB 530 - COPY-Befehl
#                                   AFB 558 - Einbindung neue HT-Makeversion
#                                   AFB 567 - Erweiterungen MED17-SW-Sharing
#                                   AFB 572 - Zusätzlicher Eingabepar. für os_postprocess.pl
#                                   AFB 573 - Behandlung von Filelist *_conf.xml, zus. Makeo.
#                                   AFB 575 - Einheitliche Damos-Scripte
#                                   AFB 576 - Einbinden neues MMsyscond plug-in
#                                   AFB 597 - Korrektur der Prüfung Compilerversion
#                                   AFB 601 - Einschalten der -PIP-Option
#                                   AFB 604 - new Toolversion (Fdef_SW, MakeGen, Damos)
#                                   AFB 609 - Fehler bei local Copy des Mx17-Compilers
#                                   AFB 658 - Verschiedene Anpassungen an Make
#                                   ----------------------------------------------------------
#                                   Further and more detailed information can be found in the
#                                   corresponding release document in the subfolder 'doc'.
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#---------------------------------------------------------------------------------------------
#
#   PST information
#
#---------------------------------------------------------------------------------------------

ID_GENERATION          := G5
ID_PROJECT             := A1
PST_VAR                := 01A
DELIVERY_VAR           := 1








ifneq ($(ID_GENERATION),$(empty))

PST_NAME               := $(addprefix $(ID_GENERATION), \
                          $(addprefix $(ID_PROJECT),    \
                          $(addprefix $(PST_VAR),       \
                          $(DELIVERY_VAR))))
endif

#---------------------------------------------------------------------------------------------
#
#   PROGRAMM NAME
#
#---------------------------------------------------------------------------------------------




ifneq ($(PST_NAME),$(empty))

PROGRAMNAME            := $(PST_NAME)

else

PROGRAMNAME             = $(PLATFORM)

endif

