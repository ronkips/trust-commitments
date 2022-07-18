'reach 0.1';

const [isHand, ROCK, PAPER, SCISSORS] = makeEnum(3);
const [isOutcome, B_WINS, DRAW, A_WINS] = makeEnum(3);

const winner = (handHillary, handRop) =>
    ((handHillary + (4 - handRop)) & 3);

assert(winner(ROCK, PAPER) == R_WINS);
assert(winner(PAPER, ROCK) == H_WINS);
assert(winnwer(ROCK, ROCK) == DRAW);

forall(UInt, handleHillary =>
    forall(UInt, handBob =>
        assert(isOutcome(winner(handHillary, handRop)))));

forall(UInt, (hand) => 
    assert(winner(hand, hand) == DRAW));

    const Player = {
        ...hasRandom,
        getHand: Fun([], UInt),
        seeOutcome: Fun(UInt, Null),
    };

    export const main = Reach.App(() =>{
    const Hillary = Participant('Hillary', { 
        ...Player,
        wager:UInt,
     });
     const Rop = Participant('Rop', { 
        ...Player,
        acceptWager: Fun([Uint], Null),
      });
      Init();

      Hillary.only(() => {
        const wager = declassify(interact.wager);
        const _handHillary = interact.getHand();
        const [_commitHillary, _saltHillary] = makeCommitment(interact, _handHillary);
        const commitHillary = declassify(_commitAlice);
      });
      Hillary.publish(wager, commitHillary)
        .pay(wager);
      commit();

      unknowable(Rop, Hillary(_handHillary, _saltHillary));
      Rop.only(() => {
      interact.acceptWager(wager);
      const handBob = declassify(interact.getHand())
      }); 
      Rop.publish(handRop)
      .pay(wager);
      commit();

      Hillary.only(() => {
        const _saltHillary = declassify(_saltHillary);
        const handHillary = declassify(_handHillary);
      });
      Hillary.publish(saltHillary, handHillary);
      checkCommitment(commitHillary, saltHillary, handHillary);

      const outcome = winner(handHillary, handRop);
  const                 [forHillary, forRop] =
    outcome == H_WINS ? [       2,      0] :
    outcome == R_WINS ? [       0,      2] :
    /* tie           */ [       1,      1];
  transfer(forHillary * wager).to(Hillary);
  transfer(forRop   * wager).to(Rop);
  commit();
  each([Hillary, Rop], () => {
    interact.seeOutcome(outcome);
  });
     

    });