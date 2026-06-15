C3C = c3c
C3FLAGS = -l microhttpd
TARGET = webserver
SOURCE = webserver.c3

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(SOURCE)
	@echo "🔨 Building C3 webserver..."
	$(C3C) compile $(C3FLAGS) -o $@ $<

run: $(TARGET)
	@echo "🚀 Starting webserver on port 8080..."
	./$(TARGET)

clean:
	@echo "🧹 Cleaning..."
	rm -f $(TARGET)

test: $(TARGET)
	@echo "🧪 Testing webserver (start it first with 'make run')..."
	curl -s http://localhost:8080 | python3 -m json.tool 2>/dev/null || echo "Server not running. Start with 'make run'"
