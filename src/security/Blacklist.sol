// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Blacklist {
    mapping(address => bool) public blacklist;

    event Blacklisted(address account);
    event Unblacklisted(address account);
    
    //查询函数
    function isBlacklisted(address account) public view returns (bool) {
        return blacklist[account];
    }

    //添加黑名单
    function _addToBlacklist(address account) internal {
        blacklist[account] = true;
        emit Blacklisted(account);
    }

    //移除黑名单
    function _removeFromBlacklist(address account) internal {
        blacklist[account] = false;
        emit Unblacklisted(account);
    }

    //检查是否已经在黑名单中
    modifier notBlacklisted(address account) {
        //自定义错误，更省gas
        if (isBlacklisted(account)) {
            revert ("Blacklist: account is blacklisted");
        }
        _;
    }
}
