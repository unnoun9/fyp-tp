/-
//////////////////////// 1.1. Evaluating Expressions ////////////////////////
-/
#eval String.append "hello " "Lean!"
#eval String.append "foo" (String.append "bar" "baz")
#eval String.append "hello" (String.append " " "world")
#eval String.append "it is " (if 1 > 2 then "yes" else "no")
-- This fails: #eval String.append "it is" (if 3 == 3 then 5 else 7)
-- Fix: #eval String.append "it is " (if 3 == 3 then "5" else "7")

-- Exercises:
#eval 42 + 19
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7
#eval if 3 == 4 then "equal" else "not equal"

/-
//////////////////////// 1.2. Types ////////////////////////
-/
#eval (1 + 2 : Nat)
#eval (1 - 2 : Nat)
#eval (1 - 2 : Int)
#check (1 - 2 : Int)
#eval String.append "great" (String.append "oak" "tree")
-- This fails: #check String.append ["hello", " "] "world"
-- This fails: #eval String.append ["oak", "tree"] "great"

/-
//////////////////////// 1.3. Definitions ////////////////////////
-/
-- Defining values
def π := 3.14159
#eval 2 * π
def hello := "Hello"
def lean : String := "Lean"
#eval String.append hello (String.append " " lean)

-- Defining functions
def add1 (n : Nat) : Nat := n + 1
#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then k else n
#eval maximum (5 + 8) (2 * 7)

def spaceBetween (first : String) (second : String) : String :=
  String.append first (String.append " " second)
#eval spaceBetween "Lean" "Rocks"

-- Function types
#check add1
#check maximum
#check maximum 3
#check spaceBetween
#check spaceBetween "foo"

-- Exercises:
def joinStringsWith (sep s t: String) : String :=
  String.append s (String.append sep t)
#eval joinStringsWith "bar" "foo" "baz"

def volume (l w h : Nat) := l * w * h
#check volume
#eval volume 2 3 4

-- Partial application or Currying
#check joinStringsWith ": "
def colonJoin := joinStringsWith ": "
#eval colonJoin "label" "value"

-- Defining types
def str : Type := String
def s : str := "foo"
-- This fails because of number literal's overloading behavior:
-- def NaturalNumber : Type := Nat
-- def thirtyEight : NaturalNumber := 38
-- Fix 1
def NaturalNumber : Type := Nat
def thirtyEight : NaturalNumber := (38 : Nat)
-- Fix 2, using abbrev, which marks the definition of type as reducible
abbrev ℕ : Type := Nat
def thirtyNine : ℕ := 39

/-
//////////////////////// 1.4. Structures ////////////////////////
-/
structure vec2 where
    x : Float
    y : Float
deriving Repr

structure vec3 where
    overridedConstructor ::
    x : Float
    y : Float
    z : Float
deriving Repr

def origin : vec2 := { x := 0, y := 0 }
#eval origin
#check { x := 0, z := 0, y := 0 : vec3 }
#check vec3.overridedConstructor 1 2 3

-- Functions on structures
def vec2.modifyBoth (f : Float → Float ) (u : vec2) : vec2 :=
    { x := f u.x, y := f u.y }
def fourandthree : vec2 := vec2.mk 4.3 3.4
#eval fourandthree.modifyBoth Float.floor

-- Exercises:
structure RectangularPrism where
    width : Float
    height : Float
    depth : Float

def volumeRect (prism : RectangularPrism) : Float :=
    prism.width * prism.height * prism.depth
#check volume

def prism : RectangularPrism := RectangularPrism.mk 1 2 3
#eval volumeRect prism

structure segment where
    end1 : vec2
    end2 : vec2

def segment.length (seg : segment) : Float :=
    Float.sqrt ((seg.end1.x - seg.end2.x) ^ 2 + (seg.end1.y - seg.end2.y) ^ 2)

#check segment.length
def seg : segment := segment.mk (vec2.mk 0 0) (vec2.mk 1 1)
#eval seg.length
