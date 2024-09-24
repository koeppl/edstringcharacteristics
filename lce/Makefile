CPPFILE=lce.cpp
CXX = g++
MYCXXFLAGS  = -ggdb -Wall -pedantic -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -std=c++14
TARGET = lce.x
all: $(TARGET)

$(TARGET): $(CPPFILE)
	$(CXX) $(MYCXXFLAGS) $(CXXFLAGS) -o $(TARGET) $(CPPFILE)

clean:
	$(RM) $(TARGET)
