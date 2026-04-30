// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {MyToken} from "../MyToken.sol";
import {LPToken} from "./LPToken.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract LiquidityPool {
    using Math for uint256;
    
    // 流动性池中代币的合约地址
    address public token;
    // 流动性池LP代币的合约地址
    address public lpToken;
    // 流动性池中代币的储备量
    uint256 public tokenReserve;
    // 流动性池中ETH的储备量
    uint256 public ethReserve;
    
    constructor(address _token, address _lpToken) {
        token = _token;
        lpToken = _lpToken;
    }

    // 添加流动性
    function addLiquidity(uint256 tokenAmount)
        public
        payable
        returns (uint256 lpAmount)
    {
        // 步骤1: 检查条件
        require(msg.value > 0,"Must send ETH");
        require(tokenAmount > 0,"Must provide tokens");
        // 步骤2: 转移代币到合约
        MyToken(token).transferFrom(msg.sender,address(this),tokenAmount);
        // 步骤3: 获取LP Token总供应量
        uint256 lpTotalSupply = LPToken(lpToken).totalSupply();
        // 步骤4: 计算应该铸造多少LP Token
        // 如果是首次添加，使用sqrt
        // 如果不是，使用比例计算
        if (lpTotalSupply == 0){
            lpAmount = Math.sqrt(tokenAmount * msg.value);
        } 
        else{
            uint256 lpAmountByEth = msg.value * lpTotalSupply/ ethReserve;
            uint256 lpAmountByToken = tokenAmount * lpTotalSupply / tokenReserve;
            lpAmount = Math.min(lpAmountByEth, lpAmountByToken);
        }
        // 步骤5: 检查lpAmount是否大于0
        require(lpAmount > 0 ,"Insufficient liquidity minted");
        // 步骤6: 铸造LP Token给用户（铸造会自动更新totalSupply）
        LPToken(lpToken).mint(msg.sender,lpAmount);
        // 步骤7: 更新储备量
        ethReserve += msg.value;
        tokenReserve += tokenAmount;

        // 步骤8: 返回lpAmount
        return lpAmount;
    }

    // 移除流动性
    function removeLiquidity(uint256 lpAmount)
        public
        returns (uint256 tokenAmount, uint256 ethAmount)
    {
        require(lpAmount > 0,"Insufficient liquidity minted");
        uint256 lpTotalSupply = LPToken(lpToken).totalSupply();

        tokenAmount = lpAmount * tokenReserve / lpTotalSupply;
        ethAmount = lpAmount * ethReserve / lpTotalSupply;

        require(tokenAmount > 0 && ethAmount > 0,"Insufficient liquidity");

        LPToken(lpToken).burn(msg.sender,lpAmount);
        MyToken(token).transfer(msg.sender,tokenAmount);
        payable(msg.sender).transfer(ethAmount);

        tokenReserve -= tokenAmount;
        ethReserve -= ethAmount;

        return (tokenAmount,ethAmount);
    }

    // 代币换ETH（池子中的token换ETH）
    function swapTokenForETH(uint256 tokenAmount, uint256 minEthOut)
        public
        returns (uint256 ethOut)
    {
        require(tokenAmount > 0, "Must provide tokens");
        
        uint256 newTokenReserve = tokenReserve + tokenAmount;
        uint256 newEthReserve = (tokenReserve * ethReserve) / newTokenReserve;
        
        ethOut = ethReserve - newEthReserve;
        
        require(ethOut >= minEthOut, "Slippage too high");
        
        MyToken(token).transferFrom(msg.sender, address(this), tokenAmount);
        payable(msg.sender).transfer(ethOut);
        
        tokenReserve = newTokenReserve;
        ethReserve = newEthReserve;
        
        return ethOut;
    }

    // ETH换代币
    function swapETHForToken(uint256 minTokenOut)
        public
        payable
        returns (uint256 tokenOut)
    {
        require(msg.value > 0, "Must send ETH");
        
        uint256 newEthReserve = ethReserve + msg.value;
        uint256 newTokenReserve = (tokenReserve * ethReserve) / newEthReserve;
        
        tokenOut = tokenReserve - newTokenReserve;
        
        require(tokenOut >= minTokenOut, "Slippage too high");
        
        MyToken(token).transfer(msg.sender, tokenOut);
        
        tokenReserve = newTokenReserve;
        ethReserve = newEthReserve;
        
        return tokenOut;
    }
}
