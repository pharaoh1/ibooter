CC = clang
TARGET = ibooter
uname_s = $(shell uname -s)
SRC = src
CFLAGS = -DDEBUG -c -I. -g -Wall -Wextra -Werror -o
LDFLAGS = -limobiledevice -lreadline -lusb-1.0 -lplist 
INSTALL_DIR = /usr/local/bin
DEBUG ?=
DEBUGYESNO ?=
DBG ?=


OBJECTS = src/main.o \
		  src/ibooter.o \
		  src/irecovery.o \
		  src/img3.o

# not sure I use it
ifeq ($(DEBUG), 1)
	DBG = -DDEBUG
	DEBUGYESNO = "with DEBUG flags"
	DEBUG-V = "-DEBUG"
endif

define print_success
	@echo "\033[0;32m$1\033[0m"
endef

default : all

all : $(TARGET)

$(TARGET) : $(OBJECTS)
	@echo " LD	$(TARGET)"
	@$(CC) $(OBJECTS) -o $(TARGET) $(LDFLAGS)
	$(call print_success, "Successfully built $(TARGET) for $(uname_s)")

$(SRC)/%.o: $(SRC)/%.c
	@echo " CC	$<"
	@$(CC)  $< $(CFLAGS) $@

install : $(TARGET)
	cp $(TARGET) $(INSTALL_DIR)

clean : 
	rm -rf src/*.o $(TARGET)

