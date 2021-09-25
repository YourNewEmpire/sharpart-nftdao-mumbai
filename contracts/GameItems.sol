// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract GameItems is ERC1155, Ownable {
    // Assign number to act as token ID for Coins, art etc.
    uint256 public constant COINS = 0;
    uint256 public constant ART = 1;
    mapping(uint256 => mapping(address => bool)) public voted;

    // Me, the deployer
    address public chairperson;

    // Check that the sender has any nft. I could do this for each/any token ID.
    modifier isNftOwner() {
        require(
            balanceOf(msg.sender, 0) > 0 || balanceOf(msg.sender, 1) > 0,
            "You need NFTs to vote"
        );
        _;
    }

    Proposal[] public proposals;

    constructor() ERC1155("https://sharpart-frontend.vercel.app/nft-metadata/jsons/{id}.json") {
        _mint(msg.sender, COINS, 1, "");
        _mint(msg.sender, ART, 1, "");
        chairperson = msg.sender;
    }

    // Typing for the Proposal object
    struct Proposal {
        bytes32 name; // short name (up to 32 bytes),
        uint256 voteCount; // number of accumulated votes, should use counter util in future
    }

    //Only me, the sender can make proposals.
    function newProposal(bytes32 newName) public onlyOwner {
        proposals.push(Proposal({name: newName, voteCount: 0}));
    }

    //onlyNFTOwner can vote,
    function newVote(uint256 index) public isNftOwner {
        require(
            voted[index][msg.sender] != true,
            "You already voted on this proposal"
        );
        // In future, check that I or the NFT artist cannot vote.
        proposals[index].voteCount++;
        voted[index][msg.sender] = true;
    }
}
