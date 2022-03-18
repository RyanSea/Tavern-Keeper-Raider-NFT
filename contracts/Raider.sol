//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Raider is ERC721URIStorage, Ownable {

    struct Attributes {

        address _address;
        uint raider_id;          //Raider NFT ID
        string primary_skill;    
        string secondary_skill;  
        string[] achievements;    //List of Achievements (e.g. Raids)
        uint[] achievement_ids;  //Achievement NFT ID's
        
    }
    //Discord ID => Attributes
    mapping(uint => Attributes) public Raiders;
    //Raider NFT ID counter
    uint public id = 1;
    //Achievement NFT ID Counter
    uint public achievement_id = 1;

    event RaiderMinted(uint256 indexed discord_id, address indexed user , uint256 indexed nft_id);
    event NewAchievement(uint indexed discord_id, string achievement);
    event AchievementMinted(uint indexed discord_id, address indexed user, uint256 indexed nft_id, string achievement);

    constructor() ERC721("Raider Guild Avatars","RAIDER") {}

    //Initializes Attribute Struct with Discord ID and Primary + Secondary Skills
    function createProfile(uint discord_id, string calldata primary, string calldata secondary, address _address, string calldata uri) public onlyOwner{

        Attributes memory raider;
        raider.primary_skill = primary;
        raider.secondary_skill = secondary;
        raider._address = _address;
        Raiders[discord_id] = raider;
        mintRaider(discord_id, uri);
        
    }

    //Mints Raider NFT
    function mintRaider(uint discord_id, string calldata uri) public onlyOwner{

        Raiders[discord_id].raider_id = id;
        _mint(Raiders[discord_id]._address, id);
        _setTokenURI(id, uri);
        

        emit RaiderMinted(discord_id, Raiders[discord_id]._address, id);
        id++;
    }

    function mintAchievement(uint discord_id, string calldata achievement, string calldata uri) public onlyOwner{

        Raiders[discord_id].achievement_ids.push(achievement_id);
        _mint(Raiders[discord_id]._address, achievement_id);
        _setTokenURI(achievement_id, uri);

        emit AchievementMinted(discord_id, Raiders[discord_id]._address, achievement_id, achievement);
        achievement_id++;
    }

    function addAchievement(uint discord_id, string calldata achievement) public onlyOwner{

        Raiders[discord_id].achievements.push(achievement);

        emit NewAchievement(discord_id, achievement);
    }

    function changeAvatar(uint nft_id, string calldata new_uri) public onlyOwner{

        _setTokenURI(nft_id, new_uri);

    }

}