#lang scribble/doc
@(require "utils.rkt")

@title{Structures}

A new Racket structure type is created with
@cppi{scheme_make_struct_type}.  This creates the structure type, but
does not generate the constructor, etc.  procedures. The
@cppi{scheme_make_struct_values} function takes a structure type and
creates these procedures. The @cppi{scheme_make_struct_names} function
generates the standard structure procedures names given the structure
type's name.  Instances of a structure type are created with
@cppi{scheme_make_struct_instance} and the function
@cppi{scheme_is_struct_instance} tests a structure's type.  The
@cppi{scheme_struct_ref} and @cppi{scheme_struct_set} functions access
or modify a field of a structure.

The structure procedure values and names generated by
@cpp{scheme_make_struct_values} and @cpp{scheme_make_struct_names} can
be restricted by passing any combination of these flags:

@itemize[

 @item{@cppi{SCHEME_STRUCT_NO_TYPE} --- the structure type
 value/name is not returned.}

 @item{@cppi{SCHEME_STRUCT_NO_CONSTR} --- the constructor procedure
 value/name is not returned.}

 @item{@cppi{SCHEME_STRUCT_NO_PRED}--- the predicate procedure
 value/name is not returned.}

 @item{@cppi{SCHEME_STRUCT_NO_GET} --- the selector procedure
 values/names are not returned.}

 @item{@cppi{SCHEME_STRUCT_NO_SET} --- the mutator procedure
 values/names are not returned.}

 @item{@cppi{SCHEME_STRUCT_GEN_GET} --- the field-independent
 selector procedure value/name is returned.}

 @item{@cppi{SCHEME_STRUCT_GEN_SET} --- the field-independent
 mutator procedure value/name is returned.}

 @item{@cppi{SCHEME_STRUCT_NO_MAKE_PREFIX} --- the constructor name
 omits a @racketidfont{make-} prefix, like @racket[struct] instead of
 @racket[define-struct].}

]

When all values or names are returned, they are returned as an array
with the following order: structure type, constructor, predicate,
first selector, first mutator, second selector, etc.,
field-independent select, field-independent mutator. When particular
values/names are omitted, the array is compressed accordingly.

@; ----------------------------------------------------------------------

@function[(Scheme_Object* scheme_make_struct_type
           [Scheme_Object* base_name]
           [Scheme_Object* super_type]
           [Scheme_Object* inspector]
           [int num_init_fields]
           [int num_auto_fields]
           [Scheme_Object* auto_val]
           [Scheme_Object* properties]
           [Scheme_Object* guard])]{

Creates and returns a new structure type. The @var{base_name}
 argument is used as the name of the new structure type; it must be a
 symbol. The @var{super_type} argument should be @cpp{NULL} or an
 existing structure type to use as the super-type. The @var{inspector}
 argument should be @cpp{NULL} or an inspector to manage the type.
 The @var{num_init_fields} argument specifies the number of fields
 for instances of this structure type that have corresponding
 constructor arguments. (If a super-type is used, this is the number
 of additional fields, rather than the total number.)  The
 @var{num_auto_fields} argument specifies the number of additional
 fields that have no corresponding constructor arguments, and they are
 initialized to @var{auto_val}. The @var{properties} argument is a
 list of property-value pairs. The @var{guard} argument is either NULL
 or a procedure to use as a constructor guard.}

@function[(Scheme_Object** scheme_make_struct_names
           [Scheme_Object* base_name]
           [Scheme_Object* field_names]
           [int flags]
           [int* count_out])]{

Creates and returns an array of standard structure value name
symbols. The @var{base_name} argument is used as the name of the
structure type; it should be the same symbol passed to the associated
call to @cpp{scheme_make_struct_type}. The @var{field_names} argument
is a (Racket) list of field name symbols. The @var{flags} argument
specifies which names should be generated, and if @var{count_out} is
not @cpp{NULL}, @var{count_out} is filled with the number of names
returned in the array.}

@function[(Scheme_Object** scheme_make_struct_values
           [Scheme_Object* struct_type]
           [Scheme_Object** names]
           [int count]
           [int flags])]{

Creates and returns an array of the standard structure value and procedure values
for @var{struct_type}. The @var{struct_type} argument must be a structure type
value created by @cpp{scheme_make_struct_type}. The @var{names} procedure
must be an array of name symbols, generally the array returned by 
@cpp{scheme_make_struct_names}. The @var{count} argument specifies the
length of the @var{names} array (and therefore the number of expected
return values) and the @var{flags} argument specifies which values
should be generated.}

@function[(Scheme_Object* scheme_make_struct_instance
           [Scheme_Object* struct_type]
           [int argc]
           [Scheme_Object** argv])]{

Creates an instance of the structure type @var{struct_type}. The
@var{argc} and @var{argv} arguments provide the field values for the
new instance.}

@function[(int scheme_is_struct_instance
           [Scheme_Object* struct_type]
           [Scheme_Object* v])]{

Returns 1 if @var{v} is an instance of @var{struct_type} or 0 otherwise.}

@function[(Scheme_Object* scheme_struct_ref
           [Scheme_Object* s]
           [int n])]{

Returns the @var{n}th field (counting from 0) in the structure @var{s}.}

@function[(void scheme_struct_set
           [Scheme_Object* s]
           [int n]
           [Scheme_Object* v])]{

Sets the @var{n}th field (counting from 0) in the structure @var{s} to @var{v}.}

