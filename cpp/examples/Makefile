include Makefile.h

all::

CODE_DIRS = progs stl classes inherit dyna tmpl io etc
all::
	@for DIR in $(CODE_DIRS); \
        do \
            (cd $$DIR; make all) \
        done
clean::
	@for DIR in $(CODE_DIRS); \
        do \
            (cd $$DIR; make clean) \
        done

