//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "./Interfaces/IERC20.sol";
// this will not work because for EACH erc20 token you will need a different approve
// to this contract, defying the purpose of it.
// If that weren't the case you would save 21k * (N - 1) gas.
contract BatchSendERC20 {
    event TransferFailure(bytes reason);
    function batchSend(
        IERC20[] calldata erc20,
        uint256[] calldata amount,
        address[] calldata to
    ) external {
        for (uint256 i = 0; i < erc20.length; i++) {
            try erc20[i].transferFrom(msg.sender, to[i], amount[i]) {
            } catch (bytes memory reason) {
                emit TransferFailure(reason);
            }
        }
    }
}
