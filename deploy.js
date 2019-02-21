const HDWalletprovider = require("truffle-hdwallet-provider");
const Web3 = require('web3');
const { interface , bytecode } = require( './compile');

const provider = new HDWalletprovider( 'volcano weather brief radio surface slab foot spot uncover walk retreat plate' , 'https://rinkeby.infura.io/v3/328d81183ced440283ab7823ca86f144' );

const web3 = new Web3(provider);

const deploy = async () => {
 
 const accounts = await web3.eth.getAccounts();
 
 console.log('Attempting to delpoy from account',accounts[0]);

 const result = await new web3.eth.Contract(JSON.parse(interface))
   .deploy({ data:bytecode })
   .send({ gas: '1000000',from: accounts[0]   });
 console.log('Contract deployed to' , result.options.address);
};
deploy();

