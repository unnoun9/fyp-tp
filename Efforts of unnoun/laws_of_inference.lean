theorem not_q (p q r : Prop) (h1 : p → (q → r)) (h2 : p) (h3 : ¬r) : ¬q := by
    have h4 := h1 h2
    intro hc
    have h5 := h4 hc
    exact h3 h5
