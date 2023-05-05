# RE-ASM68K CODING STYLE CONVENTIONS

This document contains the list of agreed-upon coding style conventions that
are used in the scope of re-asm68k project. The purpose of code style
conventions is to unify the looks and feels for source code files for easier
reading, and therefore to aid debugging and shrink the possibility of
introducing bugs in the resulting programs.

The document covers several aspects of the source code presentation, and is split to
several sections accordingly:
- _Naming:_ on the choice of identifiers for the various elements in the program
- _Modularization:_ on organizing the program into interconnected components
- _Functions:_ on how to (preferrably) write functions
- _Comments:_ on the source code comments
- _File structure:_ on the source code organization within a single file
- _Formatting:_ on how are the syntactic elements of the C language should be written
- _Miscellaneous:_ on everything else that didn't fit to any of the sections

Each section contains a set of guidelines to the matter.

## 1. Naming

**The functions, types, global variables and enumeration constants are named**
**with ``UpperCamelCase``.** The ``main`` function is an exception.

**The local variables, struct and union members are named with**
**``lowerCamelCase``.**

**The C preprocessor macros are named with ``SCREAMING_CASE``.** However, if the
macro is designed to replace some function or variable, it might be named
however is appropriate. The purpose of ``SCREAMING_CASE`` usage for macro
names is to make them visibly distinct in the source code.

Underscores in names are not allowed. They are reserved for namespaces and
function variants, like this:

```c
void DecodeData_File(FILE* file);
void DecodeData_RawData(const unsigned char* data, size_t size);
```

## 2. Modularization

### 2.1 Module interface

If a set of types, functions, variables and constants (we'll call them
_entities_ for brevity from now on) provide a specific subset of services to the whole
program, it can be said they constitute a _module_.

Every module has an exported set of entities, which we'll be calling an
_interface_. The module interface is generally provided with a header file
(``*.h``) that contains, first and foremost, a set of function declarations,
may contain inline functions, variables and constants declarations, and a set
of types required to support the declarations.

**<a id='rule-module-naming'></a>Every entity within the module interface must have a prefix that resembles the**
**module name.** Exceptions can be made for modules of general-purpose functions
that do not provide a specific service, but rather a set of convenience
functions that can be used everywhere.

In cases where a module's sole purpose is to provide a data structure and a
set of functions to manipulate it, it's allowed to give a structure type the
name of a module, without prefix.

An example of module interface, for a simple singly-linked list module:
```c
#include <stddef.h>
#include <stdbool.h>

typedef struct List_Node {
	int value;
	struct List_Node* next;
} List_Node;

typedef struct {
	size_t size;
	List_Node* first;
	List_Node* last;
} List;

List* List_New(void);
void List_Delete(List* list);
void List_PushBack(List* list, int value);
void List_PushFront(List* list, int value);
bool List_PopBack(List* list, int value);
bool List_PopFront(List* list, int value);
List_Node* List_Find(List* list, int value);
bool List_Remove(List* list, int value);
```

As a rule of thumb, modules interfaces should not expose implementation
details, if doing so can be avoided.

### 2.2 Module private data

If the whole implementation of a module can be contained within a single
``*.c`` file, every function and variable should be declared with ``static``
specifier. **In general, if the function or variable is not designed to be**
**used or seen outside of the file in question, it should be declared with**
**``static`` specifier as well.** Do note that ``static`` entities don't
have to obey [module naming rules](#rule-module-naming), as they won't be
seen anywhere and therefore won't pollute global namespace.

If, however, the module consists from several files, and these files have to
share some entities, one way to do it is to create a separate header file,
that will contain declarations of said entities. A certain measures should
probably be taken to ensure this header file won't be included anywhere else
by accident.

## 3. Functions

Most importantly, **functions should do a single thing, and do it well.** Other
aspects matter less, as they're not always achievable in C. It won't hurt to 
make functions short (25 lines or less) and using no more than 6 local variables,
but please **do not pursue function shortness for the sake of it.** Forcing your
functions to be short regardless of the situation will likely result in
convoluted hard-to-follow logic splintered all over the file in small 
functions, which is no better than a long function, in the end.

It's also desirable to let functions be testable: no side effects where 
possible, simple input, simple output.

## 4. Comments

Both ``//`` and ``/* */`` comments are acceptable, but multiline comments
should follow the following template. 

1. First line contains ``/*`` and nothing else.
2. Last line contains ``*/`` and nothing else.
3. Intermediate lines start with a tab, and then have the content.

Functions can be documented with Doxygen comments, to provide useful 
information about the function. Some IDE's or editors are able to
parse it and provide documentation for the function as you call it.

Doxygen comments are multiline comments that start with ``/**`` instead of
``/*``. Here's an example of the Doxygen comment for a function.

```c
/**
	\brief Short summary of what the function is doing.

	\details More information on the function. Please provide it if you believe
	it is unclear how the function works. You can also provide here information
	as to where the function is used.
	
	\param a The description for the function parameter. It can span multiple 
	lines if needed to.

	\param b The description for another function parameter. Repeat it until all
	the parameters described.
	
	\returns Whatever the function returns. It doesn't need to be there if the
	return type is void.
*/
int foo(int a, int b);
```

## 5. File structure

Every file should have following structure:

1. File includes
2. Macro definitions
3. Type definitions
4. Function declarations
5. Variable declarations (for header files)
6. Variable definitions (for source files)
7. Function definitions (along with inline functions)

## 6. Formatting

Tabs should be used for indentation.

Lines should not be longer than 120 characters. Try to account that your lines
would extend if tabs get stretched on another device, so try not to go for
strictly 120 characters, unless you work with 8-character wide tabs. Try going for
shorter lines (80 or 100 would be optimal everywhere).

Everything that opens a scope, must put opening brace on the same line, not on
a separate line, be it a either a function, or a ``struct``/``union``/``enum`` definition or
a statement, or anything else:
```c
// OK
struct Something {
	// ...
};

// OK
void foo(void) {
	// OK
	if (condition) {
		// ...
	}

	// OK
	switch (number) {
		// OK
		case 1: {
			// ...
		}
	}
}

// Not OK
void bar()
{
	// ...
}
```

``else``-clause must have all the braces on the same line:
```c
// OK
if (condition) {
	// ...
} else {
	// ...
}

// Not OK
if (condition) {
	// ...
} 
else {
	// ...
}
```

``if``-statements should always have braces:
```c
// OK
if (condition) {
	// ...
}

// Not OK
if (condition)
	// ...

// Not OK
if (condition) // ...
```

``switch``-statement must indent both ``case`` and the code in it:
```c
// OK
switch (number) {
	case 1:
		// ...
		break;
}

// Not OK
switch (number) {
case 1:
	// ...
	break;
}
```

``if``/``for``/``while`` statements must have a space before the opening
parenthesis:
```c
// OK
if (condition) {
	// ...
}

// Not OK
if(condition) {
	// ...
}
```

Function calls should not have a space before the opening parethesis:
```c
// OK
sin(M_PI / 2);

// Not OK
sin (M_PI / 2);
```

Unary operators should not have any space before them:
```c
// OK
a = -1;

// Not OK
b = - a;
```

Type cast operators should not have any space before them:
```c
// OK
a = (char)b;

// Not OK
c = (char) d;
```

Binary operators have no restrictions on spacing:
```c
// OK
a = b + c * d;

// OK
a = b+c*d;

// OK
a = b + c*d;

// OK, but... why?
a = b  +c *   d;
```

Pointers should be aligned to the type:
```c
int* p; // OK
int *q; // Not OK
```

Type qualifiers (``const`` and ``volatile``) should go before the type:
```c
const int a; // OK
int const b; // Not OK
```

However, to declare a constant pointer to non-constant data, you'd have to 
write right-hand qualifier anyway, so it will be allowed for this case:
```c
int* const cp; // OK
```

Type specifiers (``static``, ``extern``, and ``inline``) should be on the same
line as the rest of the declaration:
```c
extern int a; // OK

extern
int b; // Not OK

// OK
static inline void foo() {
	// ...
}

// Not OK
static inline
void foo() {
	// ...
}
```

If your argument list in the function declaration or the call doesn't fit on a
single line, it should be split on several lines like this:
```c
void foo(
	int a, int b, char c, double d, // imagine line limit here
	char const* e);

longFunction(
	1, 2, 3, 4, 5, 6, 7, // imagine line limit here
	"eight", '9', 10);
```

If the expression is too long, it should be split with operators on the right
side, like this:
```c
int x = aaaaaaaaaaaaaaaaaaaaaaaa + // imagine line limit here
	bbbbbbbbbbbbbbbbb +
	cccccccccccccccccc;
```

## 7. Miscellaneous

Never use double underscores (``__``) in the identifiers. They are reserved.

Never use leading underscore with a capital letter (``_A``) in the beginning
of an identifier. They are also reserved.

Whenever defining a ``struct``/``union``/``enum``, do it with ``typedef``:
```c
typedef struct {
	int thing;
} TypeName;
```

If the defined ``struct`` has to reference itself, there are two ways to do 
this:
```c
// First way
typedef struct TypeName {
	int thing;
	struct TypeName* next;
} TypeName;

// Second way
typedef struct TypeName TypeName;

struct TypeName {
	int thing;
	TypeName* next;
};
```

``#include``d files should be sorted by the source library and alphabetically:
```c
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include <lib_a/bottle.h>
#include <lib_a/speed.h>
#include <lib_a/trash.h>

#include <lib_b/await.h>
#include <lib_b/please.h>
#include <lib_b/xeno.h>
#include <lib_b/yield.h>
```

Whenever defining an inline function, please write ``static inline``. Just 
``inline`` does not do what you probably expected. It would be a good idea to
do this somewhere:
```c
#define INLINE static inline
```
and write ``INLINE`` everywhere else. 

If you want to use ``bool`` type, please include ``<stdbool.h>`` header. 
C doesn't have ``bool``, only ``_Bool``. All this header does is:
```c
#define bool _Bool
#define true 1
#define false 0
```
