# knuth-conjecture
Knuth conjecture as a planning problem, i.e. operator sequencing from 3 or 4.

Some examples:
(find-plan :goal-state 26 :current-state 3)

(find-plan :goal-state 26 :current-state 4)

(find-plan :goal-state 7 :current-state 3 :max-iterations 2000)

(find-plan :goal-state 7 :current-state 4 :max-iterations 2000)

(find-plan :goal-state 6 :current-state 3)

(find-plan :goal-state 6 :current-state 4)

(find-plan :goal-state 720 :current-state 3)

26 takes 4 ops from 4, and 31 ops from 3.

Solutions to 6 and 720 from either base shows depth-first effect.

7 is a toughie for both bases.

2 and 1 are very long from either base, and the trick of avoiding ! is a hack. 1 is easy from either base without !,
but 2 is not reachable from 3 without !.

You can avoid the hack by supplying the :operators yourself. Try different orders too. For example,

(find-plan :goal-state 24 :current-state 4 :max-iterations 5 :operators '(op3 op2 op1))

finds a solution to 24 early enough without totally giving up because ops are re-ordered to deliver that.
