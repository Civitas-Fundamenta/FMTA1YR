const role = require("./roles.js");

let MinterContract = artifacts.require('minter');
let NftContract = artifacts.require('FMTA1YR');
let TokenContract = artifacts.require('FMTAToken');

exports.deployTokenContract = async(creator) =>
{
    return await TokenContract.new({ from: creator });
}

exports.deployNftContract = async(creator) =>
{
    return await NftContract.new({ from: creator });
}

exports.deployMinterContract = async(creator) =>
{
    return await MinterContract.new({ from: creator });
}
