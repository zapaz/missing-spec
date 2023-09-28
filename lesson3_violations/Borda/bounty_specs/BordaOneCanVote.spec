methods {
    function points(address) external returns uint256  envfree;
    function vote(address,address,address) external;
    function voted(address) external returns bool  envfree;
}

ghost mapping(address => bool) voted_mirror {
 init_state axiom forall address a. voted_mirror[a] == false;
}
hook Sstore _voted[KEY address a] bool val (bool old_val) STORAGE {
   voted_mirror[a] = val;
}

invariant votedInvariant(address a)
  voted_mirror[a] == voted(a);

rule oneCanVoteFixed(env e, address f, address s, address t) {
    requireInvariant votedInvariant(e.msg.sender);

    require e.msg.value == 0;
    require (     points(f) <= max_uint256 - 3
              &&  points(s) <= max_uint256 - 2
              &&  points(t) <  max_uint256 - 1  );
    require f!=s && s!=t && f!=t;

    bool alreadyVoted = voted(e.msg.sender);
    vote@withrevert(e, f, s, t);
    bool reverted = lastReverted;
    bool hasVoted = voted(e.msg.sender);

    assert hasVoted;
    assert alreadyVoted <=> reverted;
}