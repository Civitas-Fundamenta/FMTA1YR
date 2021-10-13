const role = require("./roles.js");

let MinterContract = artifacts.require('minter');
let TokenContract = artifacts.require('FMTAToken');

exports.deployTokenContract = async(creator) =>
{
    return await TokenContract.new({ from: creator });
}

exports.deployMinterContract = async(creator) =>
{
    //Don't worry about deploying the nft for right now
    return await MinterContract.new("0x0000000000000000000000000000000000000000", { from: creator });
}
