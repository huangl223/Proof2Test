// Automatically generated (04/01/2023 2:39:37.070 PM)

// File: f:\es_ap\trunk\research\extension\autoproof\library\base\mml\set.bpl

// Finite sets.
// (Originally from Dafny Prelude: Copyright (c) Microsoft)

// Set type
type Set T = [T]bool;

// Cardinality
function Set#Card<T>(Set T): int;
axiom (forall<T> s: Set T :: { Set#Card(s) } 0 <= Set#Card(s));

// Empty set
function Set#Empty<T>(): Set T;
axiom (forall<T> o: T :: { Set#Empty()[o] } !Set#Empty()[o]);
axiom (forall<T> s: Set T :: { Set#Card(s) }
  (Set#Card(s) == 0 <==> s == Set#Empty()));// &&
  // (Set#Card(s) != 0 ==> (exists x: T :: s[x])));
axiom (forall<T> f: Field (Set T) :: { Default(f) } Default(f) == Set#Empty() : Set T);  

// Singleton set  
function Set#Singleton<T>(T): Set T;
axiom (forall<T> r: T :: { Set#Singleton(r) } Set#Singleton(r)[r]);
axiom (forall<T> r: T, o: T :: { Set#Singleton(r)[o] } Set#Singleton(r)[o] <==> r == o);
axiom (forall<T> r: T :: { Set#Card(Set#Singleton(r)) } Set#Card(Set#Singleton(r)) == 1);
axiom (forall<T> s: Set T, x: T :: { Set#Singleton(x), Set#Card(s) } Set#Card(s) == 1 && s[x]  ==>  s == Set#Singleton(x));

// Is a set empty?
function {: inline } Set#IsEmpty<T>(s: Set T): bool
{ Set#Equal(s, Set#Empty()) }

// An arbitrary element of a nonempty set
function Set#AnyItem<T>(Set T): T;
axiom (forall<T> s: Set T :: { Set#AnyItem(s) } 
  !Set#IsEmpty(s) ==> s[Set#AnyItem(s)]);
  
// Are two sets equal?  
function Set#Equal<T>(Set T, Set T): bool;
axiom(forall<T> a: Set T, b: Set T :: { Set#Equal(a,b) }
  Set#Equal(a,b) <==> (forall o: T :: {a[o]} {b[o]} a[o] <==> b[o]));
axiom(forall<T> a: Set T, b: Set T :: { Set#Equal(a,b) }  // extensionality axiom for sets
  Set#Equal(a,b) ==> a == b);  
  
// Is a subset of b?
function Set#Subset<T>(Set T, Set T): bool;
axiom(forall<T> a: Set T, b: Set T :: { Set#Subset(a,b) }
  Set#Subset(a,b) <==> (forall o: T :: {a[o]} {b[o]} a[o] ==> b[o]));
axiom(forall<T> a: Set T, b: Set T :: { Set#Subset(a,b), Set#Card(a) }{ Set#Subset(a,b), Set#Card(b) }
  Set#Subset(a,b) ==> Set#Card(a) <= Set#Card(b));
  
  
// Is a superset of b?
function {: inline } Set#Superset<T>(a: Set T, b: Set T): bool
{ Set#Subset(b, a) }

// Are a and b disjoint?
function Set#Disjoint<T>(Set T, Set T): bool;
axiom (forall<T> a: Set T, b: Set T :: { Set#Disjoint(a,b) }
  Set#Disjoint(a,b) <==> (forall o: T :: {a[o]} {b[o]} !a[o] || !b[o]));
  
// Set extended with one element  
function Set#Extended<T>(Set T, T): Set T;
axiom (forall<T> a: Set T, x: T, o: T :: { Set#Extended(a,x)[o] }
  Set#Extended(a,x)[o] <==> o == x || a[o]);
axiom (forall<T> a: Set T, x: T :: { Set#Extended(a, x) }
  Set#Extended(a, x)[x]);
axiom (forall<T> a: Set T, x: T, y: T :: { Set#Extended(a, x), a[y] }
  a[y] ==> Set#Extended(a, x)[y]);
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Extended(a, x)) }
  a[x] ==> Set#Card(Set#Extended(a, x)) == Set#Card(a));  
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Extended(a, x)) }
  !a[x] ==> Set#Card(Set#Extended(a, x)) == Set#Card(a) + 1);    
  
// Set with one element removed
function Set#Removed<T>(Set T, T): Set T;
axiom (forall<T> a: Set T, x: T, o: T :: { Set#Removed(a,x)[o] }
  Set#Removed(a,x)[o] <==> o != x && a[o]);
axiom (forall<T> a: Set T, x: T :: { Set#Removed(a, x) }
  !Set#Removed(a, x)[x]);
// axiom (forall<T> a: Set T, x: T, y: T :: { Set#Removed(a, x), a[y] }
  // Set#Removed(a, x)[y] ==> a[y]);
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Removed(a, x)) }
  a[x] ==> Set#Card(Set#Removed(a, x)) == Set#Card(a) - 1);  
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Removed(a, x)) }
  !a[x] ==> Set#Card(Set#Removed(a, x)) == Set#Card(a));

// Union of two sets
function Set#Union<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Union(a,b)[o] }
  Set#Union(a,b)[o] <==> a[o] || b[o]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Union(a, b), a[y] }
  a[y] ==> Set#Union(a, b)[y]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Union(a, b), b[y] }
  b[y] ==> Set#Union(a, b)[y]);
axiom (forall<T> a, b: Set T :: { Set#Union(a, b) }
  Set#Disjoint(a, b) ==>
    Set#Difference(Set#Union(a, b), a) == b &&
    Set#Difference(Set#Union(a, b), b) == a);

// Intersection of two sets    
function Set#Intersection<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Intersection(a,b)[o] }
  Set#Intersection(a,b)[o] <==> a[o] && b[o]);
axiom (forall<T> a, b: Set T :: { Set#Union(Set#Union(a, b), b) }
  Set#Union(Set#Union(a, b), b) == Set#Union(a, b));
axiom (forall<T> a, b: Set T :: { Set#Union(a, Set#Union(a, b)) }
  Set#Union(a, Set#Union(a, b)) == Set#Union(a, b));
axiom (forall<T> a, b: Set T :: { Set#Intersection(Set#Intersection(a, b), b) }
  Set#Intersection(Set#Intersection(a, b), b) == Set#Intersection(a, b));
axiom (forall<T> a, b: Set T :: { Set#Intersection(a, Set#Intersection(a, b)) }
  Set#Intersection(a, Set#Intersection(a, b)) == Set#Intersection(a, b));
axiom (forall<T> a, b: Set T :: { Set#Card(Set#Union(a, b)) }{ Set#Card(Set#Intersection(a, b)) }
  Set#Card(Set#Union(a, b)) + Set#Card(Set#Intersection(a, b)) == Set#Card(a) + Set#Card(b));

// Set a with all elements from b removed
function Set#Difference<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Difference(a,b)[o] }
  Set#Difference(a,b)[o] <==> a[o] && !b[o]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Difference(a, b), b[y] }
  b[y] ==> !Set#Difference(a, b)[y] );
axiom (forall<T> a, b: Set T ::
  { Set#Card(Set#Difference(a, b)) }
  Set#Card(Set#Difference(a, b)) + Set#Card(Set#Difference(b, a)) 
  + Set#Card(Set#Intersection(a, b))
    == Set#Card(Set#Union(a, b)) &&
  Set#Card(Set#Difference(a, b)) == Set#Card(a) - Set#Card(Set#Intersection(a, b)));
axiom (forall<T> a: Set T :: { Set#Difference(a,Set#Empty()) }
  Set#Equal(Set#Difference(a,Set#Empty()), a));

// Symmetric difference of two sets  
function Set#SymDifference<T>(a: Set T, b: Set T): Set T
{ Set#Union(Set#Difference(a, b), Set#Difference(b, a)) }


function Set#Min<T>(Set T): T;
axiom (forall s: Set int :: { Set#Min(s) } 
  !Set#IsEmpty(s) ==> s[Set#Min(s)] && (forall x: int :: s[x] ==> x >= Set#Min(s)));

function Set#Max<T>(Set T): T;
axiom (forall s: Set int :: { Set#Max(s) } 
  !Set#IsEmpty(s) ==> s[Set#Max(s)] && (forall x: int :: s[x] ==> x <= Set#Max(s)));
  
function Set#NonNull(s: Set ref): bool
{ (forall x: ref :: { s[x] } s[x] ==> x != Void) }
  
// Type property
function {: inline } Set#ItemsType(heap: HeapType, s: Set ref, t: Type): bool 
{ (forall o: ref :: { s[o] } s[o] ==> detachable(heap, o, t)) }
    
// Integer intervals
type Interval = Set int;

// Interval [l, u]
function Interval#FromRange(int, int): Interval;
axiom (forall l, u: int :: { Set#Card(Interval#FromRange(l, u)) }
  (u < l ==> Set#Card(Interval#FromRange(l, u)) == 0) &&
  (l <= u ==> Set#Card(Interval#FromRange(l, u)) == u - l + 1));
axiom (forall l, u, x: int :: { Interval#FromRange(l, u)[x] }
  Interval#FromRange(l, u)[x] <==> l <= x && x <= u);  

// File: D:\Program Files\Eiffel Software\EiffelStudio 22.05 Standard\studio\tools\autoproof\base_theory.bpl

// ----------------------------------------------------------------------
// Reference types

type ref; // Type definition for reference types
const Void: ref; // Constant for Void references

// Is r1 <= r2 in the well-founded order?
function ref_rank_leq(r1, r2: ref): bool
{ r2 == Void ==> r1 == Void }

// ----------------------------------------------------------------------
// Heap and allocation

type Field _; // Type of a field (with open subtype)
// function IsGhostField<alpha>(field: Field alpha): bool; // Is this field a ghost field?
function FieldId<alpha>(field: Field alpha, t: Type): int; // ID of field within t; used to express that all fields of the same class are distinct.

// Default field value
function Default<alpha>(Field alpha): alpha;
axiom (forall f: Field bool :: !Default(f));
axiom (forall f: Field int :: Default(f) == 0);
axiom (forall f: Field ref :: Default(f) == Void);
axiom (forall f: Field real :: Default(f) == 0.0);

type HeapType = <alpha>[ref, Field alpha]alpha; // Type of a heap (with generic field subtype and generic content type)
const allocated: Field bool; // Ghost field for allocation status of objects

// Function which defines basic properties of a heap
function IsHeap(heap: HeapType): bool;

// The global heap (which is always a heap)
var Heap: HeapType where IsHeap(Heap);

// Function that defines properties of two (transitively) successive heaps
function HeapSucc(HeapType, HeapType): bool;
axiom (forall<alpha> h: HeapType, r: ref, f: Field alpha, x: alpha :: { h[r, f := x] }
  IsHeap(h[r, f := x]) ==>
  HeapSucc(h, h[r, f := x]));  
axiom (forall a,b,c: HeapType :: { HeapSucc(a,b), HeapSucc(b,c) }
  HeapSucc(a,b) && HeapSucc(b,c) ==> HeapSucc(a,c));
axiom (forall h: HeapType, k: HeapType :: { HeapSucc(h,k) }
  HeapSucc(h,k) ==> (forall o: ref :: { k[o, allocated] } h[o, allocated] ==> k[o, allocated]));  


// ----------------------------------------------------------------------
// Typing

type Type; // Type definition for Eiffel types
const unique ANY: Type; // Type for ANY
const unique NONE: Type; // Type for NONE

// Type function for objects.
function type_of(o: ref): Type;
function is_frozen(t: Type): bool;

// Typing axioms
axiom (forall t: Type :: { ANY <: t } ANY <: t <==> t == ANY);
axiom (forall t: Type :: t <: ANY); // All types inherit from ANY.
// axiom (forall t: Type :: NONE <: t); // NONE inherits from all types.
// axiom (forall h: HeapType :: IsHeap(h) ==> h[Void, allocated]); // Void is always allocated.
axiom (forall h: HeapType, f: Field ref, o: ref :: IsHeap(h) && h[o, allocated] ==> h[h[o, f], allocated]); // All reference fields are allocated.
axiom (forall r: ref :: (r == Void) <==> (type_of(r) == NONE)); // Void is only reference of type NONE.
// axiom (forall a, b: ref :: (type_of(a) != type_of(b)) ==> (a != b)); // Objects that have different dynamic type cannot be aliased.
// axiom (forall t: Type :: is_frozen(t) ==> (forall t2: Type :: t2 <: t ==> t2 == t || t2 == NONE)); // Only NONE inherits from frozen types.
axiom (forall t: Type, r: ref :: { is_frozen(t), type_of(r) } (r != Void && type_of(r) <: t && is_frozen(t)) ==> (type_of(r) == t)); // Non-void references of a frozen type are exact.
// axiom (forall h: HeapType, t: Type, o: ref :: { is_frozen(t), attached_exact(h, o, t) } IsHeap(h) && is_frozen(t) && attached(h, o, t) ==> attached_exact(h, o, t));

// ----------------------------------------------------------------------
// Built-in attributes

const closed: Field bool; // Ghost field for open/closed status of an object.
const owner: Field ref; // Ghost field for owner of an object.
const owns: Field (Set ref); // Ghost field for owns set of an object.
const observers: Field (Set ref); // Ghost field for observers set of an object.
const subjects: Field (Set ref); // Ghost field for subjects set of an object.

// Analogue of `detachable_attribute' and `set_detachable_attribute' for built-in attributes:
axiom (forall heap: HeapType, o: ref :: { heap[o, owner] } IsHeap(heap) && o != Void && heap[o, allocated] ==> heap[heap[o, owner], allocated]);
axiom (forall heap: HeapType, o, o': ref :: { heap[o, owns][o'] } IsHeap(heap) && o != Void && heap[o, allocated] && heap[o, owns][o'] ==> heap[o', allocated]);
axiom (forall heap: HeapType, o, o': ref :: { heap[o, subjects][o'] } IsHeap(heap) && o != Void && heap[o, allocated] && heap[o, subjects][o'] ==> heap[o', allocated]);
axiom (forall heap: HeapType, o, o': ref :: { heap[o, observers][o'] } IsHeap(heap) && o != Void && heap[o, allocated] && heap[o, observers][o'] ==> heap[o', allocated]);

// Is o open in h? (not closed and free)
function is_open(h: HeapType, o: ref): bool {
	!h[o, closed]
}

// Is o closed in h?
function is_closed(h: HeapType, o: ref): bool {
	h[o, closed]
}

// Is o free? (owner is open)
function {:inline} is_free(h: HeapType, o: ref): bool {
  h[o, owner] == Void
}

// Is o wrapped in h? (closed and free)
function is_wrapped(h: HeapType, o: ref): bool {
	h[o, closed] && is_free(h, o)
}

// Is o' in the ownership domain of o? Yes if they are equal, or both closed and o' is transitively owned by o
function in_domain(h: HeapType, o: ref, o': ref): bool
{
	o == o' || ( h[o, closed] && h[o', closed] && in_domain(h, o, h[o', owner]) )
}

axiom (forall h: HeapType, o, o': ref :: { in_domain(h, o, o') } IsHeap(h) && h[o, closed] && h[o, owns][o'] ==> in_domain(h, o, o'));
axiom (forall h: HeapType, o, o': ref :: { in_domain(h, o, o'), trans_owns(h, o) } IsHeap(h) && h[o, closed] ==> (in_trans_owns(h, o, o') <==> in_domain(h, o, o')));
axiom (forall h: HeapType, o, o': ref :: { in_domain(h, o, o') } IsHeap(h) && o != o' && Set#Equal(Set#Empty(), h[o, owns]) ==> !in_domain(h, o, o'));
axiom (forall h: HeapType, o, o', o'': ref :: { in_domain(h, o, o'), Set#Equal(Set#Singleton(o''), h[o, owns]) } IsHeap(h) && h[o, closed] && o != o' && Set#Equal(Set#Singleton(o''), h[o, owns]) ==> 
	(in_domain(h, o, o') <==> in_domain(h, o'', o')));
	

// Frame axiom: domain frames itself
axiom (forall h, h': HeapType, x, x': ref :: { in_domain(h, x, x'), in_domain(h', x, x'), HeapSucc(h, h') } 
  IsHeap(h) && IsHeap(h') && HeapSucc(h, h') &&
  h[x, allocated] && h'[x, allocated] &&     
  (forall <T> o: ref, f: Field T :: h[o, allocated] ==> h'[o, f] == h[o, f] || !in_domain(h, x, o))
  ==> in_domain(h', x, x') == in_domain(h, x, x'));

function domain(h: HeapType, o: ref): Set ref
{ (lambda o': ref :: in_domain(h, o, o')) }

// Is o' in the transitive owns of o?
// (the same as in_domain if o is closed)
function in_trans_owns(h: HeapType, o: ref, o': ref): bool
{
  o == o' || h[o, owns][o'] || (exists x: ref :: h[o, owns][x] && in_trans_owns(h, x, o'))
}

function trans_owns(h: HeapType, o: ref): Set ref
{ (lambda o': ref :: in_trans_owns(h, o, o')) }

const universe: Set ref;
axiom (forall o: ref :: { universe[o] } universe[o]);

// ----------------------------------------------------------------------
// Models

function IsModelField<alpha>(field: Field alpha, t: Type): bool; // Is this field a model field in class t?

axiom (forall <alpha> f: Field alpha :: { IsModelField(f, ANY) }
  IsModelField(f, ANY) <==> f == closed || f == owner || f == owns || f == observers || f == subjects );  

// ----------------------------------------------------------------------
// Frames

// Set of object-field pairs
type Frame = <alpha>[ref, Field alpha]bool;

function Frame#Subset(Frame, Frame): bool;
axiom(forall a: Frame, b: Frame :: { Frame#Subset(a,b) }
  Frame#Subset(a,b) <==> (forall <alpha> o: ref, f: Field alpha :: {a[o, f]} {b[o, f]} a[o, f] ==> b[o, f]));
	
function Frame#Singleton(ref): Frame;
axiom(forall <alpha> o, o': ref, f: Field alpha :: { Frame#Singleton(o)[o', f] }
  Frame#Singleton(o)[o', f] <==> o == o');

function has_whole_object(frame: Frame, o: ref): bool
{ (forall <alpha> f: Field alpha :: frame[o, f]) }

// Frame is closed under ownership domains and includes all unallocated objects
function { :inline } closed_under_domains(frame: Frame, h: HeapType): bool
{ 
  (forall <U> o': ref, f': Field U :: {frame[o', f']} 
    !h[o', allocated] || (exists <V> o: ref, f: Field V :: frame[o, f] && in_domain(h, o, o') && o != o') ==> frame[o', f'])
}

// Objects outside of ownership domains of frame did not change, unless they were newly allocated
function {: inline } same_outside(h: HeapType, h': HeapType, frame: Frame): bool { 
	(forall <T> o: ref, f: Field T :: { h'[o, f] }
    o != Void && h[o, allocated] ==>      
      h'[o, f] == h[o, f] ||
      frame[o, f] ||        
      (exists o': ref :: {frame[o', closed]} o' != o && frame[o', closed] && in_domain(h, o', o)) // Using extra knowledge here to remove an existential: modifying object's domain requires its closed to be in the frame
  )
}

// Objects outside of frame did not change, unless they were newly allocated
function {: inline } flat_same_outside(h: HeapType, h': HeapType, frame: Frame): bool { 
	(forall <T> o: ref, f: Field T :: { h'[o, f] } o != Void && h[o, allocated] ==> h'[o, f] == h[o, f] || frame[o, f])
}

// Objects inside the frame did not change
function same_inside(h: HeapType, h': HeapType, frame: Frame): bool { 
	(forall <T> o: ref, f: Field T :: o != Void && h[o, allocated] && h'[o, allocated] && frame [o, f] ==> h'[o, f] == h[o, f])
}
// This version corresponds to the old semantics of read clauses:
// // Objects inside the old ownership domains of frame did not change
// // function same_inside(h: HeapType, h': HeapType, frame: Frame): bool { 
	// // (forall <T> o: ref, f: Field T :: { h[o, f] } { h'[o, f] }
    // // h[o, allocated] && h'[o, f] != h[o, f] ==>
      // // !frame [o, f] && (forall<U> o': ref, g: Field U :: frame[o', g] && o != o' ==> !in_domain(h, o', o)))
// // }

// Set of all writable objects
const writable: Frame;

// Set of all readable objects
const readable: Frame;

// ----------------------------------------------------------------------
// Invariants

// Is invariant of object o satisifed?
function user_inv(h: HeapType, o: ref): bool;

// Read frame of user_inv
function user_inv_readable(HeapType, ref): Frame;
axiom (forall<T> h: HeapType, x: ref, o: ref, f: Field T :: { user_inv_readable(h, x)[o, f] }
  IsHeap(h) ==> user_inv_readable(h, x)[o, f] == (in_trans_owns(h, x, o) || h[x, subjects][o]));
  
// Uninterpreted function to trigger the invariant frame axiom
function inv_frame_trigger(x: ref): bool;
  
// Frame axiom
axiom (forall h, h': HeapType, x: ref :: { user_inv(h, x), user_inv(h', x), HeapSucc(h, h'), inv_frame_trigger(x) } 
  IsHeap(h) && IsHeap(h') && HeapSucc(h, h') && inv_frame_trigger(x) &&
  x != Void && h[x, allocated] && h'[x, allocated] &&
  is_open(h, x) && is_open(h', x) &&
  user_inv(h, x) && 
  (forall <T> o: ref, f: Field T :: h[o, allocated] ==> // every object's field
      h'[o, f] == h[o, f] ||                            // is unchanged
      f == closed || f == owner ||                      // or is outside of the read set of the invariant
      !user_inv_readable(h, x)[o, f]
      // (!in_trans_owns(h, x, o) && guard(h, o, f, h'[o, f], x)) // or changed in a way that conforms to its guard
   )
  ==> user_inv(h', x));

// Is object o closed or the invariant satisfied?
function {:inline true} inv(h: HeapType, o: ref): bool {
	h[o, closed] ==> user_inv(h, o)
}

// Global heap invariants
function {:inline true} global(h: HeapType): bool
{
  h[Void, allocated] && is_open(h, Void) &&
  // (forall o: ref :: h[o, allocated] && is_open(h, o) ==> is_free(h, o)) &&
  // (forall o: ref :: { h[o, owner], is_open(h, o) } h[o, allocated] && is_open(h, o) ==> is_free(h, o)) &&
  (forall o: ref, o': ref :: { h[o, owns][o'] } h[o, allocated] && h[o', allocated] && h[o, closed] && h[o, owns][o'] ==> (h[o', closed] && h[o', owner] == o)) && // G2
  (forall o: ref :: { user_inv(h, o) } h[o, allocated] ==> inv(h, o)) // G1
}

// All objects in valid heaps are valid.
// This function introduces invariants automatically, so should be used with care.
function {: inline } global_permissive(): bool
{ (forall h: HeapType, o: ref :: {is_wrapped (h, o)}{is_closed (h, o)} IsHeap(h) && h[o, allocated] ==> inv(h, o)) }

// Condition under which an update heap[current, f] := v is guaranteed to preserve the invariant of o.
function guard<T>(heap: HeapType, current: ref, f: Field T, v: T, o: ref): bool;

// All subjects know current for an observer
function {: inline } admissibility2 (heap: HeapType, current: ref): bool
{ 
  (forall s: ref :: heap[current, subjects][s] && s != Void ==> heap[s, observers][current]) 
}

// Invariant cannot be invalidated by an update that conform to its guard
function {: inline } admissibility3 (heap: HeapType, current: ref): bool
{
  (forall<T> s: ref, f: Field T, v: T ::
    heap[current, subjects][s] && s != current && s != Void && IsHeap(heap[s, f := v]) && guard(heap, s, f, v, current) ==>
      user_inv(heap[s, f := v], current))
}

// ----------------------------------------------------------------------
// Built-in operations

// Allocate fresh object
procedure allocate(t: Type) returns (result: ref);
  modifies Heap;
  ensures global(Heap);
  ensures !old(Heap[result, allocated]); // AL1
  ensures Heap[result, allocated]; // AL2
  ensures result != Void;
  ensures type_of(result) == t;
  ensures (forall<T> f: Field T :: f != allocated ==> Heap[result, f] == Default(f));
  ensures has_whole_object(writable, result);
  ensures (forall <T> o: ref, f: Field T :: o != result ==> Heap[o, f] == old(Heap[o, f]));
  free ensures HeapSucc(old(Heap), Heap);

// Update Heap position Current.field with value.
procedure update_heap<T>(Current: ref, field: Field T, value: T);
  requires (Current != Void) && (Heap[Current, allocated]); // type:assign tag:attached_and_allocated
  requires field != closed && field != owner; // type:assign tag:closed_or_owner_not_allowed UP4
  requires is_open(Heap, Current); // type:assign tag:target_open UP1
  requires (forall o: ref :: Heap[Current, observers][o] ==> (is_open(Heap, o) || (IsHeap(Heap[Current, field := value]) ==> guard(Heap, Current, field, value, o)))); // type:assign tag:observers_open_or_guard_holds UP2  
  requires writable[Current, field]; // type:assign tag:attribute_writable UP3
  modifies Heap;
  ensures global(Heap);
  ensures Heap == old(Heap[Current, field := value]);
  free ensures HeapSucc(old(Heap), Heap);
  
// Unwrap o
procedure unwrap(o: ref);
  requires (o != Void) && (Heap[o, allocated]); // type:pre tag:attached
  requires is_wrapped(Heap, o); // type:pre tag:wrapped UW1
  requires writable[o, closed]; // type:pre tag:writable UW2
  modifies Heap;
  ensures global(Heap);  
  ensures is_open(Heap, o); // UWE1
  ensures (forall o': ref :: old(Heap[o, owns][o']) ==> is_wrapped(Heap, o')); // UWE2
  ensures (forall <T> o': ref, f: Field T :: !(o' == o && f == closed) && !(old(Heap[o, owns][o']) && f == owner) ==> Heap[o', f] == old(Heap[o', f]));
  free ensures HeapSucc(old(Heap), Heap);

procedure unwrap_all (Current: ref, s: Set ref);
  requires (forall o: ref :: s[o] ==> (o != Void) && (Heap[o, allocated])); // type:pre tag:attached
  requires (forall o: ref :: s[o] ==> is_wrapped(Heap, o)); // type:pre tag:wrapped UW1
  requires (forall o: ref :: s[o] ==> writable[o, closed]); // type:pre tag:writable UW2
  modifies Heap;
  ensures global(Heap);
  ensures (forall o: ref :: s[o] ==> is_open(Heap, o)); // UWE1
  ensures (forall o: ref :: s[o] ==> (forall o': ref :: old(Heap[o, owns][o']) ==> is_wrapped(Heap, o'))); // UWE2
  ensures (forall <T> o: ref, f: Field T :: !(f == closed && s[o]) && !(f == owner && (exists o': ref :: s[o'] && old(Heap[o', owns][o]))) ==> Heap[o, f] == old(Heap[o, f]));
  ensures (forall o: ref :: s[o] ==> user_inv(Heap, o) && inv_frame_trigger(o));
  free ensures HeapSucc(old(Heap), Heap);

// Wrap o
procedure wrap(o: ref);
  requires (o != Void) && (Heap[o, allocated]); // type:pre tag:attached
  requires is_open(Heap, o); // type:pre tag:open W1
  requires writable[o, closed]; // type:pre tag:writable W4
  // requires user_inv(Heap, o); // type:pre tag:invariant_holds W2 // Custom check now
  requires (forall o': ref :: { Heap[o, owns][o'] } Heap[o, owns][o'] ==> is_wrapped(Heap, o') && writable[o', owner]); // type:pre tag:owned_objects_wrapped_and_writable W3
  modifies Heap;
  ensures global(Heap);  
  ensures (forall o': ref :: old(Heap[o, owns][o']) ==> Heap[o', owner] == o); // WE2
  ensures is_wrapped(Heap, o); // WE3
  ensures (forall <T> o': ref, f: Field T :: !(o' == o && f == closed) && !(old(Heap[o, owns][o']) && f == owner) ==> Heap[o', f] == old(Heap[o', f]));
  free ensures HeapSucc(old(Heap), Heap);

procedure wrap_all(Current: ref, s: Set ref);
  requires (forall o: ref :: s[o] ==> (o != Void) && (Heap[o, allocated])); // type:pre tag:attached
  requires (forall o: ref :: s[o] ==> is_open(Heap, o)); // type:pre tag:open W1
  requires (forall o: ref :: s[o] ==> writable[o, closed]); // type:pre tag:writable W4    
  requires (forall o: ref :: s[o] ==> user_inv(Heap, o)); // type:pre tag:invariant_holds W2
  requires (forall o: ref :: s[o] ==> (forall o': ref :: Heap[o, owns][o'] ==> is_wrapped(Heap, o') && writable[o', owner])); // type:pre tag:owned_objects_wrapped_and_writable W3
  modifies Heap;
  ensures global(Heap);  
  ensures (forall o: ref :: s[o] ==> (forall o': ref :: old(Heap[o, owns][o']) ==> Heap[o', owner] == o)); // WE2
  ensures (forall o: ref :: s[o] ==> is_wrapped(Heap, o)); // WE3
  ensures (forall <T> o: ref, f: Field T :: !(f == closed && s[o]) && !(f == owner && (exists o': ref :: s[o'] && old(Heap[o', owns][o]))) ==> Heap[o, f] == old(Heap[o, f]));
  free ensures HeapSucc(old(Heap), Heap);

// ----------------------------------------------------------------------
// Attached/Detachable functions

// Reference `o' is attached to an object of type `t' on heap `heap'.
function attached_exact(heap: HeapType, o: ref, t: Type) returns (bool) {
	(o != Void) && (heap[o, allocated]) && (type_of(o) == t)
}

// Reference `o' is either Void or attached to an object of type `t' on heap `heap'.
function detachable_exact(heap: HeapType, o: ref, t: Type) returns (bool) {
	(o == Void) || attached_exact(heap, o, t)
}

// Reference `o' is attached and conforms to type `t' on heap `heap'.
function attached(heap: HeapType, o: ref, t: Type) returns (bool) {
	(o != Void) && (heap[o, allocated]) && (type_of(o) <: t)
}

// Reference `o' is either Void or attached and conforms to `t' on heap `heap'.
function detachable(heap: HeapType, o: ref, t: Type) returns (bool) {
	(o == Void) || attached(heap, o, t)
}

// ----------------------------------------------------------------------
// Basic types

// Integer boxing

const unique INTEGER: Type;

function boxed_int(i: int) returns (ref);
function unboxed_int(r: ref) returns (int);

axiom (forall i: int :: unboxed_int(boxed_int(i)) == i);
axiom (forall i1, i2: int :: (i1 == i2) ==> (boxed_int(i1) == boxed_int(i2)));
axiom (forall i: int :: boxed_int(i) != Void && type_of(boxed_int(i)) == INTEGER);
axiom (forall heap: HeapType, i: int :: IsHeap(heap) ==> heap[boxed_int(i), allocated]);


// Boolean boxing

const unique BOOLEAN: Type;
const unique boxed_true: ref;
const unique boxed_false: ref;

function boxed_bool(b: bool) returns (ref);
function unboxed_bool(r: ref) returns (bool);

axiom (boxed_bool(true) == boxed_true);
axiom (boxed_bool(false) == boxed_false);
axiom (unboxed_bool(boxed_true) == true);
axiom (unboxed_bool(boxed_false) == false);
axiom (boxed_true != boxed_false);
axiom (boxed_true != Void && type_of(boxed_true) == BOOLEAN);
axiom (boxed_false != Void && type_of(boxed_false) == BOOLEAN);
axiom (forall heap: HeapType :: IsHeap(heap) ==> heap[boxed_true, allocated]);
axiom (forall heap: HeapType :: IsHeap(heap) ==> heap[boxed_false, allocated]);

// Bounded integers

function is_integer_8(i: int) returns (bool) {
	(-128 <= i) && (i <= 127)
}
function is_integer_16(i: int) returns (bool) {
	(-32768 <= i) && (i <= 32767)
}
function is_integer_32(i: int) returns (bool) {
	(-2147483648 <= i) && (i <= 2147483647)
}
function is_integer_64(i: int) returns (bool) {
	(-9223372036854775808 <= i) && (i <= 9223372036854775807)
}
function is_natural(i: int) returns (bool) {
	(0 <= i)
}
function is_natural_8(i: int) returns (bool) {
	(0 <= i) && (i <= 255)
}
function is_natural_16(i: int) returns (bool) {
	(0 <= i) && (i <= 65535)
}
function is_natural_32(i: int) returns (bool) {
	(0 <= i) && (i <= 4294967295)
}
function is_natural_64(i: int) returns (bool) {
	(0 <= i) && (i <= 18446744073709551615)
}

// Numeric conversions

function int_to_integer_8(i: int) returns (int);
axiom (forall i: int :: { int_to_integer_8(i) } is_integer_8(i) ==> int_to_integer_8(i) == i);
axiom (forall i: int :: { int_to_integer_8(i) } is_integer_8(int_to_integer_8(i)));

function int_to_integer_16(i: int) returns (int);
axiom (forall i: int :: { int_to_integer_16(i) } is_integer_16(i) ==> int_to_integer_16(i) == i);
axiom (forall i: int :: { int_to_integer_16(i) } is_integer_16(int_to_integer_16(i)));

function int_to_integer_32(i: int) returns (int);
axiom (forall i: int :: { int_to_integer_32(i) } is_integer_32(i) ==> int_to_integer_32(i) == i);
axiom (forall i: int :: { int_to_integer_32(i) } is_integer_32(int_to_integer_32(i)));

function int_to_integer_64(i: int) returns (int);
axiom (forall i: int :: { int_to_integer_64(i) } is_integer_64(i) ==> int_to_integer_64(i) == i);
axiom (forall i: int :: { int_to_integer_64(i) } is_integer_64(int_to_integer_64(i)));

function int_to_natural_8(i: int) returns (int);
axiom (forall i: int :: { int_to_natural_8(i) } is_natural_8(i) ==> int_to_natural_8(i) == i);
axiom (forall i: int :: { int_to_natural_8(i) } is_natural_8(int_to_natural_8(i)));

function int_to_natural_16(i: int) returns (int);
axiom (forall i: int :: { int_to_natural_16(i) } is_natural_16(i) ==> int_to_natural_16(i) == i);
axiom (forall i: int :: { int_to_natural_16(i) } is_natural_16(int_to_natural_16(i)));

function int_to_natural_32(i: int) returns (int);
axiom (forall i: int :: { int_to_natural_32(i) } is_natural_32(i) ==> int_to_natural_32(i) == i);
axiom (forall i: int :: { int_to_natural_32(i) } is_natural_32(int_to_natural_32(i)));

function int_to_natural_64(i: int) returns (int);
axiom (forall i: int :: { int_to_natural_64(i) } is_natural_64(i) ==> int_to_natural_64(i) == i);
axiom (forall i: int :: { int_to_natural_64(i) } is_natural_64(int_to_natural_64(i)));

function real_to_integer_32(r: real) returns (int);
axiom (forall r: real :: { real_to_integer_32(r) } is_integer_32(int(r)) ==> real_to_integer_32(r) == int(r));
axiom (forall r: real :: { real_to_integer_32(r) } (!is_integer_32(int(r)) && r < 0.0) ==> real_to_integer_32(r) == -2147483648);
axiom (forall r: real :: { real_to_integer_32(r) } (!is_integer_32(int(r)) && r > 0.0) ==> real_to_integer_32(r) ==  2147483647);

function real_to_integer_64(r: real) returns (int);
axiom (forall r: real :: { real_to_integer_64(r) } is_integer_64(int(r)) ==> real_to_integer_64(r) == int(r));
axiom (forall r: real :: { real_to_integer_64(r) } (!is_integer_64(int(r)) && r < 0.0) ==> real_to_integer_64(r) == -9223372036854775808);
axiom (forall r: real :: { real_to_integer_64(r) } (!is_integer_64(int(r)) && r > 0.0) ==> real_to_integer_64(r) ==  9223372036854775807);

// Arithmetic functions

function add(a, b: int): int { a + b }
function subtract(a, b: int): int { a - b }
function multiply(a, b: int): int { a * b }
function modulo(a, b: int): int { a mod b }
function divide(a, b: int): int { a div b }

function min(a, b: int): int { if a <= b then a else b }
function max(a, b: int): int { if a >= b then a else b }
function abs(a: int): int { if a >= 0 then a else -a }
function sign(a: int): int { if a == 0 then 0 else if a > 0 then 1 else -1 }

function min_real(a, b: real): real { if a <= b then a else b }
function max_real(a, b: real): real { if a >= b then a else b }
function abs_real(a: real): real { if a >= 0.0 then a else -a }
function sign_real(a: real): int { if a == 0.0 then 0 else if a > 0.0 then 1 else -1 }

function bit_and(a, b: int): int;
function bit_or(a, b: int): int;
function bit_xor(a, b: int): int;
function bit_not(a: int): int;
function bit_shift_left(a, n: int): int;
function bit_shift_right(a, n: int): int;

// ----------------------------------------------------------------------
// once procedures

function global_once_value<T>(rid: int): T;
function object_once_value<T>(o: ref, rid: int): T;


// Expanded types

// type unknown;

// Address operator

// function address(a: ref) returns (int);
// axiom (forall a, b: ref :: (a != b) <==> (address(a) != address(b))); // Different objects have different heap addresses.
// axiom (forall a: ref :: is_integer_64(address(a))); // Addresses are 64 bit integers.

// Unsupported

function unsupported<T>() returns (T);


// Custom content

const unique ACCOUNT_4: Type;

axiom ((ACCOUNT_4) <: (ANY));

axiom ((forall t: Type :: { (ACCOUNT_4) <: (t) } ((ACCOUNT_4) <: (t)) <==> (((t) == (ACCOUNT_4)) || ((ANY) <: (t)))));

axiom ((FieldId(allocated, ACCOUNT_4)) == (-1));

axiom ((FieldId(closed, ACCOUNT_4)) == (-2));

axiom ((FieldId(owner, ACCOUNT_4)) == (-3));

axiom ((FieldId(owns, ACCOUNT_4)) == (-4));

axiom ((FieldId(observers, ACCOUNT_4)) == (-5));

axiom ((FieldId(subjects, ACCOUNT_4)) == (-6));

axiom ((forall <T0> $f: Field T0 :: { IsModelField($f, ACCOUNT_4) } (IsModelField($f, ACCOUNT_4)) <==> ((($f) == (subjects)) || (($f) == (observers)))));

function { :inline } ACCOUNT_4.user_inv(heap: HeapType, current: ref) returns (bool) {
  ((0) >= (heap[current, ACCOUNT_4.credit_limit])) && (Set#IsEmpty(heap[current, observers])) && (Set#IsEmpty(heap[current, subjects])) && (Set#IsEmpty(heap[current, owns])) && (admissibility2(heap, current))
}

axiom ((forall heap: HeapType, current: ref :: { user_inv(heap, current) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((user_inv(heap, current)) <==> (ACCOUNT_4.user_inv(heap, current)))));

axiom ((forall heap: HeapType, current: ref :: { user_inv(heap, current) } (attached(heap, current, ACCOUNT_4)) ==> ((user_inv(heap, current)) ==> (ACCOUNT_4.user_inv(heap, current)))));

procedure ACCOUNT_4.invariant_admissibility_check(Current: ref);
  requires attached_exact(Heap, Current, ACCOUNT_4);



implementation ACCOUNT_4.invariant_admissibility_check(Current: ref)
{
  entry:
  goto pre, a2, a3;
  pre:
  assert user_inv_readable(Heap, Current)[Current, ACCOUNT_4.credit_limit]; // type:access tag:attribute_readable line:100 cid:39 fid:80
  assume (0) >= (Heap[Current, ACCOUNT_4.credit_limit]);
  return;
  a2:
  assume user_inv(Heap, Current);
  assert admissibility2(Heap, Current); // type:A2
  return;
  a3:
  assume user_inv(Heap, Current);
  assert admissibility3(Heap, Current); // type:A3
  return;
}

procedure create.ACCOUNT_4.make(Current: ref);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  modifies Heap;
  ensures (Heap[Current, ACCOUNT_4.balance]) == (0); // type:post tag:balance_set line:23
  ensures (Heap[Current, ACCOUNT_4.credit_limit]) == (0); // type:post tag:credit_limit_set line:24
  requires (forall <T1> $f: Field T1 :: (($f) != (allocated)) ==> ((Heap[Current, $f]) == (Default($f))));
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.make(Heap, Current), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.make(old(Heap), Current));
  free ensures HeapSucc(old(Heap), Heap);
  ensures is_wrapped(Heap, Current); // type:post tag:default_is_wrapped default:contracts



implementation create.ACCOUNT_4.make(Current: ref)
{
  entry:
  assume {:captureState "create.ACCOUNT_4.make"} true;
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:20
  // balance := 0
  call update_heap(Current, ACCOUNT_4.balance, 0); // line:20
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:21
  // credit_limit := 0
  call update_heap(Current, ACCOUNT_4.credit_limit, 0); // line:21
  if (*) {
    assert (0) >= (Heap[Current, ACCOUNT_4.credit_limit]); // type:inv tag:credit_limit_not_positive line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, observers]); // type:inv tag:default_observers line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, subjects]); // type:inv tag:default_subjects line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, owns]); // type:inv tag:default_owns line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert admissibility2(Heap, Current); // type:inv tag:A2 line:79 cid:4 rid:53
    assume false;
  }
  call wrap(Current); // default:wrapping cid:4 rid:53 line:25
}

procedure ACCOUNT_4.available_amount(Current: ref) returns (Result: int where is_integer_32(Result));
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  modifies Heap;
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.available_amount(Heap, Current), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.available_amount(old(Heap), Current));
  free ensures HeapSucc(old(Heap), Heap);
  free requires Frame#Subset(read.fun.ACCOUNT_4.available_amount(Heap, Current), readable);



function fun.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (int);

function fun0.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (int);

axiom ((forall heap: HeapType, current: ref :: { fun.ACCOUNT_4.available_amount(heap, current) } (pre.fun.ACCOUNT_4.available_amount(heap, current)) ==> (is_integer_32(fun.ACCOUNT_4.available_amount(heap, current)))));

axiom ((forall heap: HeapType, current: ref :: { fun.ACCOUNT_4.available_amount(heap, current) } { trigger.fun.ACCOUNT_4.available_amount(heap, current) } (pre.fun.ACCOUNT_4.available_amount(heap, current)) ==> ((fun.ACCOUNT_4.available_amount(heap, current)) == ((heap[current, ACCOUNT_4.balance]) - (heap[current, ACCOUNT_4.credit_limit])))));

axiom ((forall heap: HeapType, current: ref :: { fun.ACCOUNT_4.available_amount(heap, current) } (fun.ACCOUNT_4.available_amount(heap, current)) == (fun0.ACCOUNT_4.available_amount(heap, current))));

axiom ((forall h: HeapType, h': HeapType, current: ref :: { HeapSucc(h, h'), fun0.ACCOUNT_4.available_amount(h, current), fun0.ACCOUNT_4.available_amount(h', current) } ((HeapSucc(h, h')) && (pre.fun.ACCOUNT_4.available_amount(h, current)) && (pre.fun.ACCOUNT_4.available_amount(h', current)) && (same_inside(h, h', read.fun.ACCOUNT_4.available_amount(h, current)))) ==> ((fun0.ACCOUNT_4.available_amount(h, current)) == (fun0.ACCOUNT_4.available_amount(h', current)))));

function { :inline } variant.ACCOUNT_4.available_amount.1(heap: HeapType, current: ref) returns (int) {
  0
}

implementation ACCOUNT_4.available_amount(Current: ref) returns (Result: int)
{

  init_locals:
  Result := 0;

  entry:
  assume {:captureState "ACCOUNT_4.available_amount"} true;
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:40
  // Result := balance - credit_limit
  assert readable[Current, ACCOUNT_4.balance]; // type:access tag:attribute_readable line:40 cid:39 fid:79
  assert readable[Current, ACCOUNT_4.credit_limit]; // type:access tag:attribute_readable line:40 cid:39 fid:80
  Result := (Heap[Current, ACCOUNT_4.balance]) - (Heap[Current, ACCOUNT_4.credit_limit]);
}

procedure ACCOUNT_4.set_credit_limit(Current: ref, limit: int);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  free requires is_integer_32(limit); // info:type property for argument limit
  modifies Heap;
  requires (limit) <= (0); // type:pre tag:limit_not_positive line:48
  requires (limit) <= (Heap[Current, ACCOUNT_4.balance]); // type:pre tag:limit_valid line:49
  ensures (Heap[Current, ACCOUNT_4.credit_limit]) == (limit); // type:post tag:credit_limit_set line:54
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.set_credit_limit(Heap, Current, limit), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.set_credit_limit(old(Heap), Current, limit));
  free ensures HeapSucc(old(Heap), Heap);
  requires is_wrapped(Heap, Current); // type:pre tag:default_is_wrapped default:contracts
  ensures is_wrapped(Heap, Current); // type:post tag:default_is_wrapped default:contracts



function { :inline } variant.ACCOUNT_4.set_credit_limit.1(heap: HeapType, current: ref, limit: int) returns (int) {
  limit
}

implementation ACCOUNT_4.set_credit_limit(Current: ref, limit: int)
{
  entry:
  assume {:captureState "ACCOUNT_4.set_credit_limit"} true;
  call unwrap(Current); // default:wrapping cid:4 rid:55 line:45
  assume ACCOUNT_4.user_inv(Heap, Current);
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:51
  // credit_limit := limit
  call update_heap(Current, ACCOUNT_4.credit_limit, limit); // line:51
  if (*) {
    assert (0) >= (Heap[Current, ACCOUNT_4.credit_limit]); // type:inv tag:credit_limit_not_positive line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, observers]); // type:inv tag:default_observers line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, subjects]); // type:inv tag:default_subjects line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, owns]); // type:inv tag:default_owns line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert admissibility2(Heap, Current); // type:inv tag:A2 line:79 cid:4 rid:53
    assume false;
  }
  call wrap(Current); // default:wrapping cid:4 rid:53 line:55
}

procedure ACCOUNT_4.deposit(Current: ref, amount: int);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  free requires is_integer_32(amount); // info:type property for argument amount
  modifies Heap;
  requires (amount) >= (0); // type:pre tag:amount_non_negative line:60
  ensures (Heap[Current, ACCOUNT_4.balance]) == ((old(Heap)[Current, ACCOUNT_4.balance]) + (amount)); // type:post tag:balance_set line:65
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.deposit(Heap, Current, amount), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.deposit(old(Heap), Current, amount));
  free ensures HeapSucc(old(Heap), Heap);
  requires is_wrapped(Heap, Current); // type:pre tag:default_is_wrapped default:contracts
  ensures is_wrapped(Heap, Current); // type:post tag:default_is_wrapped default:contracts



function { :inline } variant.ACCOUNT_4.deposit.1(heap: HeapType, current: ref, amount: int) returns (int) {
  amount
}

implementation ACCOUNT_4.deposit(Current: ref, amount: int)
{
  entry:
  assume {:captureState "ACCOUNT_4.deposit"} true;
  call unwrap(Current); // default:wrapping cid:4 rid:55 line:57
  assume ACCOUNT_4.user_inv(Heap, Current);
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:62
  // balance := balance - amount
  call update_heap(Current, ACCOUNT_4.balance, (Heap[Current, ACCOUNT_4.balance]) - (amount)); // line:62
  if (*) {
    assert (0) >= (Heap[Current, ACCOUNT_4.credit_limit]); // type:inv tag:credit_limit_not_positive line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, observers]); // type:inv tag:default_observers line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, subjects]); // type:inv tag:default_subjects line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, owns]); // type:inv tag:default_owns line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert admissibility2(Heap, Current); // type:inv tag:A2 line:79 cid:4 rid:53
    assume false;
  }
  call wrap(Current); // default:wrapping cid:4 rid:53 line:66
}

procedure ACCOUNT_4.withdraw(Current: ref, amount: int);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  free requires is_integer_32(amount); // info:type property for argument amount
  modifies Heap;
  requires (amount) >= (0); // type:pre tag:amount_not_negative line:71
  requires (amount) <= (fun.ACCOUNT_4.available_amount(Heap, Current)); // type:pre tag:amount_available line:72
  ensures (Heap[Current, ACCOUNT_4.balance]) == ((old(Heap)[Current, ACCOUNT_4.balance]) - (amount)); // type:post tag:balance_set line:77
  ensures (Heap[Current, ACCOUNT_4.balance]) <= (old(Heap)[Current, ACCOUNT_4.balance]); // type:post tag:balance_decrease line:78
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.withdraw(Heap, Current, amount), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.withdraw(old(Heap), Current, amount));
  free ensures HeapSucc(old(Heap), Heap);
  requires is_wrapped(Heap, Current); // type:pre tag:default_is_wrapped default:contracts
  ensures is_wrapped(Heap, Current); // type:post tag:default_is_wrapped default:contracts



function { :inline } variant.ACCOUNT_4.withdraw.1(heap: HeapType, current: ref, amount: int) returns (int) {
  amount
}

implementation ACCOUNT_4.withdraw(Current: ref, amount: int)
{
  entry:
  assume {:captureState "ACCOUNT_4.withdraw"} true;
  call unwrap(Current); // default:wrapping cid:4 rid:55 line:68
  assume ACCOUNT_4.user_inv(Heap, Current);
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:74
  // balance := balance - amount
  call update_heap(Current, ACCOUNT_4.balance, (Heap[Current, ACCOUNT_4.balance]) - (amount)); // line:74
  if (*) {
    assert (0) >= (Heap[Current, ACCOUNT_4.credit_limit]); // type:inv tag:credit_limit_not_positive line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, observers]); // type:inv tag:default_observers line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, subjects]); // type:inv tag:default_subjects line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert Set#IsEmpty(Heap[Current, owns]); // type:inv tag:default_owns line:79 cid:4 rid:53
    assume false;
  }
  if (*) {
    assert admissibility2(Heap, Current); // type:inv tag:A2 line:79 cid:4 rid:53
    assume false;
  }
  call wrap(Current); // default:wrapping cid:4 rid:53 line:79
}

procedure ACCOUNT_4.transfer(Current: ref, amount: int, other: ref);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  free requires is_integer_32(amount); // info:type property for argument amount
  free requires attached(Heap, other, ACCOUNT_4); // info:type property for argument other
  modifies Heap;
  requires (other) != (Void); // type:pre tag:other /= Void line:86
  requires ((amount) >= (0)) && ((0) >= (Heap[Current, ACCOUNT_4.credit_limit])); // type:pre tag:amount_not_negative line:87
  requires (amount) <= (fun.ACCOUNT_4.available_amount(Heap, Current)); // type:pre tag:amount_available line:88
  requires (Current) != (other); // type:pre tag:not_alias line:89
  ensures (Heap[Current, ACCOUNT_4.balance]) == ((old(Heap)[Current, ACCOUNT_4.balance]) - (amount)); // type:post tag:withdrawal_made line:95
  ensures (other) != (Void); // type:attached tag:desposit_made line:96
  ensures (Heap[other, ACCOUNT_4.balance]) == ((old(Heap)[other, ACCOUNT_4.balance]) + (amount)); // type:post tag:desposit_made line:96
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.transfer(Heap, Current, amount, other), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.transfer(old(Heap), Current, amount, other));
  free ensures HeapSucc(old(Heap), Heap);
  requires is_wrapped(Heap, Current); // type:pre tag:default_is_wrapped default:contracts
  ensures is_wrapped(Heap, Current); // type:post tag:default_is_wrapped default:contracts
  requires is_wrapped(Heap, other); // type:pre tag:arg_other_is_wrapped default:contracts
  ensures is_wrapped(Heap, other); // type:post tag:arg_other_is_wrapped default:contracts



function { :inline } variant.ACCOUNT_4.transfer.1(heap: HeapType, current: ref, amount: int, other: ref) returns (int) {
  amount
}

function { :inline } variant.ACCOUNT_4.transfer.2(heap: HeapType, current: ref, amount: int, other: ref) returns (ref) {
  other
}

implementation ACCOUNT_4.transfer(Current: ref, amount: int, other: ref)
{
  entry:
  assume {:captureState "ACCOUNT_4.transfer"} true;
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:91
  // withdraw (amount)
  call ACCOUNT_4.withdraw(Current, amount); // line:91 cid:39 rid:1055
  // C:\Users\HP\Documents\GitHub\Proof2Test\examples\applications\account\account_4.e:92
  // other.deposit (amount)
  assert {:subsumption 0} (other) != (Void); // type:attached line:92
  call ACCOUNT_4.deposit(other, amount); // line:92 cid:39 rid:1054
}

const ACCOUNT_4.credit_limit: Field int;

axiom ((FieldId(ACCOUNT_4.credit_limit, ACCOUNT_4)) == (80));

axiom ((forall heap: HeapType, o: ref :: { heap[o, ACCOUNT_4.credit_limit] } ((IsHeap(heap)) && (attached(heap, o, ACCOUNT_4))) ==> (is_integer_32(heap[o, ACCOUNT_4.credit_limit]))));

axiom ((forall heap: HeapType, current: ref, v: int, o: ref :: { guard(heap, current, ACCOUNT_4.credit_limit, v, o) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, ACCOUNT_4.credit_limit, v, o)) <==> ((user_inv(heap, o)) ==> (user_inv(heap[current, ACCOUNT_4.credit_limit := v], o))))));

axiom ((forall heap: HeapType, current: ref, v: int, o: ref :: { guard(heap, current, ACCOUNT_4.credit_limit, v, o) } (attached(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, ACCOUNT_4.credit_limit, v, o)) ==> ((user_inv(heap, o)) ==> (user_inv(heap[current, ACCOUNT_4.credit_limit := v], o))))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, owns, v, o) } (attached_exact(heap, current, ANY)) ==> ((guard(heap, current, owns, v, o)) <==> (true))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, subjects, v, o) } (attached_exact(heap, current, ANY)) ==> ((guard(heap, current, subjects, v, o)) <==> (true))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, observers, v, o) } (attached_exact(heap, current, ANY)) ==> ((guard(heap, current, observers, v, o)) <==> (fun.ANY.in_observers(heap, current, v, o)))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, observers, v, o) } (attached(heap, current, ANY)) ==> ((guard(heap, current, observers, v, o)) ==> (fun.ANY.in_observers(heap, current, v, o)))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, owns, v, o) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, owns, v, o)) <==> (true))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, subjects, v, o) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, subjects, v, o)) <==> (true))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, observers, v, o) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, observers, v, o)) <==> (fun.ACCOUNT_4.in_observers(heap, current, v, o)))));

axiom ((forall heap: HeapType, current: ref, v: Set (ref), o: ref :: { guard(heap, current, observers, v, o) } (attached(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, observers, v, o)) ==> (fun.ACCOUNT_4.in_observers(heap, current, v, o)))));

const ACCOUNT_4.balance: Field int;

axiom ((FieldId(ACCOUNT_4.balance, ACCOUNT_4)) == (79));

axiom ((forall heap: HeapType, o: ref :: { heap[o, ACCOUNT_4.balance] } ((IsHeap(heap)) && (attached(heap, o, ACCOUNT_4))) ==> (is_integer_32(heap[o, ACCOUNT_4.balance]))));

axiom ((forall heap: HeapType, current: ref, v: int, o: ref :: { guard(heap, current, ACCOUNT_4.balance, v, o) } (attached_exact(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, ACCOUNT_4.balance, v, o)) <==> ((user_inv(heap, o)) ==> (user_inv(heap[current, ACCOUNT_4.balance := v], o))))));

axiom ((forall heap: HeapType, current: ref, v: int, o: ref :: { guard(heap, current, ACCOUNT_4.balance, v, o) } (attached(heap, current, ACCOUNT_4)) ==> ((guard(heap, current, ACCOUNT_4.balance, v, o)) ==> ((user_inv(heap, o)) ==> (user_inv(heap[current, ACCOUNT_4.balance := v], o))))));

function modify.ACCOUNT_4.make(heap: HeapType, current: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref :: (IsHeap(heap)) ==> ((forall <T2> $o: ref, $f: Field T2 :: { modify.ACCOUNT_4.make(heap, current)[$o, $f] } (modify.ACCOUNT_4.make(heap, current)[$o, $f]) <==> (($o) == (current))))));

function modify.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref :: (IsHeap(heap)) ==> ((forall <T3> $o: ref, $f: Field T3 :: { modify.ACCOUNT_4.available_amount(heap, current)[$o, $f] } (modify.ACCOUNT_4.available_amount(heap, current)[$o, $f]) <==> (false)))));

function read.fun.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref :: (IsHeap(heap)) ==> ((forall <T4> $o: ref, $f: Field T4 :: { read.fun.ACCOUNT_4.available_amount(heap, current)[$o, $f] } (read.fun.ACCOUNT_4.available_amount(heap, current)[$o, $f]) <==> ((universe[$o]) && (($f) != (closed)) && (($f) != (owner)))))));

function pre.fun.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (bool) {
  true
}

function trigger.fun.ACCOUNT_4.available_amount(heap: HeapType, current: ref) returns (bool);

function modify.ACCOUNT_4.set_credit_limit(heap: HeapType, current: ref, limit: int) returns (Frame);

axiom ((forall heap: HeapType, current: ref, limit: int :: (IsHeap(heap)) ==> ((forall <T5> $o: ref, $f: Field T5 :: { modify.ACCOUNT_4.set_credit_limit(heap, current, limit)[$o, $f] } (modify.ACCOUNT_4.set_credit_limit(heap, current, limit)[$o, $f]) <==> ((($o) == (current)) && ((($f) == (ACCOUNT_4.credit_limit)) || (($f) == (closed))))))));

function modify.ACCOUNT_4.deposit(heap: HeapType, current: ref, amount: int) returns (Frame);

axiom ((forall heap: HeapType, current: ref, amount: int :: (IsHeap(heap)) ==> ((forall <T6> $o: ref, $f: Field T6 :: { modify.ACCOUNT_4.deposit(heap, current, amount)[$o, $f] } (modify.ACCOUNT_4.deposit(heap, current, amount)[$o, $f]) <==> ((($o) == (current)) && ((($f) == (ACCOUNT_4.balance)) || (($f) == (closed))))))));

function modify.ACCOUNT_4.withdraw(heap: HeapType, current: ref, amount: int) returns (Frame);

axiom ((forall heap: HeapType, current: ref, amount: int :: (IsHeap(heap)) ==> ((forall <T7> $o: ref, $f: Field T7 :: { modify.ACCOUNT_4.withdraw(heap, current, amount)[$o, $f] } (modify.ACCOUNT_4.withdraw(heap, current, amount)[$o, $f]) <==> ((($o) == (current)) && ((($f) == (ACCOUNT_4.balance)) || (($f) == (closed))))))));

function modify.ACCOUNT_4.transfer(heap: HeapType, current: ref, amount: int, other: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref, amount: int, other: ref :: (IsHeap(heap)) ==> ((forall <T8> $o: ref, $f: Field T8 :: { modify.ACCOUNT_4.transfer(heap, current, amount, other)[$o, $f] } (modify.ACCOUNT_4.transfer(heap, current, amount, other)[$o, $f]) <==> (((($o) == (current)) || (($o) == (other))) && ((($f) == (ACCOUNT_4.balance)) || (($f) == (closed))))))));

procedure ANY.in_observers(Current: ref, new_observers: Set (ref), o: ref) returns (Result: bool where true);
  free requires attached_exact(Heap, Current, ANY); // info:type property for argument Current
  free requires Set#ItemsType(Heap, new_observers, ANY); // info:type property for argument new_observers
  free requires ((o) != (Void)) && (Heap[o, allocated]); // info:type property for argument o
  modifies Heap;
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ANY.in_observers(Heap, Current, new_observers, o), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ANY.in_observers(old(Heap), Current, new_observers, o));
  free ensures HeapSucc(old(Heap), Heap);
  free requires Frame#Subset(read.fun.ANY.in_observers(Heap, Current, new_observers, o), readable);



function fun.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

function fun0.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: { fun.ANY.in_observers(heap, current, new_observers, o) } { trigger.fun.ANY.in_observers(heap, current, new_observers, o) } (pre.fun.ANY.in_observers(heap, current, new_observers, o)) ==> ((fun.ANY.in_observers(heap, current, new_observers, o)) == ((attached(heap, o, ANY)) && (new_observers[o])))));

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: { fun.ANY.in_observers(heap, current, new_observers, o) } (fun.ANY.in_observers(heap, current, new_observers, o)) == (fun0.ANY.in_observers(heap, current, new_observers, o))));

axiom ((forall h: HeapType, h': HeapType, current: ref, new_observers: Set (ref), o: ref :: { HeapSucc(h, h'), fun0.ANY.in_observers(h, current, new_observers, o), fun0.ANY.in_observers(h', current, new_observers, o) } ((HeapSucc(h, h')) && (pre.fun.ANY.in_observers(h, current, new_observers, o)) && (pre.fun.ANY.in_observers(h', current, new_observers, o)) && (same_inside(h, h', read.fun.ANY.in_observers(h, current, new_observers, o)))) ==> ((fun0.ANY.in_observers(h, current, new_observers, o)) == (fun0.ANY.in_observers(h', current, new_observers, o)))));

procedure ACCOUNT_4.in_observers(Current: ref, new_observers: Set (ref), o: ref) returns (Result: bool where true);
  free requires attached_exact(Heap, Current, ACCOUNT_4); // info:type property for argument Current
  free requires Set#ItemsType(Heap, new_observers, ANY); // info:type property for argument new_observers
  free requires ((o) != (Void)) && (Heap[o, allocated]); // info:type property for argument o
  modifies Heap;
  free requires global(Heap);
  free requires global_permissive();
  free ensures global(Heap);
  requires Frame#Subset(modify.ACCOUNT_4.in_observers(Heap, Current, new_observers, o), writable); // type:pre tag:frame_writable
  free requires closed_under_domains(writable, Heap);
  free ensures same_outside(old(Heap), Heap, modify.ACCOUNT_4.in_observers(old(Heap), Current, new_observers, o));
  free ensures HeapSucc(old(Heap), Heap);
  free requires Frame#Subset(read.fun.ACCOUNT_4.in_observers(Heap, Current, new_observers, o), readable);



function fun.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

function fun0.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: { fun.ACCOUNT_4.in_observers(heap, current, new_observers, o) } { trigger.fun.ACCOUNT_4.in_observers(heap, current, new_observers, o) } (pre.fun.ACCOUNT_4.in_observers(heap, current, new_observers, o)) ==> ((fun.ACCOUNT_4.in_observers(heap, current, new_observers, o)) == ((attached(heap, o, ANY)) && (new_observers[o])))));

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: { fun.ACCOUNT_4.in_observers(heap, current, new_observers, o) } (fun.ACCOUNT_4.in_observers(heap, current, new_observers, o)) == (fun0.ACCOUNT_4.in_observers(heap, current, new_observers, o))));

axiom ((forall h: HeapType, h': HeapType, current: ref, new_observers: Set (ref), o: ref :: { HeapSucc(h, h'), fun0.ACCOUNT_4.in_observers(h, current, new_observers, o), fun0.ACCOUNT_4.in_observers(h', current, new_observers, o) } ((HeapSucc(h, h')) && (pre.fun.ACCOUNT_4.in_observers(h, current, new_observers, o)) && (pre.fun.ACCOUNT_4.in_observers(h', current, new_observers, o)) && (same_inside(h, h', read.fun.ACCOUNT_4.in_observers(h, current, new_observers, o)))) ==> ((fun0.ACCOUNT_4.in_observers(h, current, new_observers, o)) == (fun0.ACCOUNT_4.in_observers(h', current, new_observers, o)))));

function modify.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: (IsHeap(heap)) ==> ((forall <T9> $o: ref, $f: Field T9 :: { modify.ANY.in_observers(heap, current, new_observers, o)[$o, $f] } (modify.ANY.in_observers(heap, current, new_observers, o)[$o, $f]) <==> (false)))));

function read.fun.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: (IsHeap(heap)) ==> ((forall <T10> $o: ref, $f: Field T10 :: { read.fun.ANY.in_observers(heap, current, new_observers, o)[$o, $f] } (read.fun.ANY.in_observers(heap, current, new_observers, o)[$o, $f]) <==> ((universe[$o]) && (($f) != (closed)) && (($f) != (owner)))))));

function pre.fun.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool) {
  true
}

function trigger.fun.ANY.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

function modify.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: (IsHeap(heap)) ==> ((forall <T11> $o: ref, $f: Field T11 :: { modify.ACCOUNT_4.in_observers(heap, current, new_observers, o)[$o, $f] } (modify.ACCOUNT_4.in_observers(heap, current, new_observers, o)[$o, $f]) <==> (false)))));

function read.fun.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (Frame);

axiom ((forall heap: HeapType, current: ref, new_observers: Set (ref), o: ref :: (IsHeap(heap)) ==> ((forall <T12> $o: ref, $f: Field T12 :: { read.fun.ACCOUNT_4.in_observers(heap, current, new_observers, o)[$o, $f] } (read.fun.ACCOUNT_4.in_observers(heap, current, new_observers, o)[$o, $f]) <==> ((universe[$o]) && (($f) != (closed)) && (($f) != (owner)))))));

function pre.fun.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool) {
  true
}

function trigger.fun.ACCOUNT_4.in_observers(heap: HeapType, current: ref, new_observers: Set (ref), o: ref) returns (bool);

