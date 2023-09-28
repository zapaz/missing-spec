#!/bin/sh

certoraRun BordaNewBug.sol:Borda                                              \
  --verify Borda:Borda.spec                                                   \
  --msg 'Verified run of Borda.spec on buggy BordaNewBug.sol'                 \
  --send_only

certoraRun Borda.sol:Borda                                                    \
  --verify Borda:bounty_specs/BordaMissingRule.spec                           \
  --msg 'Verified run of BordaMissingRule.spec on original Borda.sol'         \
  --send_only

certoraRun BordaNewBug.sol:Borda                                              \
  --verify Borda:bounty_specs/BordaMissingRule.spec                           \
  --msg 'Non verified run of BordaMissingRule.spec on buggy BordaNewBug.sol'  \
  --send_only

certoraRun Borda.sol:Borda                                                    \
  --verify Borda:bounty_specs/BordaOneCanVote.spec                           \
  --msg 'Verified run of BordaOneCanVote.spec on original Borda.sol'         \
  --send_only

certoraRun BordaNewBug.sol:Borda                                              \
  --verify Borda:bounty_specs/BordaOneCanVote.spec                           \
  --msg 'Non verified run of BordaOneCanVote.spec on buggy BordaNewBug.sol'  \
  --send_only