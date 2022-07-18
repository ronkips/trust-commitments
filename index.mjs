import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';
const stdlib = loadStdlib();

const startingBalance = stdlib.parseCurrency(100);
const accHillary = await stdlib.newTestAccount(startingBalance);
const accRop = await stdlib.newTestAccount(startingBalance);

const fmt = (x) => stdlib.formatCurrency(x, 4); // displaying currencie upto four decimal places
const getBalance = async (who) => fmt (await stdlib.balanceOf(who)); //getting the balance of a participant and displaying it upto 4 decimal places 
const beforeHillary = await getBalance(accHillary);
const beforeRop = await getBalance(accRop); // both get the balances before the game starts 

const ctcHillary = accHillary.contract(backend);
const ctcRop = accRop.contract(backend, ctcHillary.getInfo());

const HAND = [ 'Rock', 'Paper', 'Scissors'];
const OUTCOME = ['Rop wins', 'Draw', 'Hillary wins'];
const Player = (Who) => ({
    ...stdlib.hasRandom,
    getHand: () => {
      const hand = Math.floor(Math.random() * 3);
      console.log(`${Who} played ${HAND[hand]}`);
      return hand;  
    },
    seeOutcome: (outcome) => {
        console.log(`${Who} saw outcome ${OUTCOME[outcome]}`);
      },
});
await Promise.all([
    ctcHillary.p.Hillary({
        ...Player('Hillary'),
        wager: stdlib.parseCurrency(5), //using concrete value
    }),
    ctcRop.p.Rop({
        ...Player('Rop'),
        acceptWager: (amt) => {
           console.log(`Rop accepts the wager of ${fmt(amt)}.`);
        },
    }),
  
]);

const afterHillary = await getBalance(accHillary);
const afterRop = await getBalance(accRop);

console.log(`Hillary went from ${beforeHillary} to ${afterHillary}.`);
console.log(`Rop went from ${beforeRop} to ${afterRop}.`);