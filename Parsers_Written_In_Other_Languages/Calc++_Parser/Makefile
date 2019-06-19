CXX = g++
CXXFLAGS = -Wall -g -std=c++11
OBJECTS = parser.o scanner.o calc++.o driver.o
parser:$(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o parser
parser.hh parser.cc:parser.yy
	bison -d parser.yy
scanner.hh scanner.cc:scanner.l
	flex scanner.l
.cc.o:
	$(CXX) $(CXXFLAGS) -c $<
clean:
	rm -f *.o *~ lex.yy.cc location.hh parser.hh parser.cc position.hh stack.hh parser scanner.cc scanner.hh
