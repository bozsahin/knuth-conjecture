# knuth-conjecture
Knuth conjecture as a planning problem, i.e. operator sequencing from 3 or 4.

Some examples:
(find-plan :goal-state 26 :current-state 3)

(find-plan :goal-state 26 :current-state 4)

(find-plan :goal-state 6 :current-state 3)

(find-plan :goal-state 6 :current-state 4)

(find-plan :goal-state 720 :current-state 3)

26 takes 4 ops from 4, and 31 ops from 3.

Solutions to 6 and 720 from either base show depth-first effect.

7 is a toughie for both bases. Prepare for garbage-collection or total breakdown.

2 and 1 are very long from either base, and the trick of avoiding ! is a hack. 1 is easy from either base without !,
but 2 is not reachable from 3 without !.

You can avoid the hack by supplying the :operators yourself. Try different orders too. For example,

(find-plan :goal-state 24 :current-state 4 :max-iterations 5 :operators '(op3 op2 op1))

finds a solution to 24 early enough before totally giving up because ops are re-ordered to deliver that.

(find-plan :goal-state (factorial 24) :current-state 4 :max-iterations 10 :operators '(op3 op2 op1))

Finds a solution soon enough, abandoning few paths so that you can see the solution arise in one page.
