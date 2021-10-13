const BigNumber = require('bignumber.js');
const role = require("./lib/roles.js");
const setup = require("./lib/setup.js");

contract('Minter', accounts => {
    let tokenContract;
    let minterContract;

    let creator = accounts[0];
    let account1 = accounts[1];

    before(async function () {
        tokenContract = await setup.deployTokenContract(creator);
        minterContract = await setup.deployMinterContract(creator);
        
        //Grant all relevant roles to the creator
        await tokenContract.grantRole(role.admin, creator, { from: creator });
        await tokenContract.grantRole(role.mint, creator, { from: creator });
        await tokenContract.grantRole(role.mintTo, creator, { from: creator });
        await tokenContract.grantRole(role.burn, creator, { from: creator });
        await tokenContract.grantRole(role.burnFrom, creator, { from: creator });

        //Turn the contract on
        await tokenContract.setPaused(false, { from: creator });
        await tokenContract.disableMint(false, { from: creator });
        await tokenContract.disableMintTo(false, { from: creator });

        //Mint some tokens for everyone
        await tokenContract.mintTo(creator, 50000, { from: creator });
        await tokenContract.mintTo(account1, 10000, { from: creator });
    });

    it('Checking Token Balance', async function ()
    {
        console.log("");
        console.log("Creator balance: " + await tokenContract.balanceOf(creator));
        console.log("Account1 balance: " + await tokenContract.balanceOf(account1));
    });
});