#include <stdbool.h>
#include <assert.h>
#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ITER(VAR, FROM, BELOW) for (int VAR = FROM; VAR<BELOW; VAR++)
#define FORII(BELOW) ITER(ii, 0, BELOW)
#include "data.h"

/*
	# Datatypes
*/
#define NAME_MAX 256
struct File_s;
struct Stat_s;
struct Dll_n;
struct Dll_file_s;
struct Dll_link_s;
struct Dll_name_s;

// Token data type
typedef enum Token_t_
 { Token_null_t_
 , Token_mnemonic_t_
 , Token_name_t_
 , Token_number_t_
 , Token_string_t_
 , Token_symbol_t_
 } Token_t_;

// File statistics
typedef struct Stat_s {
    long line_c; // File line count
    long stmt_c; // Processed statment count
    long assm_c; // Assembly statment count
    long comp_c; // Compiler statment count
    long dire_c; // Directive statment count
    long link_c; // Link statment count
    long name_c; // Name directive count
    long code_c; // Code directive count
    long data_c; // Data directive count
    long code_s; // Code size
    long data_s; // Data size
    long file_s; // File size
} Stat_s;

// File structure
typedef struct File_s {
	char     *name;             // File name
	FILE     *file;             // File pointer
	char     *mode;             // I/O  mode
	char      line[NAME_MAX+1]; // I/O  line buffer
	Token_t_  type;             // Data type
	long      data;             // Data value
	int       size;             // Data size (byte)
	int       m;                // Memory select
	int       x;                // Index select
	Stat_s   *stat;             // File statistics
} File_s;

// Dual Link List
typedef enum Dll_t_
 { Dll_null_t_ // Null (unknown type)
 , Dll_head_t_ // List header
 , Dll_file_t_ // File
 , Dll_name_t_ // Name
 , Dll_link_t_ // Link
 } Dll_t_;

typedef struct Dll_n {
	struct Dll_n *next, *prev;
	Dll_t_ type; // Datatype
	void *data; // Data pointer
} Dll_n;

typedef struct Dll_file_s {
	char *name;
	Stat_s *stat;
} Dll_file_s;

/* `size' is in bytes and `mode' is reserved. */
typedef struct Dll_name_s {
	char *name;
	long data;
	int mode, size;
} Dll_name_s;

/* `mode' is the invoking instruction. */
typedef struct Dll_link_s {
	char *name, *file;
	long addr;
	int mode;
} Dll_link_s;

void Error (int program, int code, File_s * In, void *data) {
	typedef unsigned u;
	errx(1,"Error: %d %d 0x%x 0x%x", program, code, (u)In, (u)data); }

/*
	# Doubly-Linked Lists (DLL)
*/

/*
	Returns pointer 'n' to newly allocated and nullified dual link
	list node with associated data structure of type 't'.
*/
Dll_n *Dll_New (Dll_t_ t) {
	Dll_n *n; /* Dll node */
	Dll_file_s *f; /* File structure */
	Dll_link_s *k; /* Link structure */
	Dll_name_s *d; /* Name structure */

	/* New Node */
	if (!(n = (Dll_n *) malloc(sizeof(Dll_n))))
		Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
	n->next = NULL;
	n->prev = NULL;
	n->data = NULL;
	n->type = t;

	/* New Data Structure */
	switch (t) {
		/* Error */
	default:
		Error(0x1F, 0x10, NULL, NULL); /* Invalid dll data type */
		/* Null */
	case Dll_null_t_:
	case Dll_head_t_:
		break;
		/* File */
	case Dll_file_t_:
		if (!(n->data = malloc(sizeof(Dll_file_s))))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		f = (Dll_file_s *) n->data;
		if (!(f->name = (char *)malloc(NAME_MAX + 1)))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		f->name[0] = '\0';
		f->stat = NULL;
		break;
		/* Link */
	case Dll_link_t_:
		if (!(n->data = malloc(sizeof(Dll_link_s))))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		k = (Dll_link_s *) n->data;
		if (!(k->name = (char *)malloc(NAME_MAX + 1)))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		k->name[0] = '\0';
		if (!(k->file = (char *)malloc(NAME_MAX + 1)))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		k->file[0] = '\0';
		k->addr = 0;
		k->mode = 0;
		break;
		/* Name */
	case Dll_name_t_:
		if (!(n->data = malloc(sizeof(Dll_name_s))))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		d = (Dll_name_s *) n->data;
		if (!(d->name = (char *)malloc(NAME_MAX + 1)))
			Error(0x1F, 0x07, NULL, NULL); /* Failed malloc() */
		d->name[0] = '\0';
		d->data = 0;
		d->size = 0;
		d->mode = 0;
		break; }
	return n; }

/*
	Frees either the headered list or non-headered node 'l'.
*/
void Dll_Free (Dll_n * l) {
	int list_f = 0; /* List flag */
	Dll_n *m; /* Dll node 1 */
	Dll_n *n; /* Dll node 2 */
	Dll_file_s *f; /* File structure */
	Dll_link_s *k; /* Link structure */
	Dll_name_s *d; /* Name structure */

	/* Repair List */
	if (l) {
		if (l->type == Dll_head_t_) {
			list_f = 1;
			if (l->prev)
				l->prev->next = NULL; }
		else {
			if (l->prev)
				l->prev->next = l->next;
			if (l->next)
				l->next->prev = l->prev; } }
	/* Free Data Structure */
	for (n = l; n; n = m) {
		switch (n->type) {
			/* Unknown */
		default:
			printf("Warning: Memory leak\n");
			break;
			/* Null */
		case Dll_null_t_:
		case Dll_head_t_:
			break;
			/* File */
		case Dll_file_t_:
			if ((f = (Dll_file_s *) n->data)) {
				free(f->name);
				free(f->stat);
				free(f); }
			break;
			/* Link */
		case Dll_link_t_:
			if ((k = (Dll_link_s *) n->data)) {
				free(k->name);
				free(k->file);
				free(k); }
			break;
			/* Name */
		case Dll_name_t_:
			if ((d = (Dll_name_s *) n->data)) {
				free(d->name);
				free(d); }
			break; }

		/* Free Node */
		m = n->next;
		free(n);

		if (!list_f)
			break; }
	return; }

/*
	Sorted insertion of node 'i' into headered list 'l' by the rule
	associated with 'i->type'.
*/
void Dll_Insert (Dll_n * l, Dll_n * i) {
	Dll_n *n; /* Dll node */

	if (i) {
		if (!l)
			Error(0x21, 0x25, NULL, NULL); /* Null list */
		if (l->type != Dll_head_t_)
			Error(0x21, 0x08, NULL, NULL); /* Headerless list */

		/* Sorting Logic */
		for (n = l; n->next; n = n->next) { /* Find node before insert */
			switch (i->type) {
				/* File */
			default:
			case Dll_null_t_:
			case Dll_head_t_:
			case Dll_file_t_:
				break;
				/* Link */
			case Dll_link_t_:
				goto INSERT;
				/* Name */
			case Dll_name_t_:
				if (0 >
				    strcmp(((Dll_name_s *) i->data)->name,
					   ((Dll_name_s *) n->next->
					    data)->name))
					goto INSERT;
				break; } }

		/* Insert Node */
 INSERT:
		i->prev = n;
		i->next = n->next;
		if (n->next)
			n->next->prev = i;
		n->next = i; }
	return; }

/*
	Sorted search of node 't' in headered list 'l' by the rule
	associated with 'i->type'.  If a match is found, the pointer to
	the node is returned, else NULL.
*/
Dll_n *Dll_Find (Dll_n * l, Dll_n * t) {
	int o; /* Offset */
	Dll_n *m = NULL;
	Dll_n *n = NULL;
	Dll_file_s *f = NULL; /* File structure */
	Dll_link_s *k = NULL; /* Link structure */
	Dll_name_s *d = NULL; /* Name structure */

	if (t) {
		/* Initialize Find */
		if (!l)
			Error(0x22, 0x25, NULL, NULL); /* Null list */
		if (l->type != Dll_head_t_)
			Error(0x22, 0x08, NULL, NULL); /* Headerless list */

		switch (t->type) {
		default:
		case Dll_null_t_:
		case Dll_head_t_:
			Error(0x22, 0x14, NULL, NULL); /* Invalid find type */
		case Dll_file_t_:
			f = (Dll_file_s *) t->data;
			break;
		case Dll_link_t_:
			k = (Dll_link_s *) t->data;
			break;
		case Dll_name_t_:
			d = (Dll_name_s *) t->data;
			break; }

		/* Find */
		for (n = l->next; n; n = n->next) {
			switch (t->type) {
				/* File */
			case Dll_file_t_:
				if ((n->type == Dll_file_t_)
				    &&
				    (!strcmp
				     (f->name, ((Dll_file_s *) n->data)->name)))
					goto FOUND;
				break;
				/* Link */
			case Dll_link_t_:
				if ((n->type == Dll_link_t_)
				    && (!strcmp(k->name, ((Dll_link_s *) n->data)->name)) /* Same name */
				    && (!strcmp(k->file, ((Dll_link_s *) n->data)->file)) /* Same file */
				    && ((0xFF0000 & k->addr) == (0xFF0000 & ((Dll_link_s *) n->data)->addr))) { /* Same bank */
					o = (0xFFFF &
					     (((Dll_link_s *) n->data)->addr)) -
					    (0xFFFF & k->addr);
					if (k->name[0] == '+' && o < 0) /* Correct direction */
						break;
					if (k->name[0] == '-' && o > 0)
						break;
					/* if(branch) Within reach */
					if ((k->mode == 0x10 /* BPL */
					     || k->mode == 0x30 /* BMI */
					     || k->mode == 0x50 /* BVC */
					     || k->mode == 0x70 /* BVS */
					     || k->mode == 0x80 /* BRA */
					     || k->mode == 0x90 /* BCC or BLT */
					     || k->mode == 0xB0 /* BCS or BGE */
					     || k->mode == 0xD0 /* BNE */
					     || k->mode == 0xF0) /* BEQ */
					    && ((o >= 0 && o > 128)
						|| (o <= 0 && o <= -128)))
						continue;
					if (!m)
						m = n;
					else if (abs(o) < abs((0xFFFF & (((Dll_link_s *) m->data)->addr)) - ((0xFFFF & k->addr)))) /* Closests */
						m = n; }
				break;
				/* Name */
			case Dll_name_t_:
				if ((n->type == Dll_name_t_)
				    &&
				    (!strcmp
				     (d->name, ((Dll_name_s *) n->data)->name)))
					goto FOUND;
				break;
			default:
				assert(true); } }
		if (t->type == Dll_link_t_)
			n = m;
 FOUND: ; }
	return n; }

/* Push node 'n' on headered list 'l'. */
void Dll_Push (Dll_n * l, Dll_n * n) {
	if (n) {
		/* Error testing */
		if (!l)
			Error(0x23, 0x25, NULL, NULL); /* Null list */
		if (l->type != Dll_head_t_)
			Error(0x23, 0x08, NULL, NULL); /* Headerless list */

		/* Push */
		n->next = l->next;
		n->prev = l;
		l->next = n;
		if (n->next)
			n->next->prev = n; }
	return; }

/* Pull and return node 'n' from headered list 'l'. */
Dll_n *Dll_Pull (Dll_n * l) {
	Dll_n *n = NULL;

	/* Error testing */
	if (!l)
		Error(0x23, 0x25, NULL, NULL); /* Null list */
	if (l->type != Dll_head_t_)
		Error(0x23, 0x08, NULL, NULL); /* Headerless list */

	/* Pull */
	if (l->next) {
		n = l->next;
		if (n->next)
			n->next->prev = l;
		l->next = n->next;
		n->next = NULL;
		n->prev = NULL; }
	return n; }

/* Prints either the headered list or non-headered node 'l'. */
void Dll_Print (Dll_n * l) {
	int list_f = 0; /* List flag */
	Dll_n *n; /* Dll node */
	Dll_file_s *f; /* File structure */
	Dll_link_s *k; /* Link structure */
	Dll_name_s *d; /* Name structure */
	Stat_s *s; /* File statistics */

	if (l && l->type == Dll_head_t_)
		list_f = 1;
	for (n = l; n; n = n->next) {
		switch (n->type) {
			/* Error */
		default:
			printf("Warning: Unknown node type\n\n");
			break;
			/* Null */
		case Dll_null_t_:
			printf("Null\n\n");
			break;
			/* Header */
		case Dll_head_t_:
			break;
			/* File */
		case Dll_file_t_:
			f = (Dll_file_s *) n->data;
			s = (Stat_s *) f->stat;
			printf("Name: %s\n"
			       "Statistics\n"
			       "==========\n"
			       "line_c: %li\n"
			       "stmt_c: %li\n"
			       "assm_c: %li\n"
			       "comp_c: %li\n"
			       "dire_c: %li\n"
			       "link_c: %li\n"
			       "name_c: %li\n"
			       "code_c: %li\n"
			       "data_c: %li\n"
			       "code_s: %lx\n"
			       "data_s: %lx\n"
			       "file_s: %lx\n\n",
			       f->name, s->line_c, s->stmt_c,
			       s->assm_c, s->comp_c, s->dire_c,
			       s->link_c, s->name_c, s->code_c,
			       s->data_c, s->code_s, s->data_s, s->file_s);
			break;
			/* Link */
		case Dll_link_t_:
			k = (Dll_link_s *) n->data;
			printf("Name: %s\n"
			       "File: %s\n"
			       "Addr: %lx\n"
			       "Mode: %i\n\n",
			       k->name, k->file, k->addr, k->mode);
			break;
			/* Name */
		case Dll_name_t_:
			d = (Dll_name_s *) n->data;
			printf("Name: %s\n"
			       "Data: %lx\n"
			       "Size: %i\n\n", d->name, d->data, d->size);
			break; }
		if (!list_f)
			break; }
	return; }

int Dll_Size (Dll_n * l) {
	int i = 0;
	Dll_n *n;
	if (!l)
		Error(0x26, 0x25, NULL, NULL); /* Null list */
	if (l->type != Dll_head_t_)
		Error(0x26, 0x08, NULL, NULL); /* Headerless list */
	for (n = l->next; n; n = n->next, i++) ;
	return i; }

/*
	# File Management
*/
File_s *New_File (char *name, char *mode) {
	File_s *f;
	Stat_s *s;

	/* File structure */
	if (!(f = (File_s *) malloc(sizeof(File_s))))
		Error(0x14, 0x07, NULL, NULL); /* Failed malloc() */
	/* Mode */
	if (!mode)
		Error(0x14, 0x24, NULL, NULL); /* Null file mode */
	if (!(f->mode = (char *)malloc(strlen(mode) + 1)))
		Error(0x14, 0x07, NULL, NULL); /* Failed malloc() */
	f->mode[0] = '\0';
	strcat(f->mode, mode);
	if (!(f->name = (char *)malloc(strlen(name) + 1)))
		Error(0x14, 0x07, NULL, NULL); /* Failed malloc() */
	f->name[0] = '\0';
	strcat(f->name, name);
	/* File */
	if (!(f->file = fopen(name, mode)))
		Error(0x14, 0x06, NULL, name); /* Failed fopen() */
	fseek(f->file, 0, SEEK_SET); /* Reset file pointer */
	f->line[0] = '\0';
	/* Data */
	f->data = 0;
	f->size = 0;
	f->type = Token_null_t_;
	/* State */
	f->m = 1;
	f->x = 1;
	/* Statistic */
	if (!(s = (Stat_s *) malloc(sizeof(Stat_s))))
		Error(0x14, 0x07, NULL, NULL); /* Failed malloc() */
	s->line_c = 0;
	s->stmt_c = 0;
	s->assm_c = 0;
	s->comp_c = 0;
	s->dire_c = 0;
	s->link_c = 0;
	s->name_c = 0;
	s->code_c = 0;
	s->data_c = 0;
	s->code_s = 0;
	s->data_s = 0;
	s->file_s = 0;
	f->stat = s;

	return f; }

void Free_File (File_s * f) {
	fclose(f->file);
	free(f->name); free(f->mode); free(f->stat); free(f);
	return; }

/*
	# Global Variables
	`Snes_f' is the memory map flag. 0 for native, 1 for LoRom,
	and 2 for HiRom.
*/
long PC = 0x000000;
int Snes_f = 0;
bool Report_f = false;
File_s *Out;
char *Inf, *Outf;
char Line[1024];

Dll_n *Global_Code, *Global_Data, *Global_Name;
Dll_n *Global_Name_R, *Global_Link, *Global_Link_R;
Dll_n **Global_Dlls[6] =
	{ &Global_Code, &Global_Data, &Global_Name, &Global_Name_R
	, &Global_Link, &Global_Link_R };

void PrintReport (void) {
	if (!Report_f) return;
	printf("================================\n"
	       "| #Name |\n"
	       "================================\n");
	Dll_Print(Global_Name);
	printf("================================\n"
	       "| #Code |\n"
	       "================================\n");
	Dll_Print(Global_Code);
	printf("================================\n"
	       "| #Data |\n"
	       "================================\n");
	Dll_Print(Global_Data); }

/* File Format */
/* Returns TRUE if character 'c' is whitespace, else FALSE. */
int Is_Whitespace (char c) {
	return (c == ' ' || c == '\t' || c == '\v' || c == '\n' || c == '\r'
		|| c == '\f') ? 1 : 0; }

/* Returns TRUE if character 'c' is namespace, else FALSE. */
int Is_Namespace (char c) {
	return (('0' <= c && c <= '9') || ('A' <= c && c <= 'Z')
		|| ('a' <= c && c <= 'z') || c == '_' || c == '.') ? 1 : 0; }

/* Returns TRUE if character 'c' is numberspace, else FALSE. */
/* IMPORTANT!! '%','$','b','w','l' are NOT numberspaces. */
int Is_Numberspace (char c) {
	return (('0' <= c && c <= '9') || ('A' <= c && c <= 'F')
		|| c == ':') ? 1 : 0; }

/* Returns TRUE if string 's' is valid name, else FALSE. */
int Is_Name(char *s) {
	int i = strlen(s);

	if (i && i <= NAME_MAX && !('0' <= s[0] && s[0] <= '9')
	    && Is_Namespace(s[0])) {
		while (--i)
			if (!Is_Namespace(s[i]))
				return 0;
		return 1; }
	return 0; }

/*
	# File Scanning
	`Get_Token' returns next token and data type from in file. Token
	data types are null, name, number, string, and symbol. Tokens are
	contingous strings of the following characters:
		- Null: EOF
		- Number: `[0-9A-Fbwl%$:]+'
		- Name: `[0-9A-Za-z_.]+'
		- String: `"[^"]*"'
		- Symbol: `[;#{}[\]()=*+-/\\\,]+'

	See documentation for more detailed token syntax.
*/
void Get_Token (File_s * In) {
	Token_t_ r = Token_null_t_;
	FILE *f = In->file;
	char *ib = In->line;
	char c = c = fgetc(f);
	int i = 0;

	/* Get non-space character */
	for (; !feof(f) && Is_Whitespace(c); c = fgetc(f))
		if (c == '\n')
			In->stat->line_c++;
	if (feof(f))
		goto RETURN;
	ib[i++] = c;
	switch (c) {

		/* Symbol */
	case ';':
	case '#':
	case '{':
	case '}':
	case '[':
	case ']':
	case '(':
	case ')':
	case '=':
	case '+':
	case '-':
	case '*':
	case '/':
	case ',':
	case '\\':
		r = Token_symbol_t_;
		goto RETURN;

		/* Number */
	case ':':
	case '%':
	case '$':
	case '0':
	case '1':
	case '2':
	case '3':
	case '4':
	case '5':
	case '6':
	case '7':
	case '8':
	case '9':
		r = Token_number_t_;
		for (c = fgetc(f);
		     !feof(f) && Is_Numberspace(c) && i < NAME_MAX - 1;
		     c = fgetc(f))
			ib[i++] = c;
		if (feof(f))
			goto RETURN;
		if (c == 'b' || c == 'w' || c == 'l') {
			ib[i++] = c;
			goto RETURN; }
		ungetc(c, f);
		break;

		/* String */
	case '"':
		r = Token_string_t_;
		for (i--, c = fgetc(f); !feof(f) && i < NAME_MAX; c = fgetc(f)) {
			ib[i++] = c;
			/* Escape sequence */
			if (c == '\\') {
				c = fgetc(f);
				if (feof(f))
					break;
				switch (c) {
					/* '\\' Backslash */
				case '\\':
					ib[i - 1] = '\\';
					continue;
					/* '\"' Double quote */
				case '"':
					ib[i - 1] = '"';
					continue;
					/* '\:' Semicolon */
				case ':':
					ib[i - 1] = ';';
					continue;
				default:
					Error(0x1A, 0x11, In, (void *)&c); /* Invalid escape sequence */ } }
			/* Split string */
			if (c == '"') {
				i--;
				for (c = fgetc(f); !feof(f) && Is_Whitespace(c);
				     c = fgetc(f))
					if (c == '\n')
						In->stat->line_c++;
				if (feof(f) || c != '"') {
					ungetc(c, f);
					goto RETURN; }
				continue; } }
		Error(0x1A, 0x20, In, NULL); /* Invalid string */

		/* Name */
	default:
		if (!Is_Namespace(c))
			Error(0x1A, 0x22, In, NULL); /* Invalid token */
		for (c = fgetc(f); !feof(f) && Is_Namespace(c) && i < NAME_MAX;
		     c = fgetc(f))
			ib[i++] = c;
		if (!feof(f))
			ungetc(c, f);
		ib[i] = '\0';
		if (!Is_Name(ib))
			Error(0x1A, 0x1A, In, (void *)ib); /* Invalid name */
		if (i == 3) {
			for (i = 0; 'A' <= ib[i] && ib[i] <= 'Z';) {
				if (++i == 3) {
					r = Token_mnemonic_t_;
					goto RETURN; } }
			i = 3; }
		r = Token_name_t_;
		break; }

	/* Return */
 RETURN:
	ib[i] = '\0';
	In->type = r;
	return; }

/*
	Advances the Program Counter by 'i' bytes. Result depends on the
	memory map utilized. Returns TRUE if the increment crosses a boundry
	(be it bank or memory map), else FALSE.
*/
int Advance_PC (long i) {
	int bank_f;

	if (i < 0)
		Error(0x1E, 0x27, NULL, NULL); /* PC decremented */
	for (bank_f = 0; i > 0; i--) {
		if (!(++PC & 0xFFFF)) {
			bank_f = 1;
			/* SNES memory map */
			if (Snes_f) {
				if (!(PC & 0x400000))
					PC += 0x8000;
				if ((0x7E0000 <= PC && PC <= 0x7FFFFF)
				    || PC > 0xFFFFFF)
					Error(0x1E, 0x29, NULL, NULL); /* ROM overflow */ }
			else {
				/* Native memory map */
				if (PC > 0xFFFFFF)
					Error(0x1E, 0x29, NULL, NULL); /* ROM overflow */ } } }
	return bank_f; }

/*
	`Read_Operand' determines the numeric value 'In->data' and width
	'In->size' of the number/name operand 'In->line'. If the operand
	is a name, a name reference will be recorded on 'Global_Name_R'.
*/
void Read_Operand (File_s * In) {
	char digit[] = "0123456789ABCDEF";
	char *ib = In->line;
	Dll_n *n1;
	Dll_n *n2;
	Dll_name_s *d1;
	Dll_name_s *d2;
	int b; /* base */
	int d; /* digit */
	int m; /* magnitude */
	int s; /* size (byte) */
	int i;
	int j;

	In->data = 0;
	In->size = 0;
	switch (In->type) {
	default:
		Error(0x1B, 0x1C, In, NULL); /* Invalid operand */
		/* Name */
	case Token_name_t_:
		n1 = Dll_New(Dll_name_t_);
		d1 = (Dll_name_s *) n1->data;

		/* Reference suffix */
		i = strlen(ib);
		if (i > 2 && !strcmp(&ib[i - 2], ".l")) {
			ib[i - 2] = '\0';
			d1->mode = 0; }
		if (i > 2 && !strcmp(&ib[i - 2], ".h")) {
			ib[i - 2] = '\0';
			d1->mode = 1; }
		if (i > 2 && !strcmp(&ib[i - 2], ".b")) {
			ib[i - 2] = '\0';
			d1->mode = 2; }
		d1->data = PC;
		strcat(d1->name, ib);
		d1->size = 3;
		if (!(n2 = Dll_Find(Global_Name, n1)))
			if (!(n2 = Dll_Find(Global_Code, n1)))
				if (!(n2 = Dll_Find(Global_Data, n1))) {
					Dll_Print(Global_Data);
					Error(0x1B, 0x2C, In, (void *)n1); /* Undeclared reference */ }
		d2 = (Dll_name_s *) n2->data;
		In->size = d2->size;
		In->data = 0;
		Dll_Push(Global_Name_R, n1);
		break;

	case Token_number_t_:
		/* Get base prefix */
		for (i = 0; ib[i] == ':' && ib[i] != '\0'; i++) ;
		switch (ib[i]) {
		default:
			if (Is_Numberspace(ib[i])) {
				b = 10;
				break; }
			Error(0x1B, 0x1B, In, ib); /* Invalid number */
		case '%':
			i++;
			b = 2;
			break;
		case '$':
			i++;
			b = 16;
			break; }

		/* Get width suffix */
		for (j = 0; ib[i] != '\0'; i++, j++) ;
		i--, j--;
		switch (ib[i]) {
		case 'b':
			i--, j--;
			In->size = 1;
			break;
		case 'w':
			i--, j--;
			In->size = 2;
			break;
		case 'l':
			i--, j--;
			In->size = 3;
			break;
		default:
			break; }

		/* String to integer */
		for (m = 1, s = 0; j >= 0; i--, j--) {
			if (ib[i] == ':')
				continue;
			for (d = 0; ib[i] != digit[d]; d++) {
				switch (b) {
				case 2:
					if (d > 1)
						Error(0x1B, 0x0C, In,
						      (void *)ib);
					break;
				case 10:
					if (d > 9)
						Error(0x1B, 0x0E, In,
						      (void *)ib);
					break;
				case 16:
					if (d > 15)
						Error(0x1B, 0x15, In,
						      (void *)ib);
					break; } }
			In->data += (unsigned int)d *m;
			m *= b;
			s++; }

		/* Check size */
		switch (b) {
		case 2:
			if (s % 8 || s / 8 > 3)
				Error(0x1B, 0x0C, In, (void *)ib); /* Invalid bin number */
			if (In->size && In->size != s / 8)
				Error(0x1B, 0x26, In, (void *)ib); /* Operand width mismatch */
			In->size = s / 8;
			break;
		case 10:
			switch (In->size) {
			default:
				Error(0x1B, 0x0E, In, (void *)ib); /* Invalid dec number */
			case 0:
				 /**/ if (0 <= In->data && In->data <= 0xFF)
					In->size = 1;
				else if (0 <= In->data && In->data <= 0xFFFF)
					In->size = 2;
				else if (0 <= In->data && In->data <= 0xFFFFFF)
					In->size = 3;
				else
					Error(0x1B, 0x0E, In, (void *)ib); /* Invalid dec number */
				break;
			case 1:
				if (!(0 <= In->data && In->data <= 0xFF))
					Error(0x1B, 0x26, In, (void *)ib);
				break; /* Operand width mismatch */
			case 2:
				if (!(0 <= In->data && In->data <= 0xFFFF))
					Error(0x1B, 0x26, In, (void *)ib);
				break; /* Operand width mismatch */
			case 3:
				if (!(0 <= In->data && In->data <= 0xFFFFFF))
					Error(0x1B, 0x26, In, (void *)ib);
				break; /* Operand width mismatch */ }
			break;
		case 16:
			if (s % 2 || s / 2 > 3)
				Error(0x1B, 0x15, In, (void *)ib); /* Invalid hex number */
			if (In->size && In->size != s / 2)
				Error(0x1B, 0x26, In, (void *)ib); /* Operand width mismatch */
			In->size = s / 2;
			break; }
		break; }
	return; }

/*
	`Do_Assembly' assembles a 65816 assembly statment.
*/
void Do_Assembly (File_s * In) {
	/* Opcode = Set[(M)nemonic].(A)ddressing_mode; */
	/* `m' is the Mnemonic */
	char c;
	int a, i, j, m;
	Dll_n *n;
	Dll_link_s *k;
	char *ib = In->line; /* Input buffer */
	FILE *f = In->file;

	/* Identify Mnemonic */
	for (m = 0; strcmp(ib, Set[m].mnemonic);)
		if (++m >= MNEMONIC_COUNT)
			Error(0x06, 0x19, In, (void *)ib);

	/* Identify Addressing Mode */
	if (Advance_PC(1))
		Error(0x06, 0x28, In, NULL);
	if (Set[m].addr_m[0] != -1) {
		/* Implied */
		In->data = 0;
		In->size = 0;
		a = imp_; }
	else {
		/* Operand */
		Get_Token(In);
		switch (In->type) {
		default:
			Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
			/* NAME */
		case Token_name_t_:
			/* Accumulator */
			if (!strcmp(ib, "A")) {
				In->data = 0;
				In->size = 0;
				a = a_;
				break; }
			/* NUMBER */
		case Token_number_t_:
			Read_Operand(In);
			Get_Token(In);
			if (strcmp(ib, ",")) {
				/* Direct */
				if (!strcmp(ib, ";"))
					ungetc(';', f);
				/**/ if (In->size == 1)
					a = b_;
				else if (In->size == 2)
					a = w_;
				else if (In->size == 3)
					a = l_;
				else
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */ }
			else {
				/* Indexed*/
				Get_Token(In);
				switch (In->type) {
				default:
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				case Token_name_t_:
					/* Stack Indexed */
					if (!strcmp(ib, "S")) {
						/**/ if (In->size == 1)
							a = bs_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						break; }
					/* X Indexed */
					if (!strcmp(ib, "X")) {
						 /**/ if (In->size == 1)
							a = bx_;
						else if (In->size == 2)
							a = wx_;
						else if (In->size == 3)
							a = lx_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						break; }
					/* Y Indexed */
					if (!strcmp(ib, "Y")) {
						/**/ if (In->size == 1)
							a = by_;
						else if (In->size == 2)
							a = wy_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						break; }
				case Token_number_t_:
					/* Block Move */
					if (In->size != 1)
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
					j = In->data;
					if (Advance_PC(1))
						Error(0x06, 0x28, In, NULL); /* Program crossed bank boundary */
					Read_Operand(In);
					PC--;
					if (In->size != 1)
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
					In->data += (j << 8);
					In->size = 2;
					a = bm_;
					break; } }
			break;
			/* SYMBOL*/
		case Token_symbol_t_:
			switch (ib[0]) {
			default:
				Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				/* Immediate*/
			case '#':
				Get_Token(In);
				if (In->type != Token_number_t_
				    && In->type != Token_name_t_)
					Error(0x06, 0x05, In, NULL); /* Expected operand */
				Read_Operand(In);
				switch (m) {
				default:
					if ((In->size == 2 && In->m == 0)
					    || (In->size == 1 && In->m == 1))
						break;
					Error(0x06, 0x09, In, NULL); /* Immediate size mismatch */
				case 23: /* CPX */
				case 24: /* CPY */
				case 37: /* LDY */
				case 38: /* LDX */
					if ((In->size == 2 && In->x == 0)
					    || (In->size == 1 && In->x == 1))
						break;
					Error(0x06, 0x09, In, NULL); /* Immediate size mismatch */
				case 60: /* REP */
					if (In->size == 1) {
						In->x =
						    (0x10 & In->
						     data) ? 0 : In->x;
						In->m =
						    (0x20 & In->
						     data) ? 0 : In->m;
						break; }
					Error(0x06, 0x09, In, NULL); /* Immediate size mismatch */
				case 70: /* SEP */
					if (In->size == 1) {
						In->x =
						    (0x10 & In->
						     data) ? 1 : In->x;
						In->m =
						    (0x20 & In->
						     data) ? 1 : In->m;
						break; }
					Error(0x06, 0x09, In, NULL); /* Immediate size mismatch */ }
				a = i_;
				break;
				/* Indirect*/
			case '(':
				Get_Token(In);
				if (In->type != Token_number_t_
				    && In->type != Token_name_t_)
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				Read_Operand(In);
				Get_Token(In);
				if (In->type != Token_symbol_t_)
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				switch (ib[0]) {
				default:
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				case ')':
					Get_Token(In);
					if (strcmp(ib, ",")) {
						/* Indirect */
						if (!strcmp(ib, ";"))
							ungetc(';', f);
						/**/ if (In->size == 1)
							a = bi_;
						else if (In->size == 2)
							a = wi_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */ }
					else {
						/* Indirect Y Indexed */
						Get_Token(In);
						if (strcmp(ib, "Y"))
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						/**/ if (In->size == 1)
							a = biy_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */ }
					break;
					/* Indexed*/
				case ',':
					Get_Token(In);
					if (In->type != Token_name_t_
					    || strlen(ib) != 1)
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
					switch (ib[0]) {
					default:
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						/* S Indexed Indirect Y Indexed */
					case 'S':
						Get_Token(In);
						if (In->type != Token_symbol_t_
						    || strcmp(ib, ")"))
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						Get_Token(In);
						if (In->type != Token_symbol_t_
						    || strcmp(ib, ","))
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						Get_Token(In);
						if (In->type != Token_name_t_
						    || strcmp(ib, "Y"))
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						/**/ if (In->size == 1)
							a = bsiy_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						break;
						/* X Indexed Indirect */
					case 'X':
						Get_Token(In);
						if (In->type != Token_symbol_t_
						    || strcmp(ib, ")"))
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						/**/ if (In->size == 1)
							a = bxi_;
						else if (In->size == 2)
							a = wxi_;
						else
							Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
						break; } }
				break;
				/* Indirect Long*/
			case '[':
				Get_Token(In);
				if (In->type != Token_number_t_
				    && In->type != Token_name_t_)
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				Read_Operand(In);
				Get_Token(In);
				if (strcmp(ib, "]"))
					Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
				Get_Token(In);
				if (strcmp(ib, ",")) {
					/* Indirect Long */
					if (!strcmp(ib, ";"))
						ungetc(';', f);
					/**/ if (In->size == 1)
						a = bl_;
					else if (In->size == 2)
						a = wl_;
					else
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */ }
				else {
					/* Indirect Long Y Indexed */
					Get_Token(In);
					if (strcmp(ib, "Y"))
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */
					/**/ if (In->size == 1)
						a = bly_;
					else
						Error(0x06, 0x0B, In, NULL); /* Invalid addressing mode */ }
				break;
				/* Link*/
			case '{':
				In->data = 0;
				In->size = 0;
				n = Dll_New(Dll_link_t_);
				k = (Dll_link_s *) n->data;
				if (m == 3 /* BCC */
				    || m == 4 /* BCS */
				    || m == 5 /* BEQ */
				    || m == 6 /* BGE */
				    || m == 8 /* BLT */
				    || m == 9 /* BMI */
				    || m == 10 /* BNE */
				    || m == 11 /* BPL */
				    || m == 12 /* BRA */
				    || m == 15 /* BVC */
				    || m == 16) { /* BCS */
					a = 3;
					In->size = 1; }
				if (m == 14 || m == 33) { /* BRL or JMP */
					a = 14;
					In->size = 2; }
				if (In->size == 0)
					Error(0x06, 0x18, In, NULL); /* Invalid link */
				Get_Token(In);
				if (!strcmp(ib, "+") || !strcmp(ib, "-")) {
					for (i = 1, c = fgetc(f);
					     !feof(f) && i <= NAME_MAX
					     && (Is_Namespace(c) || c == '+'
					     || c == '-');
					     i++, c = fgetc(f))
						ib[i] = c;
					ib[i] = '\0';
					ungetc(c, f); }
				strcat(k->name, ib);
				strcat(k->file, In->name);
				k->addr = PC;
				k->mode = Set[m].addr_m[a];
				Dll_Push(Global_Link_R, n);
				Get_Token(In);
				if (strcmp(ib, "}"))
					Error(0x06, 0x18, In, NULL); /* Invalid link */
				break; }
			break; } }
	/* Output */
	if (a != 0 && Set[m].addr_m[a] == -1)
		Error(0x06, 0x17, In, NULL); /* Invalid instruction */
	fputc((char)Set[m].addr_m[a], Out->file);
	for (i = 0, j = In->data; i < In->size; i++)
		fputc((char)j & 0xFF, Out->file), j = j >> 8;
	Advance_PC(In->size);
	In->stat->code_s += 1 + In->size;
	In->stat->assm_c++;
	return; }

/*
	`Do_Link' records link statments to 'Global_Link'.
*/
void Do_Link (File_s * In) {
	int i;
	char c, *ib = In->line;
	FILE *f = In->file;
	Dll_n *n;
	Dll_link_s *k;

	/* Record Label */
	n = Dll_New(Dll_link_t_);
	k = (Dll_link_s *) n->data;
	Get_Token(In);
	if (!strcmp(ib, "+") || !strcmp(ib, "-")) {
		for (i = 1, c = fgetc(f);
		     !feof(f) && i <= NAME_MAX && (Is_Namespace(c) || c == '+'
						   || c == '-');
		     i++, c = fgetc(f)
		    )
			ib[i] = c;
		ib[i] = '\0';
		ungetc(c, f); }

	strcat(k->name, ib);
	strcat(k->file, In->name);
	k->addr = PC;
	Dll_Push(Global_Link, n);
	Get_Token(In);
	if (strcmp(ib, "}"))
		Error(0x08, 0x32, In, NULL); /* Usage [{][+/-][link][}] */
	In->stat->link_c++; }

/*
	`Dir_Block' handles block comments which begin with `#{' and end
	with `#}'. Comments must be nested, and a warning will be issued
	if pairs are unbalanced.
*/
void Dir_Block (File_s * In) {
	char c;
	FILE *f = In->file;
	char *ib = In->line;
	Stat_s *s = In->stat;

	switch (ib[0]) {
	case '{':
		for (;;) {
			for (c = fgetc(f); !feof(f) && c != ';'; c = fgetc(f))
				if (c == '\n')
					s->line_c++;
			if (feof(f)) {
				printf("Warning: Unbalanced #{\n");
				return; }
			s->stmt_c++;
			do {
				Get_Token(In);
			} while (!strcmp(ib, ";"));
			if (strcmp(ib, "#"))
				continue;
			ib[0] = fgetc(f);
			if (feof(f) || (ib[0] != '{' && ib[0] != '}'))
				continue;
			switch (ib[0]) {
			case '{':
				Dir_Block(In);
				continue;
			case '}':
				return; } }
	case '}':
		printf("Warning: Unbalanced #}\n");
		return; }}

/*
	`PC_to_File' converts a program counter address into an out file
	address.
*/
long PC_to_File (long p) {
	long f = 0;

	if (p < 0 || p > 0xFFFFFF)
		Error(0x1D, 0x1E, NULL, (void *)(&p)); /* Invalid program counter */
	/* SNES memory map */
	if (Snes_f) {
		if ((0x7E0000 <= p && p <= 0x7FFFFF)
		    || (!(p & 0x400000) && !(p & 0x8000)))
			Error(0x1D, 0x1E, NULL, (void *)(&p)); /* Invalid program counter */
		if (Snes_f == 2)
			p -= 0x800000;
		if (p >= 0x400000)
			f += 0x200000 + ((p >> 16) - 0x40) * 0x10000 +
			    (p & 0xFFFF);
		else
			f += (p >> 16) * 0x8000 + (p & 0x7FFF); }
	else { /* Native memory map */ f = p; }
	return f; }



/* Directive_Code() */
/* #Code addr { name } , ... */
/* Creates an instance of a Code type. The address associated */
/* with code can be declared explicitly or automatically. */
void Dir_Code (File_s * In) {
	char *ib = In->line;
	Dll_n *n1;
	Dll_n *n2;
	Dll_name_s *d1;
	Dll_name_s *d2;

	do {
		/* Build Code Node */
		n1 = Dll_New(Dll_name_t_);
		d1 = (Dll_name_s *) n1->data;
		Get_Token(In);
		/* Data*/
		if (!strcmp(ib, "w") || !strcmp(ib, "l")) {
			/* Prototype (word,long) */
			switch (ib[0]) {
			case 'w':
				d1->size = 2;
				break;
			case 'l':
				d1->size = 3;
				break; }
			d1->data = -1; }
		else {
			/* Immediate */
			if (In->type != Token_number_t_)
				Error(0x0B, 0x2E, In, NULL); /* Usage [#Code][addr][{][name][}][,] ... */
			Read_Operand(In);
			if (In->size < 2 || In->size > 3)
				Error(0x0B, 0x01, In, NULL); /* Address out of range */
			d1->size = In->size;
			d1->data = In->data; }
		/* Name*/
		Get_Token(In);
		if (!strcmp(ib, "{")) {
			/* Definition */
			if (d1->data != -1) {
				if (d1->size == 2)
					d1->data =
					    (PC & 0xFF0000) | (d1->data &
							       0x00FFFF);
				Advance_PC(PC_to_File(d1->data) -
					   PC_to_File(PC));
				if (PC_to_File(d1->data) < PC_to_File(PC))
					Error(0x0B, 0x27, In, NULL); /* PC decremented */
				fseek(Out->file, PC_to_File(d1->data),
				      SEEK_SET); }
			d1->data = PC;
			Get_Token(In);
			if (In->type != Token_name_t_)
				Error(0x0B, 0x2E, In, NULL); /* Usage [#Code][addr][{][name][}][,] ... */
			strcat(d1->name, ib);
			Get_Token(In);
			if (strcmp(ib, "}"))
				Error(0x0B, 0x2E, In, NULL); /* Usage [#Code][addr][{][name][}][,] ... */ }
		else {
			/* Protoytpe */
			if (In->type != Token_name_t_)
				Error(0x0B, 0x2E, In, NULL); /* Usage [#Code][addr][{][name][}][,] ... */
			strcat(d1->name, ib); }

		/* Reference Code Node */
		if (Dll_Find(Global_Name, n1) || Dll_Find(Global_Data, n1))
			Error(0x0B, 0x04, In, (void *)n1); /* Conflicting declarations */
		if ((n2 = Dll_Find(Global_Code, n1))) {
			/* Cross check size */
			d2 = (Dll_name_s *) n2->data;
			if (d2->size != d1->size)
				Error(0x0B, 0x04, In, (void *)n1); /* Conflicting declarations */
			/* Cross check data */
			if (d1->data != -1) {
				if (d2->data != -1) {
					if (d1->data != d2->data)
						Error(0x0B, 0x04, In, (void *)n1); /* Conflicting declarations */
					return; }
				/* Update definition */
				d2->data = d1->data; }}
		else {
			Dll_Insert(Global_Code, n1);
			In->stat->code_c++; }
		Get_Token(In);
	} while (!strcmp(ib, ","));
	if (!strcmp(ib, ";"))
		ungetc(';', In->file);
	return; }

/* #M , #X, #Y, #m, #x, #y */
void Dir_Cpu (File_s * In) {
	switch (In->line[0]) {
	case 'M':
		In->m = 1;
		break;
	case 'X':
	case 'Y':
		In->x = 1;
		break;
	case 'm':
		In->m = 0;
		break;
	case 'x':
	case 'y':
		In->x = 0;
		break; }
	return; }

/* #Data data=number,name,string,file */
void Dir_Data (File_s * In) {
	char *ib = In->line;
	FILE *f;
	FILE *o = Out->file;
	Dll_n *n1;
	Dll_n *n2;
	Dll_name_s *d1;
	Dll_name_s *d2;
	int c;
	int i;
	int j;

	do {
		/* Build Data Node */
		n1 = Dll_New(Dll_name_t_);
		d1 = (Dll_name_s *) n1->data;
		d1->data = -1;
		Get_Token(In);
		/* Data*/
		if (!strcmp(ib, "w") || !strcmp(ib, "l")) {
			/* Prototype (word,long) */
			switch (ib[0]) {
			case 'w':
				d1->size = 2;
				break;
			case 'l':
				d1->size = 3;
				break; }}
		else {
			/* Immediate */
			if (!strcmp(ib, "{"))
				goto DEFINITION;
			if (In->type != Token_number_t_)
				Error(0x0D, 0x2F, In, NULL); /* Usage [#Data][addr][name][{][data][}][,] ... */
			Read_Operand(In);
			if (In->size < 2 || In->size > 3)
				Error(0x0D, 0x01, In, NULL); /* Address out of range */
			d1->size = In->size;
			d1->data = In->data; }
		/* Name*/
		Get_Token(In);
		if (!strcmp(ib, "{"))
			goto DEFINITION;
		if (In->type != Token_name_t_)
			Error(0x0D, 0x2F, In, NULL); /* Usage [#Data][addr][name][{][data][}][,] ... */
		strcat(d1->name, ib);
		Get_Token(In);
		if (!strcmp(ib, "{")) {
			/* Definition */
 DEFINITION:
			if (d1->data != -1) {
				if (d1->size == 2)
					d1->data =
					    (PC & 0xFF0000) | (d1->data &
							       0x00FFFF);
				Advance_PC(PC_to_File(d1->data) -
					   PC_to_File(PC));
				if (PC_to_File(d1->data) < PC_to_File(PC))
					Error(0x0D, 0x27, In, NULL); /* PC decremented */
				fseek(Out->file, PC_to_File(d1->data),
				      SEEK_SET); }
			d1->data = PC;
			for (Get_Token(In); strcmp(ib, "}");) {
				if (In->type == Token_null_t_)
					Error(0x0D, 0x2F, In, NULL); /* Usage [#Data][addr][name][{][data][}][,] ... */
				switch (In->type) {
				default:
					Error(0x0D, 0x0D, In, (void *)ib); /* Invalid data */
				case Token_number_t_:
				case Token_name_t_:
					Read_Operand(In);
					for (i = 0, j = In->data; i < In->size; i++) {
						fputc((char)j & 0xFF,
						      Out->file);
						j = j >> 8; }
					In->stat->data_s += In->size;
					Advance_PC(In->size);
					break;
				case Token_string_t_:
					In->size = strlen(ib);
					for (i = 0; i < In->size; i++)
						fputc(ib[i], o);
					In->stat->data_s += In->size;
					Advance_PC(In->size);
					break;
				case Token_symbol_t_:
					/* Data file */
					if (strcmp(ib, "#"))
						Error(0x0D, 0x0D, In, (void *)ib); /* Invalid data */
					Get_Token(In);
					if (In->type == Token_null_t_)
						Error(0x0D, 0x0D, In, (void *)ib); /* Invalid data */
					if (!(f = fopen(ib, "rb")))
						Error(0x00, 0x00, In, (void *)"Failed fopen()"); /* DEBUG */
					for (c = fgetc(f), j = 0; !feof(f);
					     c = fgetc(f), j++)
						fputc(c, o);
					fclose(f);
					In->stat->data_s += j;
					Advance_PC(j);
					break; }
				Get_Token(In);
				if (!strcmp(ib, ","))
					Get_Token(In); } }
		if (!strcmp(ib, ";"))
			ungetc(';', In->file);
		/* Reference Data Node */
		if (!strcmp(d1->name, "")) {
			In->stat->data_c++; }
		else {
			if (Dll_Find(Global_Name, n1)
			    || Dll_Find(Global_Code, n1))
				Error(0x0D, 0x04, In, (void *)n1); /* Conflicting declarations */
			if ((n2 = Dll_Find(Global_Data, n1))) {
				/* Cross check size */
				d2 = (Dll_name_s *) n2->data;
				if (d2->size != d1->size)
					Error(0x0D, 0x04, In, (void *)n1); /* Conflicting declarations */
				/* Cross check data */
				if (d1->data != -1) {
					if (d2->data != -1) {
						if (d1->data != d2->data)
							Error(0x0D, 0x04, In, (void *)n1); /* Conflicting declarations */
						return; }
					/* Update definition */
					d2->data = d1->data; }}
			else {
				Dll_Insert(Global_Data, n1);
				In->stat->data_c++; } }
		Get_Token(In);
	} while (!strcmp(ib, ","));
	if (!strcmp(ib, ";"))
		ungetc(';', In->file);
	return; }

/* #Halt */
void Second_Pass();
void Dir_Halt (File_s * In) {
	Second_Pass();

	/* Report */
	In->stat->stmt_c++;
	In->stat->file_s = PC_to_File(PC);
	PrintReport();

	/* Cleanup */
	Free_File(Out);
	Dll_Free(Global_Code);
	Dll_Free(Global_Data);
	Dll_Free(Global_Name);
	Dll_Free(Global_Name_R);
	Dll_Free(Global_Link);
	Dll_Free(Global_Link_R);

	exit(0); }

/* #Name */
void Dir_Name (File_s * In) {
	char *t = In->line;
	Dll_n *n1;
	Dll_n *n2;
	Dll_name_s *d1;
	Dll_name_s *d2;

	do {
		/* Build Name Node */
		n1 = Dll_New(Dll_name_t_);
		d1 = (Dll_name_s *) n1->data;
		Get_Token(In);

		/* Data*/
		if (!strcmp(t, "b") || !strcmp(t, "w") || !strcmp(t, "l")) {
			/* Prototype (byte,word,long) */
			switch (t[0]) {
			case 'b':
				d1->size = 1;
				break;
			case 'w':
				d1->size = 2;
				break;
			case 'l':
				d1->size = 3;
				break; }
			d1->data = -1; }
		else {
			/* Declaration */
			if (In->type != Token_number_t_)
				Error(0x10, 0x30, In, NULL); /* Usage [#Name][data][name][,] ... */
			Read_Operand(In);
			d1->size = In->size;
			d1->data = In->data; }
		/* Name*/
		Get_Token(In);
		if (In->type != Token_name_t_)
			Error(0x10, 0x30, In, NULL); /* Usage [#Name][data][name][,] ... */
		strcat(d1->name, t);

		/* Reference Name Node */
		if (Dll_Find(Global_Code, n1) || Dll_Find(Global_Data, n1))
			Error(0x10, 0x04, In, (void *)n1); /* Conflicting declarations */
		if ((n2 = Dll_Find(Global_Name, n1))) {
			/* Cross check size */
			d2 = (Dll_name_s *) n2->data;
			if (d2->size != d1->size)
				Error(0x10, 0x04, In, (void *)n1); /* Conflicting declarations */
			/* Cross check data */
			if (d1->data != -1) {
				if (d2->data != -1) {
					if (d1->data != d2->data)
						Error(0x10, 0x04, In, (void *)n1); /* Conflicting declarations */
					return; }
				/* Update definition */
				d2->data = d1->data; }}
		else {
			Dll_Insert(Global_Name, n1);
			In->stat->name_c++; }
		Get_Token(In);
	} while (!strcmp(t, ","));
	if (!strcmp(t, ";"))
		ungetc(';', In->file);
	return; }

/* #PC [+][data][pad] */
void Dir_PC (File_s * In) {
	FILE *f = In->file;
	char *t = In->line;
	int i;
	int n;
	int a; /* Advance PC count */
	int o_f = 0; /* Offset flag */

	/* Get PC Operand */
	Get_Token(In);
	/* [+] Relative Offset */
	if (!strcmp(t, "+")) {
		o_f = 1;
		Get_Token(In); }
	if (In->type != Token_number_t_)
		Error(0x11, 0x31, In, NULL); /* Usage [#PC][+][addr][,][pad] */
	Read_Operand(In);

	/* Advance Program Counter */
	n = In->data;
	if (o_f) { /* Offset */ a = n; }
	else {
		/* Direct */
		if (In->size != 3)
			Error(0x11, 0x01, In, NULL); /* Address out of range */
		if (Snes_f && (n < PC || (0x7E0000 <= n && n <= 0x7FFFFF)
			       || (0x800000 <= n && PC < 0x800000)
			       || (!(n & 0x800000) && !(n & 0x8000))))
			Error(0x11, 0x01, In, NULL); /* Address out of range */
		a = PC_to_File(n) - PC_to_File(PC); }
	Advance_PC(a);

	/* Advance File Pointer */
	Get_Token(In);
	if (!strcmp(t, ",")) {
		/* Padding */
		Get_Token(In);
		if (In->type != Token_number_t_)
			Error(0x11, 0x31, In, NULL); /* Usage [#PC][+][addr][,][pad] */
		Read_Operand(In);
		for (i = 0, n = In->data; a > 0; a--, i++) {
			if (i >= In->size) {
				i = 0;
				n = In->data; }
			fputc((char)n & 0xFF, Out->file);
			n = n >> 8; }
		/* No Padding */ }
	else {
		if (!strcmp(t, ";"))
			ungetc(';', f);
		fseek(Out->file, a, SEEK_CUR); }
	return; }

/* #Print */
void Dir_Print (File_s * In) {
	FILE *f = In->file;
	char c = fgetc(f);

	if (!feof(f) && Is_Whitespace(c))
		c = fgetc(f);
	for (; !feof(f) && c != ';'; c = fgetc(f)) {
		if (c == '\n')
			In->stat->line_c++;
		printf("%c", c); }
	ungetc(';', f);
	return; }

/* #LoRom #HiRom */
void Dir_Rom (File_s * In) {
	if (PC != 0x000000 || In->stat->stmt_c != 0)
		Error(0x13, 0x0A, In, NULL); /* Invalid #Lo/#HiROM */
	if (!strcmp(In->line, "LoROM")) { Snes_f = 1; PC = 0x008000; }
	else { /* HiROM */ Snes_f = 2; PC = 0x808000; }
	return; }

/* Identify and execute assembler directive. */
void Do_Directive (File_s * In) {
	FILE *f = In->file;
	char *ib = In->line, c = fgetc(f);

	/* Get Directive */
	/* Comment */
	if (feof(f) || Is_Whitespace(c) || c == ';') {
		if (!feof(f)) {
			if (c == '\n')
				In->stat->line_c++;
			if (c == ';')
				ungetc(';', f); }
		return; }
	ungetc(c, f);
	Get_Token(In);

	/* Identify Directive */

	/* Comment */
	/**/ if (!strcmp(ib, "{") /* ++ */
		 || !strcmp(ib, "}"))
		Dir_Block(In); /* ++ */
	else if (!strcmp(ib, "Print"))
		Dir_Print(In); /* ++ */
	/* Declaration */
	else if (!strcmp(ib, "Name"))
		Dir_Name(In); /* ++ */
	else if (!strcmp(ib, "Code"))
		Dir_Code(In); /* ++ */
	else if (!strcmp(ib, "Data"))
		Dir_Data(In); /* ++ */
	/* Assembler Flow */
	else if (!strcmp(ib, "M") /* ++ */
		 || !strcmp(ib, "X") /* ++ */
		 || !strcmp(ib, "Y") /* ++ */
		 || !strcmp(ib, "m") /* ++ */
		 || !strcmp(ib, "x") /* ++ */
		 || !strcmp(ib, "y"))
		Dir_Cpu(In); /* ++ */
	else if (!strcmp(ib, "PC"))
		Dir_PC(In); /* ++ */
	else if (!strcmp(ib, "LoROM") /* ++ */
		 || !strcmp(ib, "HiROM"))
		Dir_Rom(In); /* ++ */
	else if (!strcmp(ib, "Halt"))
		Dir_Halt(In); /* ++ */
	/* Error */
	else
		Error(0x09, 0x0F, In, ib); /* Invalid directive */

	In->stat->dire_c++;
	return; }


/* General Functions */





/* Program Counter */

/* Converts an out file address into a program counter address. */
/* ============================================================== */
long File_to_PC (long f) {
	long p = 0;

	if (f < 0 || f > 0xFFFFFF)
		Error(0x1C, 0x13, NULL, (void *)(&f)); /* Invalid file pointer */
	/* SNES memory map */
	if (Snes_f) {
		if (Snes_f == 2)
			p += 0x800000;
		if (f >= 0x200000)
			p += 0x200000 + f;
		else
			p += (f / 0x8000) * 0x10000 + f % 0x8000 + 0x8000;
		if (f < 0 || f >= 0x600000 || (Snes_f == 1 && p >= 0x7E0000))
			Error(0x1C, 0x13, NULL, (void *)(&f)); /* Invalid file pointer */ }
	else { /* Native memory map */ p = f; }
	return p; }


void First_Pass () {
	/* `t' is the current input token. */
	File_s *In;
	Stat_s *s;
	FILE *f;
	Dll_n *n;
	Dll_file_s *d;
	char c, *t;

	/* Open Input File */
	n = Dll_New(Dll_file_t_);
	d = (Dll_file_s *) n->data;
	strcat(d->name, Inf);

	In = New_File(Inf, "r");
	f = In->file;
	t = In->line;
	s = d->stat = In->stat;

	/* Main Loop */
	s->line_c = 1;
	for (;;) {
		/* Get Next Statement */
		for (c = fgetc(f); !feof(f) && c != ';'; c = fgetc(f))
			if (c == '\n')
				s->line_c++;
		for (Get_Token(In); t[0] != '\0' && !strcmp(t, ";");
		     Get_Token(In), s->stmt_c++) ;
		if (t[0] == '\0') {
			s->file_s = PC_to_File(PC);
			In->stat = NULL;
			Free_File(In);
			return; }
		/* Identify Statement */
		if (!strcmp(t, "#")) {
			Do_Directive(In); }
		else {
			if (In->type == Token_mnemonic_t_) Do_Assembly(In);
			else {
				if (In->line[0] != '{')
					errx(1,"There is no compiler");
				Do_Link(In); }}
		s->stmt_c++; }}

/* Resolve all name references. */
void Second_Pass (void) {
	int i, j = 0, s = 0;
	Dll_n *r, *d;
	Dll_link_s *lr, *ld;
	Dll_name_s *n;

	while ((r = Dll_Pull(Global_Name_R))) {
		if (!(d = Dll_Find(Global_Name, r))
		    && !(d = Dll_Find(Global_Code, r))
		    && !(d = Dll_Find(Global_Data, r)))
			Error(0x04, 0x2B, NULL, (void *)r);
		n = (Dll_name_s *) d->data;
		if (n->data == -1)
			Error(0x04, 0x2D, NULL, (void *)r); /* Unresolved name prototype */
		/* Write value */
		j = n->data + ((Dll_name_s *) r->data)->mode;
		fseek(Out->file, PC_to_File(((Dll_name_s *) r->data)->data),
		      SEEK_SET);
		for (i = 0; i < n->size; i++) {
			fputc((char)j & 0xFF, Out->file);
			j = j >> 8; }}

	/* Resolve Link References */
	while ((r = Dll_Pull(Global_Link_R))) {
		if (!(d = Dll_Find(Global_Link, r)))
			Error(0x04, 0x2A, NULL, (void *)r);
		lr = (Dll_link_s *) r->data;
		ld = (Dll_link_s *) d->data;
		/* Branch */
		if (lr->mode == 0x10 /* BPL */
		    || lr->mode == 0x30 /* BMI */
		    || lr->mode == 0x50 /* BVC */
		    || lr->mode == 0x70 /* BVS */
		    || lr->mode == 0x80 /* BRA */
		    || lr->mode == 0x90 /* BCC or BLT */
		    || lr->mode == 0xB0 /* BCS or BGE */
		    || lr->mode == 0xD0 /* BNE */
		    || lr->mode == 0xF0) /* BEQ */ {
			s = 1;
			j = ld->addr - lr->addr - 1; }
		/* Branch long */
		if (lr->mode == 0x82) { /* BRL */
			s = 2;
			/* DEBUG THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
			j = ld->addr - lr->addr - 2; }
		/* Jump absolute */
		if (lr->mode == 0x4C) /* JMP */
			s = 2, j = ld->addr;
		/* Write value */
		fseek(Out->file, PC_to_File(lr->addr), SEEK_SET);
		for (i = 0; i < s; i++)
			fputc((char)j & 0xFF, Out->file), j = j >> 8; }
	return; }

int main (int argc, char *argv[]) {
	FORII(6) * Global_Dlls[ii] = Dll_New(Dll_head_t_);
	switch (argc) {
	case 4:
		if (strcmp(argv[1],"-r")) break;
		Report_f=true,Inf=argv[2],Outf=argv[3]; goto ok;
	case 3:
		Inf=argv[1],Outf=argv[2]; goto ok; }
	errx(1,"Usage: %s [-r] infile outfile", *argv);

ok:
	Out = New_File(Outf,"wb");
	First_Pass();
	Second_Pass();
	PrintReport();
	Free_File(Out);
	FORII(6) Dll_Free(*Global_Dlls[ii]); }

