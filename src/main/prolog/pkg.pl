depends(scala, java).
depends(java, gcc).
depends(ghc, clang).
depends(erlang, prolog).
depends(erlang, clang).
depends(prolog, gcc).

provides(scala, scalac).
provides(scala, scala).
provides(erlang, erl).
provides(java, javac).
provides(prolog, swipl).
provides(ghc, ghci).

common_dep(Pack1, Pack2) :-
  depends(Pack1, Topic),
  depends(Pack2, Topic),
  Pack1 \== Pack2.

deps_needed(Package, What) :-
  depends(Package, What).

deps_needed(Package, What) :-
  depends(Package, X),
  depends(X, What).

deps_to_run(Command, What) :-
  provides(What, Command).

deps_to_run(Command, What) :-
  provides(X, Command),
  deps_needed(X, What).

:- dynamic installed/1.

install(Dep) :-
  installed(Dep).

install(Dep) :-
  assert(installed(Dep)),
  write('Installing '),
  write_term(Dep, []),
  write('\n'),
  installed(Dep).

run(Command) :-
  findall(Dep, deps_to_run(Command, Dep), L),
  reverse(L, Deps),
  forall(member(Dep, Deps), install(Dep)),
  write('Running '),
  write_term(Command, []),
  write('\n'),
  !.
