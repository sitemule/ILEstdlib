
BIN_LIB=ilestdlib
DBGVIEW=*ALL
TARGET_CCSID=*JOB

# Do not touch below
INCLUDE='/QIBM/include' 'header/'
CCFLAGS=OPTIMIZE(10) ENUM(*INT) TERASPACE(*YES) STGMDL(*INHERIT) SYSIFCOPT(*IFSIO) INCDIR($(INCLUDE)) DBGVIEW($(DBGVIEW)) TGTCCSID($(TARGET_CCSID))

all: deps main

deps:
	system "CRTCMOD MODULE($(BIN_LIB)/PARMS) SRCSTMF('src/parms.c') $(CCFLAGS)"
	system "CRTCMOD MODULE($(BIN_LIB)/RTVSYSVAL) SRCSTMF('src/rtvsysval.c') $(CCFLAGS)"
	system "CRTCMOD MODULE($(BIN_LIB)/VARCHAR) SRCSTMF('src/varchar.c') $(CCFLAGS)"

main:
	system "CRTCMOD MODULE($(BIN_LIB)/STRING) SRCSTMF('src/string.c') $(CCFLAGS)"