# Scalar type is double
SCALAR_TYPE= XM_SCALAR_DOUBLE
# Scalar type is float
#SCALAR_TYPE= XM_SCALAR_FLOAT
# Scalar type is double complex
#SCALAR_TYPE= XM_SCALAR_DOUBLE_COMPLEX
# Scalar type is float complex
#SCALAR_TYPE= XM_SCALAR_FLOAT_COMPLEX

# cc with Netlib BLAS
CC= cc
CFLAGS= -D$(SCALAR_TYPE) -Wall -Wextra -g
LDFLAGS= -L/usr/local/lib
LIBS= -lblas -lpthread -lm

# Intel Compiler with MKL on Linux (release build)
#CC= icc
#CFLAGS= -D$(SCALAR_TYPE) -DNDEBUG -Wall -Wextra -O3 -openmp -I./compat -mkl=sequential
#LDFLAGS=
#LIBS= -lpthread -lm

# Clang with Netlib BLAS on FreeBSD (debug build)
#CC= clang
#CFLAGS= -D$(SCALAR_TYPE) -Weverything -Wno-gnu-imaginary-constant -Wno-padded -Wno-used-but-marked-unused -Wno-missing-noreturn -Wno-format-nonliteral -fcolor-diagnostics -g -DHAVE_ARC4RANDOM -DHAVE_BITSTRING_H -DHAVE_TREE_H
#LDFLAGS= -L/usr/local/lib -L/usr/local/lib/gcc48
#LIBS= -lblas -lgfortran -lpthread -lm

# GNU gcc with Netlib BLAS on Linux (debug build)
#CC= gcc
#CFLAGS= -D$(SCALAR_TYPE) -Wall -Wextra -g -I./compat
#LDFLAGS=
#LIBS= -lblas -lpthread -lm

# Clang with Netlib BLAS on OpenBSD (debug build)
#CC= clang
#CFLAGS= -D$(SCALAR_TYPE) -Weverything -Wno-source-uses-openmp -Wno-padded -Wno-used-but-marked-unused -Wno-missing-noreturn -Wno-format-nonliteral -fcolor-diagnostics -g -DHAVE_ARC4RANDOM -DHAVE_BITSTRING_H -DHAVE_TREE_H
#LDFLAGS= -L/usr/local/lib
#LIBS= -lblas -lg2c -lpthread -lm

EXAMPLE= example
EXAMPLE_O= example.o
TEST= test
TEST_O= test.o

AUX_O= auxil.o
XM_A= xm.a
XM_O= alloc.o blockspace.o xm.o

AR= ar rc
RANLIB= ranlib

all: $(EXAMPLE) $(TEST)

$(EXAMPLE): $(AUX_O) $(XM_A) $(EXAMPLE_O)
	$(CC) -o $@ $(CFLAGS) $(EXAMPLE_O) $(AUX_O) $(XM_A) $(LDFLAGS) $(LIBS)

$(TEST): $(AUX_O) $(XM_A) $(TEST_O)
	$(CC) -o $@ $(CFLAGS) $(TEST_O) $(AUX_O) $(XM_A) $(LDFLAGS) $(LIBS)

$(XM_A): $(XM_O)
	$(AR) $@ $(XM_O)
	$(RANLIB) $@

check: $(TEST)
	@./test 30 2>/dev/null

dist:
	git archive --format=tar.gz --prefix=libxm/ -o libxm.tgz HEAD

clean:
	rm -f $(XM_A) $(XM_O) $(AUX_O)
	rm -f $(EXAMPLE) $(EXAMPLE_O) $(TEST) $(TEST_O)
	rm -f *.core xmpagefile xmpagefile.* libxm.tgz

.PHONY: all check clean dist
