const BigNumber = require('bignumber.js');
const role = require("./lib/roles.js");
const setup = require("./lib/setup.js");

contract('Minter', accounts => {
    let tokenContract;
    let nftContract;
    let minterContract;

    let creator = accounts[0];
    let account1 = accounts[1];

    before(async function () {
        //deploy contracts
        tokenContract = await setup.deployTokenContract(creator);
        nftContract = await setup.deployNftContract(creator);
        minterContract = await setup.deployMinterContract(creator);

        //admin roles all around
        await minterContract.grantRole(role.admin, creator, { from: creator });
        await nftContract.grantRole(role.admin, creator, { from: creator });
        await tokenContract.grantRole(role.admin, creator, { from: creator });
        
        //Grant all relevant roles to the creator
        await tokenContract.grantRole(role.mint, creator, { from: creator });
        await tokenContract.grantRole(role.mintTo, creator, { from: creator });
        await tokenContract.grantRole(role.burn, creator, { from: creator });
        await tokenContract.grantRole(role.burnFrom, creator, { from: creator });

        //Grant minter role so users can mint an nft
        await nftContract.grantRole(role.minter, creator, { from: creator });
        await nftContract.grantRole(role.minter, account1, { from: creator });
        await nftContract.grantRole(role.minter, minterContract.address, { from: creator });

        //Turn the contract on
        await tokenContract.setPaused(false, { from: creator });
        await tokenContract.disableMint(false, { from: creator });
        await tokenContract.disableMintTo(false, { from: creator });

        //Configure our dependent contracts
        await minterContract.setFMTA1YR(nftContract.address, { from: creator });
        await minterContract.setFMTA(tokenContract.address, { from: creator });

        //Mint some tokens for everyone
        await tokenContract.mintTo(creator, 10000, { from: creator });
        await tokenContract.mintTo(account1, 10000, { from: creator });
    });

    it('Checking Token Balance', async function ()
    {
        console.log("");
        console.log("Token: " + await minterContract.getFMTA());
        console.log("NFT: " + await minterContract.getFMTA1YR());
        console.log("Creator balance: " + await minterContract.getBalance(creator));
        console.log("Account1 balance: " + await minterContract.getBalance(account1));

        console.log("Running minterContract.mint");
        await minterContract.mint({ from: account1 });
        console.log("OK");

        var tokenURI = await nftContract.tokenURI(1);
        console.log("TokenURI: " + tokenURI);
    });
});