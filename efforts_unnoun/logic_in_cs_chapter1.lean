-- logic in cs chapter 1 practice in lean 4

variable {p q r s t : Prop}

theorem example_1_7 (h1 : p → (q → r)) (h2 : p) (h3 : ¬r) : ¬q := by
    have h4 := h1 h2
    intro hc
    have h5 := h4 hc
    exact h3 h5

-- exercise 1.2: laws of inference
theorem exercise_1_2_a (h1 : (p ∧ q) ∧ r) (h2 : s ∧ t) : q ∧ s := by
    have h3 := h1.left.right
    have h4 := h2.left
    exact And.intro h3 h4

theorem exercise_1_2_b (h1 : p ∧ q) : q ∧ p := by
    have h2 := h1.left
    have h3 := h1.right
    exact And.intro h3 h2

theorem exercise_1_2_c (h1 : (p ∧ q) ∧ r) : p ∧ (q ∧ r) := by
    have hpq := h1.left
    have hr := h1.right
    have hp := hpq.left
    have hq := hpq.right
    have hqr := And.intro hq hr
    exact And.intro hp hqr

theorem exercise_1_2_d (h1 : p → (p → q)) (h2 : p) : q := by
    exact h1 h2 h2

theorem exercise_1_2_e (h1 : q → (p → r)) (h2 : ¬r) (h3 : q) : ¬p := by
    have hpr := h1 h3
    intro hp
    exact h2 (hpr hp)

theorem exercise_1_2_f : (p ∧ q) → p := by
    intro h
    exact h.left

theorem exercise_1_2_g (h1 : p) : q → (p ∧ q) := by
    intro h2
    exact And.intro h1 h2

theorem exercise_1_2_h (h1 : p) : (p → q) → q := by
    intro h2
    exact h2 h1

theorem exercise_1_2_i (h1 : (p → r) ∧ (q → r)) : p ∧ q → r := by
    intro h2
    have hpr := h1.left
    exact hpr h2.left

set_option linter.unusedVariables false
theorem exercise_1_2_j (h1 : q → r) : (p → q) → (r → r) := by
    intro h2
    intro h3
    exact h3

theorem exercise_1_2_k (h1 : p → (q → r)) (h2 : p → q) : p → r := by
    intro hp
    have hqr := h1 hp
    have hq := h2 hp
    exact hqr hq

theorem exercise_1_2_l (h1 : p → q) (h2 : r → s) : p ∨ r → q ∨ s := by
    intro h
    rcases h with hp | hr
    have hq := h1 hp
    exact Or.inl hq
    have hs := h2 hr
    exact Or.inr hs

theorem exercise_1_2_m (h1 : p ∨ q) : r → (p ∨ q) ∧ r := by
    intro hr
    constructor
    exact h1
    exact hr

theorem exercise_1_2_n (h1 : (p ∨ (q → p)) ∧ q) : p := by
    have h2 := h1.left
    rcases h2 with hp | h
    exact hp
    have hq := h1.right
    exact h hq

theorem exercise_1_2_o (h1 : p → q) (h2 : r → s) : p ∧ r → q ∧ s := by
    intro hpr
    have hq := h1 hpr.left
    have hs := h2 hpr.right
    exact And.intro hq hs

theorem exercise_1_2_p (h1 : p → q) : ((p ∧ q) → p) ∧ (p → (p ∧ q)) := by
    constructor
    intro hpq
    exact hpq.left
    intro hp
    exact And.intro hp (h1 hp)

theorem exercise_1_2_q : q → (p → (p → (q → p))) := by
    intro hq
    intro hp
    intro hp'
    intro hq'
    exact hp

theorem exercise_1_2_r (h1 : p → q ∧ r) : (p → q) ∧ (p → r) := by
    constructor
    intro hp
    exact (h1 hp).left
    intro hp
    exact (h1 hp).right

theorem exercise_1_2_s (h1 : (p → q) ∧ (p → r)) : p → q ∧ r := by
    intro hp
    have hpq := h1.left
    have hpr := h1.right
    exact And.intro (hpq hp) (hpr hp)

theorem exercise_1_2_t : (p → q) → ((r → s) → (p ∧ r → q ∧ s)) := by
    intro hpq
    intro hrs
    exact exercise_1_2_o hpq hrs

theorem exercise_1_2_u (h1 : p → q) : ¬q → ¬p := by
    intro hnq
    intro hp
    have hq := h1 hp
    exact hnq hq

theorem exercise_1_2_v (h1 : p ∨ (p ∧ q)) : p := by
    rcases h1 with hp | hpq
    exact hp
    exact hpq.left

theorem exercise_1_2_w (h1 : r) (h2 : p → (r → q)) : p → (q ∧ r) := by
    intro hp
    have hq : q := h2 hp h1
    exact And.intro hq h1

theorem exercise_1_2_x (h1 : p → (q ∨ r)) (h2 : q → s) (h3 : r → s) : p → s := by
    intro hp
    have h := h1 hp
    rcases h with hq | hr
    exact h2 hq
    exact h3 hr

theorem exercise_1_2_y (h1 : (p ∧ q) ∨ (p ∧ r)) : p ∧ (q ∨ r) := by
    rcases h1 with hpq | hpr
    constructor
    exact hpq.left
    exact Or.inl hpq.right
    constructor
    exact hpr.left
    exact Or.inr hpr.right
