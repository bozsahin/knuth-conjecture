;; Knuth conjecture as a planning problem, i.e. operator sequencing
;; -cem bozsahin, for ODTU COGS512 cognitive algorithms course

;; states : (value cost op-name) pairs where fcount is # of factorials used, and cost is total cost of
;;     reaching the state, and op-name is the name of op that got us to this state
;; operators: functions from state to state
;; tr-method: transition method, i.e. application of an op
;; plan-stack: list of (state (history)) pairs
;;   where history is sequence of operators to reach the state
;; 
;; call it with e.g. (find-plan :goal-state 4)
;;
;; if you want to start from another initial state, supply that as first current state, e.g.
;;   (find-plan :goal-state 9 :current-state 4)  -- this initial state is another variant of Knuth conjecture
;;
;; if you change operators, tr-method goal-test, then supply them in the call to supersede the defaults below.
;;

(defparameter *max-factorizable* 100) ;; no point trying further

(defun factorial (n)
  (do ((j n (- j 1))
       (f 1 (* j f)))
    ((= j 0) f)))

(defun op-name (op)
  (second op))

(defun op-result (op)
  (first op))

(defun plan-state (plan)
  (first plan))

(defun plan-history (plan)
  (second plan))

(defun top (stack)
  (first stack))

(defun state-val (state)
  (first state))

(defun state-cost (state)
  (second state))

(defun state-op (op)
  (third op))

(defun mk-state (val cost op)
  (list val cost op))

(defun mk-history (state seq)
  (list state seq))

(defun op1 (state)  ; operators are functions from state to state
  (if (= (state-val state) 1) nil 
    (if (> (state-val state) most-positive-single-float)
      nil
      (mk-state (sqrt (state-val state)) (+ (state-cost state) 1) 'sqrt))))

(defun op2 (state)
  (if (integerp (state-val state)) nil (mk-state (floor (state-val state)) (+ (state-cost state) 1) 'floor)))

(defun op3 (state)
  (if (integerp (state-val state))
    (if (> (state-val state) *max-factorizable*)
      nil
      (mk-state (factorial (state-val state)) (+ (state-cost state) 1) 'fact))
    nil))

(defun args (&rest argl)
  "apply takes a list of arguments"
  argl)

(defun make-plan (current-state goal-state operators tr-method goal-test plan-stack
				iteration max-iterations)
  (cond ((apply goal-test (args (state-val current-state)(state-val goal-state))) 
	 (plan-history (top plan-stack))) ; goal found
	((null plan-stack) nil)
	((> iteration max-iterations) (format t "Abandoning after ~A iterations" iteration))
	(t (let* ((plan (pop plan-stack))
		  (ph (plan-history plan))
		  (pst (plan-state plan)))
	     (dolist (op operators)
	       (let ((new-config (apply tr-method (args pst op))))
		 (cond  (new-config (push (mk-history new-config 
						      (list (state-op new-config) ph))
					  plan-stack)))))
	     (make-plan (plan-state (top plan-stack)) goal-state operators tr-method goal-test plan-stack (+ iteration 1) max-iterations)))))

(defun find-plan (&key (current-state 3)
		       (goal-state nil)
		       (operators '(op1 op2 op3)) 
		       (tr-method #'(lambda (state op)(apply op (args state))))
		       (goal-test #'equal)
		       (iteration 0)
		       (max-iterations 500))
  "top-level function"
  (make-plan (mk-state current-state 0 nil) (mk-state goal-state 0 nil) operators tr-method goal-test 
	     (list (mk-history (mk-state current-state 0 nil) 
			       (list 'NOOP current-state))) iteration max-iterations))
