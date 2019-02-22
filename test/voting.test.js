const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

const {interface , bytecode } = require('../compile');

let voting;
let accounts;

beforeEach(async () => {
 accounts = await web3.eth.getAccounts(); 
 
 voting = await new web3.eth.Contract(JSON.parse(interface))
   .deploy({data : bytecode })
   .send({ from: accounts[0] , gas: '2000000' });

});

describe('E-voting Contract', () => {
  it('deploys a contract', () => {
    assert.ok(voting.options.address);
  });


  it('allows one account to enter', async() => {
    await voting.methods.addCandidate('cand1','party1').send({
        from: accounts[0]
    });
    const result = await voting.methods.candidate.call({
      from : accounts[0]
    });
    assert.equal (result[0],'cand1',);
    assert.equal (result[1], 'party1');

   /* const numcandidates = await voting.methods.getNumOfCandidates().call({
      from: accounts[0]
    });
    assert.equal(accounts[0],candidate[0]);
    assert.equal(1,numcandidates);*/
});

  
});