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
6 is almost equally easy from 3 or 4.
720 is easy too, because of previous result.
7 is a toughie for both bases.
