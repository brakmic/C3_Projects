CC = gcc
C3C = c3c
CFLAGS = -Wall -fPIC
LDFLAGS = -L .

# Library files
LIB_SOURCES = mathlib.c
LIB_OBJECTS = $(LIB_SOURCES:.c=.o)
STATIC_LIB = libmath.a
SHARED_LIB = libmath.so

# C3 files
C3_SOURCE = main.c3
C3_STATIC = c3_static_demo
C3_SHARED = c3_shared_demo

all: $(STATIC_LIB) $(SHARED_LIB) $(C3_STATIC) $(C3_SHARED)

# Build static library
$(STATIC_LIB): $(LIB_OBJECTS)
		@echo "📚 Creating static library..."
		ar rcs $@ $^

# Build shared library
$(SHARED_LIB): $(LIB_SOURCES)
		@echo "📚 Creating shared library..."
		$(CC) $(CFLAGS) -shared $^ -o $@

# Compile C objects
%.o: %.c
		@echo "🔨 Compiling $<..."
		$(CC) $(CFLAGS) -c $< -o $@

# Build C3 with static linking
$(C3_STATIC): $(C3_SOURCE) $(STATIC_LIB)
		@echo "🔨 Building C3 (static)..."
		$(C3C) compile $< -l $(STATIC_LIB) $(LDFLAGS) -o $@

# Build C3 with shared linking
$(C3_SHARED): $(C3_SOURCE) $(SHARED_LIB)
		@echo "🔨 Building C3 (shared)..."
		$(C3C) compile $< -l math $(LDFLAGS) -o $@

clean:
		@echo "🧹 Cleaning..."
		rm -f *.o *.a *.so $(C3_STATIC) $(C3_SHARED)

test: all
		@echo "🧪 Testing static version:"
		./$(C3_STATIC)
		@echo ""
		@echo "🧪 Testing shared version:"
		LD_LIBRARY_PATH=. ./$(C3_SHARED)

.PHONY: all clean test