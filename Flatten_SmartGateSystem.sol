// SPDX-License-Identifier: MIT
pragma solidity <0.9.0 >=0.4.22 >=0.8.24;

// node_modules/@latticexyz/schema-type/src/solidity/SchemaType.sol

using { getStaticByteLength } for SchemaType global;

// WARNING: All enum changes MUST be mirrored for the other languages!
// WARNING: SchemaType methods use hardcoded enum indexes, review them after any changes to the enum
// TODO add and implement BYTES_ARRAY, STRING_ARRAY if they are needed (see https://github.com/latticexyz/mud/issues/447)
enum SchemaType {
  UINT8,
  UINT16,
  UINT24,
  UINT32,
  UINT40,
  UINT48,
  UINT56,
  UINT64,
  UINT72,
  UINT80,
  UINT88,
  UINT96,
  UINT104,
  UINT112,
  UINT120,
  UINT128,
  UINT136,
  UINT144,
  UINT152,
  UINT160,
  UINT168,
  UINT176,
  UINT184,
  UINT192,
  UINT200,
  UINT208,
  UINT216,
  UINT224,
  UINT232,
  UINT240,
  UINT248,
  UINT256,
  INT8,
  INT16,
  INT24,
  INT32,
  INT40,
  INT48,
  INT56,
  INT64,
  INT72,
  INT80,
  INT88,
  INT96,
  INT104,
  INT112,
  INT120,
  INT128,
  INT136,
  INT144,
  INT152,
  INT160,
  INT168,
  INT176,
  INT184,
  INT192,
  INT200,
  INT208,
  INT216,
  INT224,
  INT232,
  INT240,
  INT248,
  INT256,
  BYTES1,
  BYTES2,
  BYTES3,
  BYTES4,
  BYTES5,
  BYTES6,
  BYTES7,
  BYTES8,
  BYTES9,
  BYTES10,
  BYTES11,
  BYTES12,
  BYTES13,
  BYTES14,
  BYTES15,
  BYTES16,
  BYTES17,
  BYTES18,
  BYTES19,
  BYTES20,
  BYTES21,
  BYTES22,
  BYTES23,
  BYTES24,
  BYTES25,
  BYTES26,
  BYTES27,
  BYTES28,
  BYTES29,
  BYTES30,
  BYTES31,
  BYTES32,
  BOOL,
  ADDRESS,
  UINT8_ARRAY,
  UINT16_ARRAY,
  UINT24_ARRAY,
  UINT32_ARRAY,
  UINT40_ARRAY,
  UINT48_ARRAY,
  UINT56_ARRAY,
  UINT64_ARRAY,
  UINT72_ARRAY,
  UINT80_ARRAY,
  UINT88_ARRAY,
  UINT96_ARRAY,
  UINT104_ARRAY,
  UINT112_ARRAY,
  UINT120_ARRAY,
  UINT128_ARRAY,
  UINT136_ARRAY,
  UINT144_ARRAY,
  UINT152_ARRAY,
  UINT160_ARRAY,
  UINT168_ARRAY,
  UINT176_ARRAY,
  UINT184_ARRAY,
  UINT192_ARRAY,
  UINT200_ARRAY,
  UINT208_ARRAY,
  UINT216_ARRAY,
  UINT224_ARRAY,
  UINT232_ARRAY,
  UINT240_ARRAY,
  UINT248_ARRAY,
  UINT256_ARRAY,
  INT8_ARRAY,
  INT16_ARRAY,
  INT24_ARRAY,
  INT32_ARRAY,
  INT40_ARRAY,
  INT48_ARRAY,
  INT56_ARRAY,
  INT64_ARRAY,
  INT72_ARRAY,
  INT80_ARRAY,
  INT88_ARRAY,
  INT96_ARRAY,
  INT104_ARRAY,
  INT112_ARRAY,
  INT120_ARRAY,
  INT128_ARRAY,
  INT136_ARRAY,
  INT144_ARRAY,
  INT152_ARRAY,
  INT160_ARRAY,
  INT168_ARRAY,
  INT176_ARRAY,
  INT184_ARRAY,
  INT192_ARRAY,
  INT200_ARRAY,
  INT208_ARRAY,
  INT216_ARRAY,
  INT224_ARRAY,
  INT232_ARRAY,
  INT240_ARRAY,
  INT248_ARRAY,
  INT256_ARRAY,
  BYTES1_ARRAY,
  BYTES2_ARRAY,
  BYTES3_ARRAY,
  BYTES4_ARRAY,
  BYTES5_ARRAY,
  BYTES6_ARRAY,
  BYTES7_ARRAY,
  BYTES8_ARRAY,
  BYTES9_ARRAY,
  BYTES10_ARRAY,
  BYTES11_ARRAY,
  BYTES12_ARRAY,
  BYTES13_ARRAY,
  BYTES14_ARRAY,
  BYTES15_ARRAY,
  BYTES16_ARRAY,
  BYTES17_ARRAY,
  BYTES18_ARRAY,
  BYTES19_ARRAY,
  BYTES20_ARRAY,
  BYTES21_ARRAY,
  BYTES22_ARRAY,
  BYTES23_ARRAY,
  BYTES24_ARRAY,
  BYTES25_ARRAY,
  BYTES26_ARRAY,
  BYTES27_ARRAY,
  BYTES28_ARRAY,
  BYTES29_ARRAY,
  BYTES30_ARRAY,
  BYTES31_ARRAY,
  BYTES32_ARRAY,
  BOOL_ARRAY,
  ADDRESS_ARRAY,
  BYTES,
  STRING
}

/**
 * Get the length of the data for the given schema type
 * (Because Solidity doesn't support constant arrays, we need to use a function)
 */
function getStaticByteLength(SchemaType schemaType) pure returns (uint256) {
  uint256 index = uint8(schemaType);

  if (index < 97) {
    // SchemaType enum elements are cyclically ordered for optimal static length lookup
    // indexes: 00-31, 32-63, 64-95, 96, 97, ...
    // lengths: 01-32, 01-32, 01-32, 01, 20, (the rest are 0s)
    unchecked {
      return (index & 31) + 1;
    }
  } else if (schemaType == SchemaType.ADDRESS) {
    return 20;
  } else {
    // Return 0 for all dynamic types
    return 0;
  }
}

// node_modules/@latticexyz/store/src/Bytes.sol

/**
 * @title Bytes
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Utility functions for bytes.
 */
library Bytes {
  /************************************************************************
   *
   *    UTILS
   *
   ************************************************************************/

  /**
   * @dev Sets the length of a bytes blob in memory.
   * This function does not resize the memory allocation; it only changes the length
   * field, which affects operations that access the length property.
   * @param input The bytes blob to modify.
   * @param length The new length to set.
   * @return Reference to the input bytes blob with modified length.
   */
  function setLength(bytes memory input, uint256 length) internal pure returns (bytes memory) {
    assembly {
      mstore(input, length)
    }
    return input;
  }

  /************************************************************************
   *
   *    SET
   *
   ************************************************************************/

  /**
   * @dev Sets a specific 4-byte sequence in a bytes blob at a given index.
   * @param input The bytes blob in which a specific 4-byte sequence is to be altered.
   * @param index The position within the bytes blob to start altering the 4-byte sequence. Index starts from the left.
   * @param overwrite The new 4-byte value to be set at the specified index.
   * @return The modified bytes blob with the new 4-byte value at the specified index.
   */
  function setBytes4(bytes memory input, uint256 index, bytes4 overwrite) internal pure returns (bytes memory) {
    bytes4 mask = 0xffffffff;
    assembly {
      let value := mload(add(add(input, 0x20), index)) // load 32 bytes from input starting at offset
      value := and(value, not(mask)) // zero out the first 4 bytes
      value := or(value, overwrite) // set the bytes at the offset
      mstore(add(add(input, 0x20), index), value) // store the new value
    }
    return input;
  }

  /************************************************************************
   *
   *    GET
   *
   *    Used by codegen libraries
   *
   ************************************************************************/

  /**
   * @dev Extracts a single byte from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a byte is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes1 value from the specified position in the bytes blob.
   */
  function getBytes1(bytes memory data, uint256 start) internal pure returns (bytes1 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a single byte from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a byte is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes1 value from the specified position in the bytes32 value.
   */
  function getBytes1(bytes32 data, uint256 start) internal pure returns (bytes1 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 2-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 2-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes2 value from the specified position in the bytes blob.
   */
  function getBytes2(bytes memory data, uint256 start) internal pure returns (bytes2 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 2-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 2-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes2 value from the specified position in the bytes32 value.
   */
  function getBytes2(bytes32 data, uint256 start) internal pure returns (bytes2 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 3-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 3-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes3 value from the specified position in the bytes blob.
   */
  function getBytes3(bytes memory data, uint256 start) internal pure returns (bytes3 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 3-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 3-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes3 value from the specified position in the bytes32 value.
   */
  function getBytes3(bytes32 data, uint256 start) internal pure returns (bytes3 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 4-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 4-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes4 value from the specified position in the bytes blob.
   */
  function getBytes4(bytes memory data, uint256 start) internal pure returns (bytes4 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 4-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 4-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes4 value from the specified position in the bytes32 value.
   */
  function getBytes4(bytes32 data, uint256 start) internal pure returns (bytes4 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 5-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 5-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes5 value from the specified position in the bytes blob.
   */
  function getBytes5(bytes memory data, uint256 start) internal pure returns (bytes5 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 5-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 5-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes5 value from the specified position in the bytes32 value.
   */
  function getBytes5(bytes32 data, uint256 start) internal pure returns (bytes5 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 6-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 6-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes6 value from the specified position in the bytes blob.
   */
  function getBytes6(bytes memory data, uint256 start) internal pure returns (bytes6 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 6-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 6-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes6 value from the specified position in the bytes32 value.
   */
  function getBytes6(bytes32 data, uint256 start) internal pure returns (bytes6 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 7-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 7-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes7 value from the specified position in the bytes blob.
   */
  function getBytes7(bytes memory data, uint256 start) internal pure returns (bytes7 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 7-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 7-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes7 value from the specified position in the bytes32 value.
   */
  function getBytes7(bytes32 data, uint256 start) internal pure returns (bytes7 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 8-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 8-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes8 value from the specified position in the bytes blob.
   */
  function getBytes8(bytes memory data, uint256 start) internal pure returns (bytes8 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 8-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 8-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes8 value from the specified position in the bytes32 value.
   */
  function getBytes8(bytes32 data, uint256 start) internal pure returns (bytes8 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 9-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 9-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes9 value from the specified position in the bytes blob.
   */
  function getBytes9(bytes memory data, uint256 start) internal pure returns (bytes9 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 9-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 9-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes9 value from the specified position in the bytes32 value.
   */
  function getBytes9(bytes32 data, uint256 start) internal pure returns (bytes9 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 10-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 10-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes10 value from the specified position in the bytes blob.
   */
  function getBytes10(bytes memory data, uint256 start) internal pure returns (bytes10 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 10-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 10-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes10 value from the specified position in the bytes32 value.
   */
  function getBytes10(bytes32 data, uint256 start) internal pure returns (bytes10 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 11-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 11-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes11 value from the specified position in the bytes blob.
   */
  function getBytes11(bytes memory data, uint256 start) internal pure returns (bytes11 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 11-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 11-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes11 value from the specified position in the bytes32 value.
   */
  function getBytes11(bytes32 data, uint256 start) internal pure returns (bytes11 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 12-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 12-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes12 value from the specified position in the bytes blob.
   */
  function getBytes12(bytes memory data, uint256 start) internal pure returns (bytes12 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 12-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 12-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes12 value from the specified position in the bytes32 value.
   */
  function getBytes12(bytes32 data, uint256 start) internal pure returns (bytes12 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 13-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 13-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes13 value from the specified position in the bytes blob.
   */
  function getBytes13(bytes memory data, uint256 start) internal pure returns (bytes13 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 13-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 13-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes13 value from the specified position in the bytes32 value.
   */
  function getBytes13(bytes32 data, uint256 start) internal pure returns (bytes13 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 14-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 14-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes14 value from the specified position in the bytes blob.
   */
  function getBytes14(bytes memory data, uint256 start) internal pure returns (bytes14 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 14-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 14-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes14 value from the specified position in the bytes32 value.
   */
  function getBytes14(bytes32 data, uint256 start) internal pure returns (bytes14 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 15-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 15-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes15 value from the specified position in the bytes blob.
   */
  function getBytes15(bytes memory data, uint256 start) internal pure returns (bytes15 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 15-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 15-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes15 value from the specified position in the bytes32 value.
   */
  function getBytes15(bytes32 data, uint256 start) internal pure returns (bytes15 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 16-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 16-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes16 value from the specified position in the bytes blob.
   */
  function getBytes16(bytes memory data, uint256 start) internal pure returns (bytes16 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 16-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 16-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes16 value from the specified position in the bytes32 value.
   */
  function getBytes16(bytes32 data, uint256 start) internal pure returns (bytes16 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 17-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 17-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes17 value from the specified position in the bytes blob.
   */
  function getBytes17(bytes memory data, uint256 start) internal pure returns (bytes17 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 17-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 17-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes17 value from the specified position in the bytes32 value.
   */
  function getBytes17(bytes32 data, uint256 start) internal pure returns (bytes17 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 18-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 18-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes18 value from the specified position in the bytes blob.
   */
  function getBytes18(bytes memory data, uint256 start) internal pure returns (bytes18 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 18-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 18-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes18 value from the specified position in the bytes32 value.
   */
  function getBytes18(bytes32 data, uint256 start) internal pure returns (bytes18 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 19-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 19-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes19 value from the specified position in the bytes blob.
   */
  function getBytes19(bytes memory data, uint256 start) internal pure returns (bytes19 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 19-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 19-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes19 value from the specified position in the bytes32 value.
   */
  function getBytes19(bytes32 data, uint256 start) internal pure returns (bytes19 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 20-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 20-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes20 value from the specified position in the bytes blob.
   */
  function getBytes20(bytes memory data, uint256 start) internal pure returns (bytes20 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 20-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 20-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes20 value from the specified position in the bytes32 value.
   */
  function getBytes20(bytes32 data, uint256 start) internal pure returns (bytes20 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 21-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 21-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes21 value from the specified position in the bytes blob.
   */
  function getBytes21(bytes memory data, uint256 start) internal pure returns (bytes21 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 21-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 21-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes21 value from the specified position in the bytes32 value.
   */
  function getBytes21(bytes32 data, uint256 start) internal pure returns (bytes21 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 22-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 22-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes22 value from the specified position in the bytes blob.
   */
  function getBytes22(bytes memory data, uint256 start) internal pure returns (bytes22 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 22-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 22-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes22 value from the specified position in the bytes32 value.
   */
  function getBytes22(bytes32 data, uint256 start) internal pure returns (bytes22 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 23-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 23-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes23 value from the specified position in the bytes blob.
   */
  function getBytes23(bytes memory data, uint256 start) internal pure returns (bytes23 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 23-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 23-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes23 value from the specified position in the bytes32 value.
   */
  function getBytes23(bytes32 data, uint256 start) internal pure returns (bytes23 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 24-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 24-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes24 value from the specified position in the bytes blob.
   */
  function getBytes24(bytes memory data, uint256 start) internal pure returns (bytes24 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 24-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 24-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes24 value from the specified position in the bytes32 value.
   */
  function getBytes24(bytes32 data, uint256 start) internal pure returns (bytes24 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 25-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 25-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes25 value from the specified position in the bytes blob.
   */
  function getBytes25(bytes memory data, uint256 start) internal pure returns (bytes25 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 25-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 25-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes25 value from the specified position in the bytes32 value.
   */
  function getBytes25(bytes32 data, uint256 start) internal pure returns (bytes25 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 26-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 26-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes26 value from the specified position in the bytes blob.
   */
  function getBytes26(bytes memory data, uint256 start) internal pure returns (bytes26 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 26-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 26-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes26 value from the specified position in the bytes32 value.
   */
  function getBytes26(bytes32 data, uint256 start) internal pure returns (bytes26 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 27-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 27-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes27 value from the specified position in the bytes blob.
   */
  function getBytes27(bytes memory data, uint256 start) internal pure returns (bytes27 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 27-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 27-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes27 value from the specified position in the bytes32 value.
   */
  function getBytes27(bytes32 data, uint256 start) internal pure returns (bytes27 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 28-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 28-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes28 value from the specified position in the bytes blob.
   */
  function getBytes28(bytes memory data, uint256 start) internal pure returns (bytes28 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 28-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 28-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes28 value from the specified position in the bytes32 value.
   */
  function getBytes28(bytes32 data, uint256 start) internal pure returns (bytes28 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 29-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 29-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes29 value from the specified position in the bytes blob.
   */
  function getBytes29(bytes memory data, uint256 start) internal pure returns (bytes29 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 29-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 29-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes29 value from the specified position in the bytes32 value.
   */
  function getBytes29(bytes32 data, uint256 start) internal pure returns (bytes29 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 30-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 30-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes30 value from the specified position in the bytes blob.
   */
  function getBytes30(bytes memory data, uint256 start) internal pure returns (bytes30 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 30-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 30-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes30 value from the specified position in the bytes32 value.
   */
  function getBytes30(bytes32 data, uint256 start) internal pure returns (bytes30 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 31-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 31-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes31 value from the specified position in the bytes blob.
   */
  function getBytes31(bytes memory data, uint256 start) internal pure returns (bytes31 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 31-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 31-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes31 value from the specified position in the bytes32 value.
   */
  function getBytes31(bytes32 data, uint256 start) internal pure returns (bytes31 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }

  /**
   * @dev Extracts a 32-byte sequence from a bytes blob starting at a specific position.
   * @param data The bytes blob from which a 32-byte sequence is to be extracted.
   * @param start The starting position within the bytes blob for extraction.
   * @return output The extracted bytes32 value from the specified position in the bytes blob.
   */
  function getBytes32(bytes memory data, uint256 start) internal pure returns (bytes32 output) {
    assembly {
      output := mload(add(add(data, 0x20), start))
    }
  }

  /**
   * @dev Extracts a 32-byte sequence from a bytes32 value starting at a specific position.
   * @param data The bytes32 value from which a 32-byte sequence is to be extracted.
   * @param start The starting position within the bytes32 value for extraction.
   * @return output The extracted bytes32 value from the specified position in the bytes32 value.
   */
  function getBytes32(bytes32 data, uint256 start) internal pure returns (bytes32 output) {
    assembly {
      output := shl(mul(8, start), data)
    }
  }
}

// node_modules/@latticexyz/store/src/IERC165.sol

// See https://eips.ethereum.org/EIPS/eip-165
interface IERC165_0 {
  /**
   * @notice Query if a contract implements an interface
   * @param interfaceID The interface identifier, as specified in ERC-165
   * @dev Interface identification is specified in ERC-165. This function
   * uses less than 30,000 gas.
   * @return `true` if the contract implements `interfaceID` and
   * `interfaceID` is not 0xffffffff, `false` otherwise
   */
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

// node_modules/@latticexyz/store/src/IEncodedLengthsErrors.sol

/**
 * @title IEncodedLengthsErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for the EncodedLengths library.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding libraries) so they can be inherited by IStore.
 * This ensures that all possible errors are included in the IStore ABI for proper decoding in the frontend.
 */
interface IEncodedLengthsErrors {
  /**
   * @notice Error raised when the provided encoded lengths has an invalid length.
   * @param length The length of the encoded lengths.
   */
  error EncodedLengths_InvalidLength(uint256 length);
}

// node_modules/@latticexyz/store/src/IFieldLayoutErrors.sol

/**
 * @title IFieldLayoutErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for the FieldLayout library.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding libraries) so they can be inherited by IStore.
 * This ensures that all possible errors are included in the IStore ABI for proper decoding in the frontend.
 */
interface IFieldLayoutErrors {
  /**
   * @notice Error raised when the provided field layout has too many fields.
   * @param numFields The total number of fields in the field layout.
   * @param maxFields The maximum number of fields a Schema can handle.
   */
  error FieldLayout_TooManyFields(uint256 numFields, uint256 maxFields);
  /**
   * @notice Error raised when the provided field layout has too many dynamic fields.
   * @param numFields The total number of fields in the field layout.
   * @param maxFields The maximum number of fields a Schema can handle.
   */
  error FieldLayout_TooManyDynamicFields(uint256 numFields, uint256 maxFields);
  /**
   * @notice Error raised when the provided field layout is empty.
   */
  error FieldLayout_Empty();
  /**
   * @notice Error raised when the provided field layout has an invalid static data length.
   * @param staticDataLength The static data length of the field layout.
   * @param computedStaticDataLength The computed static data length.
   */
  error FieldLayout_InvalidStaticDataLength(uint256 staticDataLength, uint256 computedStaticDataLength);
  /**
   * @notice Error raised when the provided field layout has a static data length of zero.
   * @param index The index of the field.
   */
  error FieldLayout_StaticLengthIsZero(uint256 index);
  /**
   * @notice Error raised when the provided field layout has a nonzero static data length.
   * @param index The index of the field.
   */
  error FieldLayout_StaticLengthIsNotZero(uint256 index);
  /**
   * @notice Error raised when the provided field layout has a static data length that does not fit in a word (32 bytes).
   * @param index The index of the field.
   */
  error FieldLayout_StaticLengthDoesNotFitInAWord(uint256 index);
}

// node_modules/@latticexyz/store/src/ISchemaErrors.sol

/**
 * @title ISchemaErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for the Schema library.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding libraries) so they can be inherited by IStore.
 * This ensures that all possible errors are included in the IStore ABI for proper decoding in the frontend.
 */
interface ISchemaErrors {
  /**
   * @notice Error raised when the provided schema has an invalid length.
   * @param length The length of the schema.
   */
  error Schema_InvalidLength(uint256 length);

  /**
   * @notice Error raised when a static type is placed after a dynamic type in a schema.
   */
  error Schema_StaticTypeAfterDynamicType();
}

// node_modules/@latticexyz/store/src/ISliceErrors.sol

/**
 * @title ISliceErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for the Slice library.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding libraries) so they can be inherited by IStore.
 * This ensures that all possible errors are included in the IStore ABI for proper decoding in the frontend.
 */
interface ISliceErrors {
  /**
   * @notice Error raised when the provided slice is out of bounds.
   * @dev Raised if `start` is greater than `end` or `end` greater than the length of `data`.
   * @param data The bytes array to subslice.
   * @param start The start index for the subslice.
   * @param end The end index for the subslice.
   */
  error Slice_OutOfBounds(bytes data, uint256 start, uint256 end);
}

// node_modules/@latticexyz/store/src/ResourceId.sol

/**
 * @title ResourceId type definition and related utilities
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev A ResourceId is a bytes32 data structure that consists of a
 * type and a name
 */
type ResourceId is bytes32;

using ResourceIdInstance for ResourceId global;

/// @dev Number of bits reserved for the type in the ResourceId.
uint256 constant TYPE_BITS = 2 * 8; // 2 bytes * 8 bits per byte

/**
 * @title ResourceIdLib Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Provides functions to encode data into the ResourceId
 */
library ResourceIdLib {
  /**
   * @notice Encodes given typeId and name into a ResourceId.
   * @param typeId The type identifier to be encoded. Must be 2 bytes.
   * @param name The name to be encoded. Must be 30 bytes.
   * @return A ResourceId containing the encoded typeId and name.
   */
  function encode(bytes2 typeId, bytes30 name) internal pure returns (ResourceId) {
    return ResourceId.wrap(bytes32(typeId) | (bytes32(name) >> TYPE_BITS));
  }
}

/**
 * @title ResourceIdInstance Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Provides functions to extract data from a ResourceId.
 */
library ResourceIdInstance {
  /**
   * @notice Extracts the type identifier from a given ResourceId.
   * @param resourceId The ResourceId from which the type identifier should be extracted.
   * @return The extracted 2-byte type identifier.
   */
  function getType(ResourceId resourceId) internal pure returns (bytes2) {
    return bytes2(ResourceId.unwrap(resourceId));
  }

  /**
   * @notice Get the name from a resource ID.
   * @param resourceId The resource ID.
   * @return A 30-byte name.
   */
  function getResourceName(ResourceId resourceId) internal pure returns (bytes30) {
    return bytes30(ResourceId.unwrap(resourceId) << (TYPE_BITS));
  }

  /**
   * @notice Unwrap a resource ID into a bytes32.
   * @param resourceId The resource ID.
   * @return The underlying bytes32.
   */
  function unwrap(ResourceId resourceId) internal pure returns (bytes32) {
    return ResourceId.unwrap(resourceId);
  }
}

// node_modules/@latticexyz/store/src/constants.sol

/**
 * @title Shared constants for EVM and schema handling
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This file provides constants for better handling of EVM and Schema related functionalities.
 */

/// @dev Represents the total byte length of an EVM word.
uint256 constant WORD_SIZE = 32;

/// @dev Represents the index of the last byte in an EVM word.
uint256 constant WORD_LAST_INDEX = 31;

/// @dev Represents the conversion constant from byte to bits.
uint256 constant BYTE_TO_BITS = 8;

/// @dev Represents the maximum number of fields a Schema can handle.
uint256 constant MAX_TOTAL_FIELDS = 28;

/// @dev Represents the maximum number of static fields in a FieldLayout.
uint256 constant MAX_STATIC_FIELDS = 28;

/// @dev Represents the maximum number of dynamic fields that can be packed in EncodedLengths.
uint256 constant MAX_DYNAMIC_FIELDS = 5;

/**
 * @title LayoutOffsets Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This library provides constant offsets for FieldLayout and Schema metadata.
 * @dev FieldLayout and Schema utilize the same offset values for metadata.
 */
library LayoutOffsets {
  /// @notice Represents the total length offset within the EVM word.
  uint256 internal constant TOTAL_LENGTH = (WORD_SIZE - 2) * BYTE_TO_BITS;

  /// @notice Represents the number of static fields offset within the EVM word.
  uint256 internal constant NUM_STATIC_FIELDS = (WORD_SIZE - 2 - 1) * BYTE_TO_BITS;

  /// @notice Represents the number of dynamic fields offset within the EVM word.
  uint256 internal constant NUM_DYNAMIC_FIELDS = (WORD_SIZE - 2 - 1 - 1) * BYTE_TO_BITS;
}

// node_modules/@latticexyz/store/src/storeHookTypes.sol

/**
 * @title Store Hook Flags
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Constants for enabling store hooks.
 * @dev These bitmaps can be used to enable selected store hooks. They can be combined with a bitwise OR (`|`).
 */

/// @dev Flag to enable the `onBeforeSetRecord` hook.
uint8 constant BEFORE_SET_RECORD = 1 << 0;

/// @dev Flag to enable the `afterSetRecord` hook.
uint8 constant AFTER_SET_RECORD = 1 << 1;

/// @dev Flag to enable the `beforeSpliceStaticData` hook.
uint8 constant BEFORE_SPLICE_STATIC_DATA = 1 << 2;

/// @dev Flag to enable the `afterSpliceStaticData` hook.
uint8 constant AFTER_SPLICE_STATIC_DATA = 1 << 3;

/// @dev Flag to enable the `beforeSpliceDynamicData` hook.
uint8 constant BEFORE_SPLICE_DYNAMIC_DATA = 1 << 4;

/// @dev Flag to enable the `afterSpliceDynamicData` hook.
uint8 constant AFTER_SPLICE_DYNAMIC_DATA = 1 << 5;

/// @dev Flag to enable the `beforeDeleteRecord` hook.
uint8 constant BEFORE_DELETE_RECORD = 1 << 6;

/// @dev Flag to enable the `afterDeleteRecord` hook.
uint8 constant AFTER_DELETE_RECORD = 1 << 7;

/// @dev Bitmap to enable all hooks.
uint8 constant ALL = BEFORE_SET_RECORD |
  AFTER_SET_RECORD |
  BEFORE_SPLICE_STATIC_DATA |
  AFTER_SPLICE_STATIC_DATA |
  BEFORE_SPLICE_DYNAMIC_DATA |
  AFTER_SPLICE_DYNAMIC_DATA |
  BEFORE_DELETE_RECORD |
  AFTER_DELETE_RECORD;

/// @dev Bitmap to enable all "before" hooks.
uint8 constant BEFORE_ALL = BEFORE_SET_RECORD |
  BEFORE_SPLICE_STATIC_DATA |
  BEFORE_SPLICE_DYNAMIC_DATA |
  BEFORE_DELETE_RECORD;

/// @dev Bitmap to enable all "after" hooks.
uint8 constant AFTER_ALL = AFTER_SET_RECORD |
  AFTER_SPLICE_STATIC_DATA |
  AFTER_SPLICE_DYNAMIC_DATA |
  AFTER_DELETE_RECORD;

// node_modules/@latticexyz/store/src/storeResourceTypes.sol

/**
 * @title Resource Identifiers
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Constants representing unique identifiers for different resource types.
 * @dev These identifiers can be used to distinguish between various resource types.
 */

/// @dev Identifier for a resource table.
bytes2 constant RESOURCE_TABLE = "tb";

/// @dev Identifier for an offchain resource table.
bytes2 constant RESOURCE_OFFCHAIN_TABLE = "ot";

// node_modules/@latticexyz/store/src/version.sol

/**
 * @title Store protocol version
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Contains a constant representing the version of the Store protocol.
 */

/// @dev Identifier for the current Store protocol version.
bytes32 constant STORE_VERSION = "2.0.2";

// node_modules/@latticexyz/world/src/IERC165.sol

/**
 * @title IERC165
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Interface for the ERC-165 standard as described in the EIP-165.
 * Allows for contracts to be checked for their support of an interface.
 * See: https://eips.ethereum.org/EIPS/eip-165
 */
interface IERC165_1 {
  /**
   * @notice Query if a contract implements an interface.
   * @dev Interface identification is specified in ERC-165.
   * This function uses less than 30,000 gas.
   * @param interfaceID The interface identifier, as specified in ERC-165.
   * @return True if the contract implements `interfaceID` and
   * `interfaceID` is not 0xffffffff, false otherwise.
   */
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

// node_modules/@latticexyz/world/src/IModuleErrors.sol

/**
 * @title IModuleErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for the Module library.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding library) so they can be inherited by IWorldKernel.
 * This ensures that all errors are included in the IWorldKernel ABI for proper decoding in the frontend.
 */
interface IModuleErrors {
  /**
   * @notice Error raised if installing in root is not supported.
   */
  error Module_RootInstallNotSupported();
  /**
   * @notice Error raised if installing in non-root is not supported.
   */
  error Module_NonRootInstallNotSupported();
  /**
   * @notice Error raised if the provided module is already installed.
   */
  error Module_AlreadyInstalled();
  /**
   * @notice Error raised if the provided module is missing a dependency.
   * @param dependency The address of the dependency.
   */
  error Module_MissingDependency(address dependency);
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IRegistrationSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IRegistrationSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IRegistrationSystem {}

// node_modules/@latticexyz/world/src/revertWithBytes.sol

/**
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */

/**
 * @notice Reverts the transaction using the provided raw bytes as the revert reason.
 * @dev Uses assembly to perform the revert operation with the raw bytes.
 * @param reason The raw bytes revert reason.
 */
function revertWithBytes(bytes memory reason) pure {
  assembly {
    // reason+32 is a pointer to the error message, mload(reason) is the length of the error message
    revert(add(reason, 0x20), mload(reason))
  }
}

// node_modules/forge-std/src/console.sol

library console {
    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

    function _sendLogPayload(bytes memory payload) private view {
        uint256 payloadLength = payload.length;
        address consoleAddress = CONSOLE_ADDRESS;
        /// @solidity memory-safe-assembly
        assembly {
            let payloadStart := add(payload, 32)
            let r := staticcall(gas(), consoleAddress, payloadStart, payloadLength, 0, 0)
        }
    }

    function log() internal view {
        _sendLogPayload(abi.encodeWithSignature("log()"));
    }

    function logInt(int p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(int)", p0));
    }

    function logUint(uint p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
    }

    function logString(string memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
    }

    function logBool(bool p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
    }

    function logAddress(address p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
    }

    function logBytes(bytes memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes)", p0));
    }

    function logBytes1(bytes1 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes1)", p0));
    }

    function logBytes2(bytes2 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes2)", p0));
    }

    function logBytes3(bytes3 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes3)", p0));
    }

    function logBytes4(bytes4 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes4)", p0));
    }

    function logBytes5(bytes5 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes5)", p0));
    }

    function logBytes6(bytes6 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes6)", p0));
    }

    function logBytes7(bytes7 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes7)", p0));
    }

    function logBytes8(bytes8 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes8)", p0));
    }

    function logBytes9(bytes9 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes9)", p0));
    }

    function logBytes10(bytes10 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes10)", p0));
    }

    function logBytes11(bytes11 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes11)", p0));
    }

    function logBytes12(bytes12 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes12)", p0));
    }

    function logBytes13(bytes13 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes13)", p0));
    }

    function logBytes14(bytes14 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes14)", p0));
    }

    function logBytes15(bytes15 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes15)", p0));
    }

    function logBytes16(bytes16 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes16)", p0));
    }

    function logBytes17(bytes17 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes17)", p0));
    }

    function logBytes18(bytes18 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes18)", p0));
    }

    function logBytes19(bytes19 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes19)", p0));
    }

    function logBytes20(bytes20 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes20)", p0));
    }

    function logBytes21(bytes21 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes21)", p0));
    }

    function logBytes22(bytes22 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes22)", p0));
    }

    function logBytes23(bytes23 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes23)", p0));
    }

    function logBytes24(bytes24 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes24)", p0));
    }

    function logBytes25(bytes25 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes25)", p0));
    }

    function logBytes26(bytes26 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes26)", p0));
    }

    function logBytes27(bytes27 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes27)", p0));
    }

    function logBytes28(bytes28 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes28)", p0));
    }

    function logBytes29(bytes29 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes29)", p0));
    }

    function logBytes30(bytes30 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes30)", p0));
    }

    function logBytes31(bytes31 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes31)", p0));
    }

    function logBytes32(bytes32 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
    }

    function log(uint p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
    }

    function log(string memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
    }

    function log(bool p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
    }

    function log(address p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
    }

    function log(uint p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint)", p0, p1));
    }

    function log(uint p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string)", p0, p1));
    }

    function log(uint p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool)", p0, p1));
    }

    function log(uint p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address)", p0, p1));
    }

    function log(string memory p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint)", p0, p1));
    }

    function log(string memory p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string)", p0, p1));
    }

    function log(string memory p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
    }

    function log(string memory p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
    }

    function log(bool p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint)", p0, p1));
    }

    function log(bool p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string)", p0, p1));
    }

    function log(bool p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool)", p0, p1));
    }

    function log(bool p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address)", p0, p1));
    }

    function log(address p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint)", p0, p1));
    }

    function log(address p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string)", p0, p1));
    }

    function log(address p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool)", p0, p1));
    }

    function log(address p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address)", p0, p1));
    }

    function log(uint p0, uint p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint)", p0, p1, p2));
    }

    function log(uint p0, uint p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string)", p0, p1, p2));
    }

    function log(uint p0, uint p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool)", p0, p1, p2));
    }

    function log(uint p0, uint p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address)", p0, p1, p2));
    }

    function log(uint p0, string memory p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint)", p0, p1, p2));
    }

    function log(uint p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,string)", p0, p1, p2));
    }

    function log(uint p0, string memory p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool)", p0, p1, p2));
    }

    function log(uint p0, string memory p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,address)", p0, p1, p2));
    }

    function log(uint p0, bool p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint)", p0, p1, p2));
    }

    function log(uint p0, bool p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string)", p0, p1, p2));
    }

    function log(uint p0, bool p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool)", p0, p1, p2));
    }

    function log(uint p0, bool p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address)", p0, p1, p2));
    }

    function log(uint p0, address p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint)", p0, p1, p2));
    }

    function log(uint p0, address p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,string)", p0, p1, p2));
    }

    function log(uint p0, address p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool)", p0, p1, p2));
    }

    function log(uint p0, address p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,address)", p0, p1, p2));
    }

    function log(string memory p0, uint p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint)", p0, p1, p2));
    }

    function log(string memory p0, uint p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,string)", p0, p1, p2));
    }

    function log(string memory p0, uint p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool)", p0, p1, p2));
    }

    function log(string memory p0, uint p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,address)", p0, p1, p2));
    }

    function log(string memory p0, string memory p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,uint)", p0, p1, p2));
    }

    function log(string memory p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string)", p0, p1, p2));
    }

    function log(string memory p0, string memory p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,bool)", p0, p1, p2));
    }

    function log(string memory p0, string memory p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,address)", p0, p1, p2));
    }

    function log(string memory p0, bool p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint)", p0, p1, p2));
    }

    function log(string memory p0, bool p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,string)", p0, p1, p2));
    }

    function log(string memory p0, bool p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool)", p0, p1, p2));
    }

    function log(string memory p0, bool p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,address)", p0, p1, p2));
    }

    function log(string memory p0, address p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,uint)", p0, p1, p2));
    }

    function log(string memory p0, address p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,string)", p0, p1, p2));
    }

    function log(string memory p0, address p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,bool)", p0, p1, p2));
    }

    function log(string memory p0, address p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,address)", p0, p1, p2));
    }

    function log(bool p0, uint p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint)", p0, p1, p2));
    }

    function log(bool p0, uint p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string)", p0, p1, p2));
    }

    function log(bool p0, uint p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool)", p0, p1, p2));
    }

    function log(bool p0, uint p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address)", p0, p1, p2));
    }

    function log(bool p0, string memory p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint)", p0, p1, p2));
    }

    function log(bool p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,string)", p0, p1, p2));
    }

    function log(bool p0, string memory p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool)", p0, p1, p2));
    }

    function log(bool p0, string memory p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,address)", p0, p1, p2));
    }

    function log(bool p0, bool p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint)", p0, p1, p2));
    }

    function log(bool p0, bool p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string)", p0, p1, p2));
    }

    function log(bool p0, bool p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool)", p0, p1, p2));
    }

    function log(bool p0, bool p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address)", p0, p1, p2));
    }

    function log(bool p0, address p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint)", p0, p1, p2));
    }

    function log(bool p0, address p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,string)", p0, p1, p2));
    }

    function log(bool p0, address p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool)", p0, p1, p2));
    }

    function log(bool p0, address p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,address)", p0, p1, p2));
    }

    function log(address p0, uint p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint)", p0, p1, p2));
    }

    function log(address p0, uint p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,string)", p0, p1, p2));
    }

    function log(address p0, uint p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool)", p0, p1, p2));
    }

    function log(address p0, uint p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,address)", p0, p1, p2));
    }

    function log(address p0, string memory p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,uint)", p0, p1, p2));
    }

    function log(address p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,string)", p0, p1, p2));
    }

    function log(address p0, string memory p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,bool)", p0, p1, p2));
    }

    function log(address p0, string memory p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,address)", p0, p1, p2));
    }

    function log(address p0, bool p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint)", p0, p1, p2));
    }

    function log(address p0, bool p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,string)", p0, p1, p2));
    }

    function log(address p0, bool p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool)", p0, p1, p2));
    }

    function log(address p0, bool p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,address)", p0, p1, p2));
    }

    function log(address p0, address p1, uint p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,uint)", p0, p1, p2));
    }

    function log(address p0, address p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,string)", p0, p1, p2));
    }

    function log(address p0, address p1, bool p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,bool)", p0, p1, p2));
    }

    function log(address p0, address p1, address p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,address)", p0, p1, p2));
    }

    function log(uint p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,string)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,uint,address)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,string)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,string,address)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,string)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,bool,address)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,string)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint,address,address)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,string)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,uint,address)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,string)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,string,address)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,string)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,bool,address)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,string)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, string memory p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string,address,address)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,string)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,uint,address)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,string)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,string,address)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,string)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,bool,address)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,string)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool,address,address)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,string)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,uint,address)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,string)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,string,address)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,string)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,bool,address)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,uint)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,string)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,bool)", p0, p1, p2, p3));
    }

    function log(uint p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address,address,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,uint,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,string,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,bool,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint,address,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,uint,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,bool,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,address,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,address,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,address,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, string memory p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,address,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,uint,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,string,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,bool,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool,address,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,uint,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,string,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,string,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,string,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,string,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,bool,address)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,address,uint)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,address,string)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,address,bool)", p0, p1, p2, p3));
    }

    function log(string memory p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address,address,address)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,string)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,uint,address)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,string)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,string,address)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,string)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,bool,address)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,string)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint,address,address)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,string)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,uint,address)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,string)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,string,address)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,string)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,bool,address)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,string)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, string memory p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string,address,address)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,string)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,uint,address)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,string)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,string,address)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,string)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,bool,address)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,string)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool,address,address)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,string)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,uint,address)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,string)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,string,address)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,string)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,bool,address)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,uint)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,string)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,bool)", p0, p1, p2, p3));
    }

    function log(bool p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address,address,address)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,uint)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,string)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,bool)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,uint,address)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,uint)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,string)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,bool)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,string,address)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,uint)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,string)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,bool)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,bool,address)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,uint)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,string)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,bool)", p0, p1, p2, p3));
    }

    function log(address p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint,address,address)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,uint)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,string)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,bool)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,uint,address)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,string,uint)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,string,string)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,string,bool)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,string,address)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,uint)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,string)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,bool)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,bool,address)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,address,uint)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,address,string)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,address,bool)", p0, p1, p2, p3));
    }

    function log(address p0, string memory p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string,address,address)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,uint)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,string)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,bool)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,uint,address)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,uint)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,string)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,bool)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,string,address)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,uint)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,string)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,bool)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,bool,address)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,uint)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,string)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,bool)", p0, p1, p2, p3));
    }

    function log(address p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool,address,address)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,uint)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,string)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,bool)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,uint,address)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,string,uint)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, string memory p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,string,string)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,string,bool)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, string memory p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,string,address)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,uint)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,string)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,bool)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,bool,address)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,address,uint)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, address p2, string memory p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,address,string)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,address,bool)", p0, p1, p2, p3));
    }

    function log(address p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,address,address,address)", p0, p1, p2, p3));
    }

}

// node_modules/@latticexyz/store/src/IStoreErrors.sol

/**
 * @title IStoreErrors
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface includes errors for Store.
 * @dev We bundle these errors in an interface (instead of at the file-level or in their corresponding library) so they can be inherited by IStore.
 * This ensures that all possible errors are included in the IStore ABI for proper decoding in the frontend.
 */
interface IStoreErrors {
  /**
   * @notice Error raised if the provided table already exists.
   * @param tableId The ID of the table.
   * @param tableIdString The stringified ID of the table (for easier debugging if cleartext tableIds are used).
   */
  error Store_TableAlreadyExists(ResourceId tableId, string tableIdString);
  /**
   * @notice Error raised if the provided table cannot be found.
   * @param tableId The ID of the table.
   * @param tableIdString The stringified ID of the table (for easier debugging if cleartext tableIds are used).
   */
  error Store_TableNotFound(ResourceId tableId, string tableIdString);
  /**
   * @notice Error raised if the provided resource ID cannot be found.
   * @param expected The expected resource type.
   * @param resourceId The resource ID.
   * @param resourceIdString The stringified resource ID (for easier debugging).
   */
  error Store_InvalidResourceType(bytes2 expected, ResourceId resourceId, string resourceIdString);

  /**
   * @notice Error raised if the provided slice bounds are invalid.
   * @param start The start index within the dynamic field for the slice operation (inclusive).
   * @param end The end index within the dynamic field for the slice operation (exclusive).
   */
  error Store_InvalidBounds(uint256 start, uint256 end);
  /**
   * @notice Error raised if the provided index is out of bounds.
   * @dev Raised if the start index is larger than the previous length of the field.
   * @param length FIXME
   * @param accessedIndex FIXME
   */
  error Store_IndexOutOfBounds(uint256 length, uint256 accessedIndex);
  /**
   * @notice Error raised if the provided static data length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidStaticDataLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided key names length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidKeyNamesLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided field names length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidFieldNamesLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided value schema length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidValueSchemaLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided schema static length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidValueSchemaStaticLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided schema dynamic length is invalid.
   * @param expected The expected length.
   * @param received The provided length.
   */
  error Store_InvalidValueSchemaDynamicLength(uint256 expected, uint256 received);
  /**
   * @notice Error raised if the provided splice is invalid.
   * @dev Raised if the splice total length of the field is changed but the splice is not at the end of the field.
   * @param startWithinField The start index within the field for the splice operation.
   * @param deleteCount The number of bytes to delete in the splice operation.
   * @param fieldLength The field length for the splice operation.
   */
  error Store_InvalidSplice(uint40 startWithinField, uint40 deleteCount, uint40 fieldLength);
}

// node_modules/@latticexyz/store/src/rightMask.sol

/**
 * @title Byte Mask Utility
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Utility functions to manage bytes in memory.
 * @dev Adapted from https://github.com/dk1a/solidity-stringutils/blob/main/src/utils/mem.sol#L149-L167
 */

/**
 * @notice Computes a right-aligned byte mask based on the provided byte length.
 * @dev The mask is used to extract a specified number of rightmost bytes.
 
 * @param byteLength The number of rightmost bytes to be masked.
 * @return mask A right-aligned byte mask corresponding to the specified byte length.
 */
function rightMask(uint256 byteLength) pure returns (uint256 mask) {
  unchecked {
    return type(uint256).max >> (byteLength * BYTE_TO_BITS);
  }
}

// node_modules/@latticexyz/world/src/IWorldContextConsumer.sol

/**
 * @title WorldContextConsumer - Extracting trusted context values from appended calldata.
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This contract is designed to extract trusted context values (like msg.sender and msg.value)
 * from the appended calldata. It provides mechanisms similar to EIP-2771 (https://eips.ethereum.org/EIPS/eip-2771),
 * but allowing any contract to be the trusted forwarder.
 * @dev This contract should only be used for contracts without their own storage, like Systems.
 */
interface IWorldContextConsumer is IERC165_1 {
  /**
   * @notice Extract the `msg.sender` from the context appended to the calldata.
   * @return The address of the `msg.sender` that called the World contract
   * before the World routed the call to the WorldContextConsumer contract.
   */
  function _msgSender() external view returns (address);

  /**
   * @notice Extract the `msg.value` from the context appended to the calldata.
   * @return The `msg.value` in the call to the World contract before the World routed the
   * call to the WorldContextConsumer contract.
   */
  function _msgValue() external view returns (uint256);

  /**
   * @notice Get the address of the World contract that routed the call to this WorldContextConsumer.
   * @return The address of the World contract that routed the call to this WorldContextConsumer.
   */
  function _world() external view returns (address);
}

// node_modules/@latticexyz/world/src/IWorldErrors.sol

/**
 * @title World Errors Interface
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface contains custom error types for the World contract. These errors provide
 * more informative messages for certain operations within the World contract.
 */
interface IWorldErrors {
  /**
   * @notice Raised when trying to initialize an already initialized World.
   */
  error World_AlreadyInitialized();

  /**
   * @notice Raised when trying to register a resource that already exists.
   * @param resourceId The ID of the resource.
   * @param resourceIdString The string representation of the resource ID.
   */
  error World_ResourceAlreadyExists(ResourceId resourceId, string resourceIdString);

  /**
   * @notice Raised when the specified resource is not found.
   * @param resourceId The ID of the resource.
   * @param resourceIdString The string representation of the resource ID.
   */
  error World_ResourceNotFound(ResourceId resourceId, string resourceIdString);

  /**
   * @notice Raised when a user tries to access a resource they don't have permission for.
   * @param resource The resource's identifier.
   * @param caller The address of the user trying to access the resource.
   */
  error World_AccessDenied(string resource, address caller);

  /**
   * @notice Raised when an invalid resource ID is provided.
   * @param resourceId The ID of the resource.
   * @param resourceIdString The string representation of the resource ID.
   */
  error World_InvalidResourceId(ResourceId resourceId, string resourceIdString);

  /**
   * @notice Raised when an namespace contains an invalid sequence of characters ("__").
   * @param namespace The invalid namespace.
   */
  error World_InvalidNamespace(bytes14 namespace);

  /**
   * @notice Raised when trying to register a system that already exists.
   * @param system The address of the system.
   */
  error World_SystemAlreadyExists(address system);

  /**
   * @notice Raised when trying to register a function selector that already exists.
   * @param functionSelector The function selector in question.
   */
  error World_FunctionSelectorAlreadyExists(bytes4 functionSelector);

  /**
   * @notice Raised when the specified function selector is not found.
   * @param functionSelector The function selector in question.
   */
  error World_FunctionSelectorNotFound(bytes4 functionSelector);

  /**
   * @notice Raised when the specified delegation is not found.
   * @param delegator The address of the delegator.
   * @param delegatee The address of the delegatee.
   */
  error World_DelegationNotFound(address delegator, address delegatee);

  /**
   * @notice Raised when trying to create an unlimited delegation in a context where it is not allowed,
   * e.g. when registering a namespace fallback delegation.
   */
  error World_UnlimitedDelegationNotAllowed();

  /**
   * @notice Raised when there's an insufficient balance for a particular operation.
   * @param balance The current balance.
   * @param amount The amount needed.
   */
  error World_InsufficientBalance(uint256 balance, uint256 amount);

  /**
   * @notice Raised when the specified interface is not supported by the contract.
   * @param contractAddress The address of the contract in question.
   * @param interfaceId The ID of the interface.
   */
  error World_InterfaceNotSupported(address contractAddress, bytes4 interfaceId);

  /**
   * @notice Raised when an invalid resource type is provided.
   * @param expected The expected resource type.
   * @param resourceId The ID of the resource.
   * @param resourceIdString The string representation of the resource ID.
   */
  error World_InvalidResourceType(bytes2 expected, ResourceId resourceId, string resourceIdString);

  /**
   * @notice Raised when the World is calling itself via an external call.
   * @param functionSelector The function selector of the disallowed callback.
   */
  error World_CallbackNotAllowed(bytes4 functionSelector);
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IBalanceTransferSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IBalanceTransferSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IBalanceTransferSystem {
  function transferBalanceToNamespace(ResourceId fromNamespaceId, ResourceId toNamespaceId, uint256 amount) external;

  function transferBalanceToAddress(ResourceId fromNamespaceId, address toAddress, uint256 amount) external;
}

// node_modules/@latticexyz/world/src/modules/init/types.sol

/**
 * @title System Call Data Structure
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Holds data for making system calls.
 * @dev Used to represent a call to a specific system identified by a ResourceId.
 */
struct SystemCallData {
  /// @dev The ID of the system to call.
  ResourceId systemId;
  /// @dev The call data to pass to the system function.
  bytes callData;
}

/**
 * @title System Call From Data Structure
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Holds data for making system calls with a specific sender.
 * @dev Used to represent a call from a specific address to a specific system.
 */
struct SystemCallFromData {
  /// @dev The address from which the system call is made.
  address from;
  /// @dev The ID of the system to call.
  ResourceId systemId;
  /// @dev The call data to pass to the system function.
  bytes callData;
}

// node_modules/@latticexyz/world/src/worldResourceTypes.sol

/**
 * @dev Constants used to work with world resource types.
 */

// Resource that identifies a namespace, a container belonging to a
// specific address (not necessarily the original deployer of the World).
// A namespace can include tables and systems.
bytes2 constant RESOURCE_NAMESPACE = "ns";

// Resource that identifies a system, a contract used to manipulate
// the state.
bytes2 constant RESOURCE_SYSTEM = "sy";

// Masks used to filter or match a specific resource type
bytes32 constant MASK_RESOURCE_NAMESPACE = bytes32(RESOURCE_NAMESPACE);

// node_modules/@latticexyz/store/src/EncodedLengths.sol

/**
 * @title EncodedLengths Type Definition
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Describes how the encoded lengths is structured.
 * - 0x00-0x06 The least significant 7 bytes (uint56) represent the total byte length of dynamic (variable length) data.
 * - 0x07-0xB The next five bytes (uint40) represent the length of the first dynamic field.
 * - 0x0C-0x10 Followed by the length of the second dynamic field
 * - 0x11-0x15 Length of the third dynamic field
 * - 0x16-0x1A Length of fourth dynamic field
 * - 0x1B-0x1F Length of fifth dynamic field
 */
type EncodedLengths is bytes32;

using EncodedLengthsInstance for EncodedLengths global;

// Constants for encoded lengths handling:

// Number of bits for the 7-byte accumulator
uint256 constant ACC_BITS = 7 * BYTE_TO_BITS;
// Number of bits for the 5-byte sections
uint256 constant VAL_BITS = 5 * BYTE_TO_BITS;
// Maximum value of a 5-byte section
uint256 constant MAX_VAL = type(uint40).max;

/**
 * @title EncodedLengths Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Static functions for handling EncodedLengths type.
 * @dev Provides utility functions to pack values into EncodedLengths.
 * The caller must ensure that the value arguments are <= MAX_VAL.
 */
library EncodedLengthsLib {
  /**
   * @notice Packs a single value into EncodedLengths.
   * @dev Encodes the given value 'a' into the structure of EncodedLengths. The encoded lengths's accumulator
   * will be set to 'a', and the first value slot of the EncodedLengths will also be set to 'a'.
   * @param a The length of the first dynamic field's data.
   * @return The resulting EncodedLengths containing the encoded value.
   */
  function pack(uint256 a) internal pure returns (EncodedLengths) {
    uint256 encodedLengths;
    unchecked {
      encodedLengths = a;
      encodedLengths |= (uint256(a) << (ACC_BITS + VAL_BITS * 0));
    }
    return EncodedLengths.wrap(bytes32(encodedLengths));
  }

  /**
   * @notice Packs two values into EncodedLengths.
   * @dev Encodes the given values 'a'-'b' into the structure of EncodedLengths.
   * @param a The length of the first dynamic field's data.
   * @param b The length of the second dynamic field's data.
   * @return The resulting EncodedLengths containing the encoded values.
   */
  function pack(uint256 a, uint256 b) internal pure returns (EncodedLengths) {
    uint256 encodedLengths;
    unchecked {
      encodedLengths = a + b;
      encodedLengths |= (uint256(a) << (ACC_BITS + VAL_BITS * 0));
      encodedLengths |= (uint256(b) << (ACC_BITS + VAL_BITS * 1));
    }
    return EncodedLengths.wrap(bytes32(encodedLengths));
  }

  /**
   * @notice Packs three values into EncodedLengths.
   * @dev Encodes the given values 'a'-'c' into the structure of EncodedLengths.
   * @param a The length of the first dynamic field's data.
   * @param b The length of the second dynamic field's data.
   * @param c The length of the third dynamic field's data.
   * @return The resulting EncodedLengths containing the encoded values.
   */
  function pack(uint256 a, uint256 b, uint256 c) internal pure returns (EncodedLengths) {
    uint256 encodedLengths;
    unchecked {
      encodedLengths = a + b + c;
      encodedLengths |= (uint256(a) << (ACC_BITS + VAL_BITS * 0));
      encodedLengths |= (uint256(b) << (ACC_BITS + VAL_BITS * 1));
      encodedLengths |= (uint256(c) << (ACC_BITS + VAL_BITS * 2));
    }
    return EncodedLengths.wrap(bytes32(encodedLengths));
  }

  /**
   * @notice Packs four values into EncodedLengths.
   * @dev Encodes the given values 'a'-'d' into the structure of EncodedLengths.
   * @param a The length of the first dynamic field's data.
   * @param b The length of the second dynamic field's data.
   * @param c The length of the third dynamic field's data.
   * @param d The length of the fourth dynamic field's data.
   * @return The resulting EncodedLengths containing the encoded values.
   */
  function pack(uint256 a, uint256 b, uint256 c, uint256 d) internal pure returns (EncodedLengths) {
    uint256 encodedLengths;
    unchecked {
      encodedLengths = a + b + c + d;
      encodedLengths |= (uint256(a) << (ACC_BITS + VAL_BITS * 0));
      encodedLengths |= (uint256(b) << (ACC_BITS + VAL_BITS * 1));
      encodedLengths |= (uint256(c) << (ACC_BITS + VAL_BITS * 2));
      encodedLengths |= (uint256(d) << (ACC_BITS + VAL_BITS * 3));
    }
    return EncodedLengths.wrap(bytes32(encodedLengths));
  }

  /**
   * @notice Packs five values into EncodedLengths.
   * @dev Encodes the given values 'a'-'e' into the structure of EncodedLengths.
   * @param a The length of the first dynamic field's data.
   * @param b The length of the second dynamic field's data.
   * @param c The length of the third dynamic field's data.
   * @param d The length of the fourth dynamic field's data.
   * @param e The length of the fifth dynamic field's data.
   * @return The resulting EncodedLengths containing the encoded values.
   */
  function pack(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e) internal pure returns (EncodedLengths) {
    uint256 encodedLengths;
    unchecked {
      encodedLengths = a + b + c + d + e;
      encodedLengths |= (uint256(a) << (ACC_BITS + VAL_BITS * 0));
      encodedLengths |= (uint256(b) << (ACC_BITS + VAL_BITS * 1));
      encodedLengths |= (uint256(c) << (ACC_BITS + VAL_BITS * 2));
      encodedLengths |= (uint256(d) << (ACC_BITS + VAL_BITS * 3));
      encodedLengths |= (uint256(e) << (ACC_BITS + VAL_BITS * 4));
    }
    return EncodedLengths.wrap(bytes32(encodedLengths));
  }
}

/**
 * @title EncodedLengths Instance Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Instance functions for handling EncodedLengths.
 * @dev Offers decoding, extracting, and setting functionalities for EncodedLengths.
 */
library EncodedLengthsInstance {
  /**
   * @notice Decode the accumulated counter from EncodedLengths.
   * @dev Extracts the right-most 7 bytes of EncodedLengths.
   * @param encodedLengths The encoded lengths to decode.
   * @return The accumulated value from the EncodedLengths.
   */
  function total(EncodedLengths encodedLengths) internal pure returns (uint256) {
    return uint56(uint256(EncodedLengths.unwrap(encodedLengths)));
  }

  /**
   * @notice Decode the dynamic field size at a specific index from EncodedLengths.
   * @dev Extracts value right-to-left, with 5 bytes per dynamic field after the right-most 7 bytes.
   * @param encodedLengths The encoded lengths to decode.
   * @param index The index to retrieve.
   * @return The value at the given index from the EncodedLengths.
   */
  function atIndex(EncodedLengths encodedLengths, uint8 index) internal pure returns (uint256) {
    unchecked {
      return uint40(uint256(EncodedLengths.unwrap(encodedLengths) >> (ACC_BITS + VAL_BITS * index)));
    }
  }

  /**
   * @notice Set a counter at a specific index in EncodedLengths.
   * @dev Updates a value at a specific index and updates the accumulator field.
   * @param encodedLengths The encoded lengths to modify.
   * @param index The index to set.
   * @param newValueAtIndex The new value to set at the given index.
   * @return The modified EncodedLengths.
   */
  function setAtIndex(
    EncodedLengths encodedLengths,
    uint8 index,
    uint256 newValueAtIndex
  ) internal pure returns (EncodedLengths) {
    if (newValueAtIndex > MAX_VAL) {
      revert IEncodedLengthsErrors.EncodedLengths_InvalidLength(newValueAtIndex);
    }

    uint256 rawEncodedLengths = uint256(EncodedLengths.unwrap(encodedLengths));

    // Get current lengths (total and at index)
    uint256 accumulator = total(encodedLengths);
    uint256 currentValueAtIndex = atIndex(encodedLengths, index);

    // Compute the difference and update the total value
    unchecked {
      if (newValueAtIndex >= currentValueAtIndex) {
        accumulator += newValueAtIndex - currentValueAtIndex;
      } else {
        accumulator -= currentValueAtIndex - newValueAtIndex;
      }
    }

    // Set the new accumulated value and value at index
    // (7 bytes total length, 5 bytes per dynamic field)
    uint256 offset;
    unchecked {
      offset = ACC_BITS + VAL_BITS * index;
    }
    // Bitmask with 1s at the 5 bytes that form the value slot at the given index
    uint256 mask = uint256(type(uint40).max) << offset;

    // First set the last 7 bytes to 0, then set them to the new length
    rawEncodedLengths = (rawEncodedLengths & ~uint256(type(uint56).max)) | accumulator;

    // Zero out the value slot at the given index, then set the new value
    rawEncodedLengths = (rawEncodedLengths & ~mask) | ((newValueAtIndex << offset) & mask);

    return EncodedLengths.wrap(bytes32(rawEncodedLengths));
  }

  /**
   * @notice Unwrap EncodedLengths to its raw bytes32 representation.
   * @param encodedLengths The encoded lengths to unwrap.
   * @return The raw bytes32 value of the EncodedLengths.
   */
  function unwrap(EncodedLengths encodedLengths) internal pure returns (bytes32) {
    return EncodedLengths.unwrap(encodedLengths);
  }
}

// node_modules/@latticexyz/store/src/FieldLayout.sol

/**
 * @title FieldLayout
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Represents a field layout encoded into a single bytes32.
 * From left to right, the bytes are laid out as follows:
 * - 2 bytes for total length of all static fields
 * - 1 byte for number of static size fields
 * - 1 byte for number of dynamic size fields
 * - 28 bytes for 28 static field lengths
 * (MAX_DYNAMIC_FIELDS allows EncodedLengths to pack the dynamic lengths into 1 word)
 */
type FieldLayout is bytes32;

// When importing FieldLayout, attach FieldLayoutInstance to it
using FieldLayoutInstance for FieldLayout global;

/**
 * @title FieldLayoutLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev A library for handling field layout encoding into a single bytes32.
 * It provides a function to encode static and dynamic fields and ensure
 * various constraints regarding the length and size of the fields.
 */
library FieldLayoutLib {
  /**
   * @notice Encodes the given field layout into a single bytes32.
   * @dev Ensures various constraints on the length and size of the fields.
   * Reverts if total fields, static field length, or static byte length exceed allowed limits.
   * @param _staticFieldLengths An array of static field lengths.
   * @param numDynamicFields The number of dynamic fields.
   * @return A FieldLayout structure containing the encoded field layout.
   */
  function encode(uint256[] memory _staticFieldLengths, uint256 numDynamicFields) internal pure returns (FieldLayout) {
    uint256 fieldLayout;
    uint256 totalLength;
    uint256 totalFields = _staticFieldLengths.length + numDynamicFields;
    if (totalFields > MAX_TOTAL_FIELDS)
      revert IFieldLayoutErrors.FieldLayout_TooManyFields(totalFields, MAX_TOTAL_FIELDS);
    if (numDynamicFields > MAX_DYNAMIC_FIELDS)
      revert IFieldLayoutErrors.FieldLayout_TooManyDynamicFields(numDynamicFields, MAX_DYNAMIC_FIELDS);

    // Compute the total static length and store the field lengths in the encoded fieldLayout
    for (uint256 i; i < _staticFieldLengths.length; ) {
      uint256 staticByteLength = _staticFieldLengths[i];
      if (staticByteLength == 0) {
        revert IFieldLayoutErrors.FieldLayout_StaticLengthIsZero(i);
      } else if (staticByteLength > WORD_SIZE) {
        revert IFieldLayoutErrors.FieldLayout_StaticLengthDoesNotFitInAWord(i);
      }

      unchecked {
        // (safe because 28 (max _staticFieldLengths.length) * 32 (max static length) < 2**16)
        totalLength += staticByteLength;
        // Sequentially store lengths after the first 4 bytes (which are reserved for total length and field numbers)
        // (safe because of the initial _staticFieldLengths.length check)
        fieldLayout |= uint256(_staticFieldLengths[i]) << ((WORD_LAST_INDEX - 4 - i) * BYTE_TO_BITS);
        i++;
      }
    }

    // Store total static length in the first 2 bytes,
    // number of static fields in the 3rd byte,
    // number of dynamic fields in the 4th byte
    // (optimizer can handle this, no need for unchecked or single-line assignment)
    fieldLayout |= totalLength << LayoutOffsets.TOTAL_LENGTH;
    fieldLayout |= _staticFieldLengths.length << LayoutOffsets.NUM_STATIC_FIELDS;
    fieldLayout |= numDynamicFields << LayoutOffsets.NUM_DYNAMIC_FIELDS;

    return FieldLayout.wrap(bytes32(fieldLayout));
  }
}

/**
 * @title FieldLayoutInstance
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Provides instance functions for obtaining information from an encoded FieldLayout.
 */
library FieldLayoutInstance {
  /**
   * @notice Get the static byte length at the given index from the field layout.
   * @param fieldLayout The FieldLayout to extract the byte length from.
   * @param index The field index to get the static byte length from.
   * @return The static byte length at the specified index.
   */
  function atIndex(FieldLayout fieldLayout, uint256 index) internal pure returns (uint256) {
    unchecked {
      return uint8(uint256(fieldLayout.unwrap()) >> ((WORD_LAST_INDEX - 4 - index) * BYTE_TO_BITS));
    }
  }

  /**
   * @notice Get the total static byte length for the given field layout.
   * @param fieldLayout The FieldLayout to extract the total static byte length from.
   * @return The total static byte length.
   */
  function staticDataLength(FieldLayout fieldLayout) internal pure returns (uint256) {
    return uint256(FieldLayout.unwrap(fieldLayout)) >> LayoutOffsets.TOTAL_LENGTH;
  }

  /**
   * @notice Get the number of static fields for the field layout.
   * @param fieldLayout The FieldLayout to extract the number of static fields from.
   * @return The number of static fields.
   */
  function numStaticFields(FieldLayout fieldLayout) internal pure returns (uint256) {
    return uint8(uint256(fieldLayout.unwrap()) >> LayoutOffsets.NUM_STATIC_FIELDS);
  }

  /**
   * @notice Get the number of dynamic length fields for the field layout.
   * @param fieldLayout The FieldLayout to extract the number of dynamic fields from.
   * @return The number of dynamic length fields.
   */
  function numDynamicFields(FieldLayout fieldLayout) internal pure returns (uint256) {
    return uint8(uint256(fieldLayout.unwrap()) >> LayoutOffsets.NUM_DYNAMIC_FIELDS);
  }

  /**
   * @notice Get the total number of fields for the field layout.
   * @param fieldLayout The FieldLayout to extract the total number of fields from.
   * @return The total number of fields.
   */
  function numFields(FieldLayout fieldLayout) internal pure returns (uint256) {
    unchecked {
      return
        uint8(uint256(fieldLayout.unwrap()) >> LayoutOffsets.NUM_STATIC_FIELDS) +
        uint8(uint256(fieldLayout.unwrap()) >> LayoutOffsets.NUM_DYNAMIC_FIELDS);
    }
  }

  /**
   * @notice Check if the field layout is empty.
   * @param fieldLayout The FieldLayout to check.
   * @return True if the field layout is empty, false otherwise.
   */
  function isEmpty(FieldLayout fieldLayout) internal pure returns (bool) {
    return FieldLayout.unwrap(fieldLayout) == bytes32(0);
  }

  /**
   * @notice Validate the field layout with various checks on the length and size of the fields.
   * @dev Reverts if total fields, static field length, or static byte length exceed allowed limits.
   * @param fieldLayout The FieldLayout to validate.
   */
  function validate(FieldLayout fieldLayout) internal pure {
    if (fieldLayout.isEmpty()) {
      revert IFieldLayoutErrors.FieldLayout_Empty();
    }

    uint256 _numDynamicFields = fieldLayout.numDynamicFields();
    if (_numDynamicFields > MAX_DYNAMIC_FIELDS) {
      revert IFieldLayoutErrors.FieldLayout_TooManyDynamicFields(_numDynamicFields, MAX_DYNAMIC_FIELDS);
    }

    uint256 _numStaticFields = fieldLayout.numStaticFields();
    uint256 _numTotalFields = _numStaticFields + _numDynamicFields;
    if (_numTotalFields > MAX_TOTAL_FIELDS) {
      revert IFieldLayoutErrors.FieldLayout_TooManyFields(_numTotalFields, MAX_TOTAL_FIELDS);
    }

    // Static lengths must be valid
    uint256 _staticDataLength;
    for (uint256 i; i < _numStaticFields; ) {
      uint256 staticByteLength = fieldLayout.atIndex(i);
      if (staticByteLength == 0) {
        revert IFieldLayoutErrors.FieldLayout_StaticLengthIsZero(i);
      } else if (staticByteLength > WORD_SIZE) {
        revert IFieldLayoutErrors.FieldLayout_StaticLengthDoesNotFitInAWord(i);
      }
      _staticDataLength += staticByteLength;
      unchecked {
        i++;
      }
    }
    // Static length sums must match
    if (_staticDataLength != fieldLayout.staticDataLength()) {
      revert IFieldLayoutErrors.FieldLayout_InvalidStaticDataLength(fieldLayout.staticDataLength(), _staticDataLength);
    }
    // Unused fields must be zero
    for (uint256 i = _numStaticFields; i < MAX_TOTAL_FIELDS; i++) {
      uint256 staticByteLength = fieldLayout.atIndex(i);
      if (staticByteLength != 0) {
        revert IFieldLayoutErrors.FieldLayout_StaticLengthIsNotZero(i);
      }
    }
  }

  /**
   * @notice Unwrap the field layout to obtain the raw bytes32 representation.
   * @param fieldLayout The FieldLayout to unwrap.
   * @return The unwrapped bytes32 representation of the FieldLayout.
   */
  function unwrap(FieldLayout fieldLayout) internal pure returns (bytes32) {
    return FieldLayout.unwrap(fieldLayout);
  }
}

// node_modules/@latticexyz/store/src/Memory.sol

/**
 * @title Memory Operations
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice A library for performing low-level memory operations.
 * @dev This library provides low-level memory operations with safety checks.
 */
library Memory {
  /**
   * @notice Gets the actual data pointer of dynamic arrays.
   * @dev In dynamic arrays, the first word stores the length of the data, after which comes the actual data.
   * Example: 0x40 0x01 0x02
   *          ^len ^data
   * @param data The dynamic bytes data from which to get the pointer.
   * @return memoryPointer The pointer to the actual data (skipping the length).
   */
  function dataPointer(bytes memory data) internal pure returns (uint256 memoryPointer) {
    assembly {
      memoryPointer := add(data, 0x20)
    }
  }

  /**
   * @notice Copies memory from one location to another.
   * @dev Safely copies memory in chunks of 32 bytes, then handles any residual bytes.
   * @param fromPointer The memory location to copy from.
   * @param toPointer The memory location to copy to.
   * @param length The number of bytes to copy.
   */
  function copy(uint256 fromPointer, uint256 toPointer, uint256 length) internal pure {
    // Copy 32-byte chunks
    while (length >= 32) {
      /// @solidity memory-safe-assembly
      assembly {
        mstore(toPointer, mload(fromPointer))
      }
      // Safe because total addition will be <= length (ptr+len is implicitly safe)
      unchecked {
        toPointer += 32;
        fromPointer += 32;
        length -= 32;
      }
    }
    if (length == 0) return;

    // Copy the 0-31 length tail
    uint256 mask = rightMask(length);
    /// @solidity memory-safe-assembly
    assembly {
      mstore(
        toPointer,
        or(
          // store the left part
          and(mload(fromPointer), not(mask)),
          // preserve the right part
          and(mload(toPointer), mask)
        )
      )
    }
  }
}

// node_modules/@latticexyz/world/src/IModule.sol

/**
 * @title IModule
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Interface for the Module system.
 * A module can be installed within the context of a world, either as a root or non-root module.
 * This interface adheres to the ERC-165 standard for determining interface support.
 */
interface IModule is IERC165_1, IModuleErrors {
  /**
   * @notice Installs the module as a root module.
   * @dev This function is invoked by the World contract during `installRootModule` process.
   * The module expects to be called via the World contract and thus installs itself on the `msg.sender`.
   * @param encodedArgs The ABI encoded arguments that may be needed during the installation process.
   */
  function installRoot(bytes memory encodedArgs) external;

  /**
   * @notice Installs the module.
   * @dev This function is invoked by the World contract during `installModule` process.
   * The module expects to be called via the World contract and thus installs itself on the `msg.sender`.
   * Logic might differ from `installRoot`, for example, this might accept namespace parameters.
   * @param encodedArgs The ABI encoded arguments that may be needed during the installation process.
   */
  function install(bytes memory encodedArgs) external;
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IBatchCallSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IBatchCallSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IBatchCallSystem {
  function batchCall(SystemCallData[] calldata systemCalls) external returns (bytes[] memory returnDatas);

  function batchCallFrom(SystemCallFromData[] calldata systemCalls) external returns (bytes[] memory returnDatas);
}

// node_modules/@latticexyz/store/src/Schema.sol

/**
 * @title Schema handling in Lattice
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Defines and handles the encoding/decoding of Schemas which describe the layout of data structures.
 * 2 bytes length of all the static (in size) fields in the schema
 * 1 byte for number of static size fields
 * 1 byte for number of dynamic size fields
 * 28 bytes for 28 schema types (MAX_DYNAMIC_FIELDS allows us to pack the lengths into 1 word)
 */
type Schema is bytes32;

using SchemaInstance for Schema global;

/**
 * @title SchemaLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Static utility functions for handling Schemas.
 */
library SchemaLib {
  /**
   * @notice Encodes a given schema into a single bytes32.
   * @param schemas The list of SchemaTypes that constitute the schema.
   * @return The encoded Schema.
   */
  function encode(SchemaType[] memory schemas) internal pure returns (Schema) {
    if (schemas.length > MAX_TOTAL_FIELDS) revert ISchemaErrors.Schema_InvalidLength(schemas.length);
    uint256 schema;
    uint256 totalLength;
    uint256 dynamicFields;

    // Compute the length of the schema and the number of static fields
    // and store the schema types in the encoded schema
    for (uint256 i = 0; i < schemas.length; ) {
      uint256 staticByteLength = schemas[i].getStaticByteLength();

      if (staticByteLength == 0) {
        // Increase the dynamic field count if the field is dynamic
        // (safe because of the initial _schema.length check)
        unchecked {
          dynamicFields++;
        }
      } else if (dynamicFields > 0) {
        // Revert if we have seen a dynamic field before, but now we see a static field
        revert ISchemaErrors.Schema_StaticTypeAfterDynamicType();
      }

      unchecked {
        // (safe because 28 (max _schema.length) * 32 (max static length) < 2**16)
        totalLength += staticByteLength;
        // Sequentially store schema types after the first 4 bytes (which are reserved for length and field numbers)
        // (safe because of the initial _schema.length check)
        schema |= uint256(schemas[i]) << ((WORD_LAST_INDEX - 4 - i) * BYTE_TO_BITS);
        i++;
      }
    }

    // Require MAX_DYNAMIC_FIELDS
    if (dynamicFields > MAX_DYNAMIC_FIELDS) revert ISchemaErrors.Schema_InvalidLength(dynamicFields);

    // Get the static field count
    uint256 staticFields;
    unchecked {
      staticFields = schemas.length - dynamicFields;
    }

    // Store total static length in the first 2 bytes,
    // number of static fields in the 3rd byte,
    // number of dynamic fields in the 4th byte
    // (optimizer can handle this, no need for unchecked or single-line assignment)
    schema |= totalLength << LayoutOffsets.TOTAL_LENGTH;
    schema |= staticFields << LayoutOffsets.NUM_STATIC_FIELDS;
    schema |= dynamicFields << LayoutOffsets.NUM_DYNAMIC_FIELDS;

    return Schema.wrap(bytes32(schema));
  }
}

/**
 * @title SchemaInstance
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Instance utility functions for handling a Schema instance.
 */
library SchemaInstance {
  /**
   * @notice Get the length of static data for the given schema.
   * @param schema The schema to inspect.
   * @return The static data length.
   */
  function staticDataLength(Schema schema) internal pure returns (uint256) {
    return uint256(Schema.unwrap(schema)) >> LayoutOffsets.TOTAL_LENGTH;
  }

  /**
   * @notice Get the SchemaType at a given index in the schema.
   * @param schema The schema to inspect.
   * @param index The index of the SchemaType to retrieve.
   * @return The SchemaType at the given index.
   */
  function atIndex(Schema schema, uint256 index) internal pure returns (SchemaType) {
    unchecked {
      return SchemaType(uint8(uint256(schema.unwrap()) >> ((WORD_LAST_INDEX - 4 - index) * 8)));
    }
  }

  /**
   * @notice Get the number of static (fixed length) fields in the schema.
   * @param schema The schema to inspect.
   * @return The number of static fields.
   */
  function numStaticFields(Schema schema) internal pure returns (uint256) {
    return uint8(uint256(schema.unwrap()) >> LayoutOffsets.NUM_STATIC_FIELDS);
  }

  /**
   * @notice Get the number of dynamic length fields in the schema.
   * @param schema The schema to inspect.
   * @return The number of dynamic length fields.
   */
  function numDynamicFields(Schema schema) internal pure returns (uint256) {
    return uint8(uint256(schema.unwrap()) >> LayoutOffsets.NUM_DYNAMIC_FIELDS);
  }

  /**
   * @notice Get the total number of fields in the schema.
   * @param schema The schema to inspect.
   * @return The total number of fields.
   */
  function numFields(Schema schema) internal pure returns (uint256) {
    unchecked {
      return
        uint8(uint256(schema.unwrap()) >> LayoutOffsets.NUM_STATIC_FIELDS) +
        uint8(uint256(schema.unwrap()) >> LayoutOffsets.NUM_DYNAMIC_FIELDS);
    }
  }

  /**
   * @notice Checks if the provided schema is empty.
   * @param schema The schema to check.
   * @return true if the schema is empty, false otherwise.
   */
  function isEmpty(Schema schema) internal pure returns (bool) {
    return Schema.unwrap(schema) == bytes32(0);
  }

  /**
   * @notice Validates the given schema.
   * @param schema The schema to validate.
   * @param allowEmpty Determines if an empty schema is valid or not.
   */
  function validate(Schema schema, bool allowEmpty) internal pure {
    // Schema must not be empty
    if (!allowEmpty && schema.isEmpty()) revert ISchemaErrors.Schema_InvalidLength(0);

    // Schema must have no more than MAX_DYNAMIC_FIELDS
    uint256 _numDynamicFields = schema.numDynamicFields();
    if (_numDynamicFields > MAX_DYNAMIC_FIELDS) revert ISchemaErrors.Schema_InvalidLength(_numDynamicFields);

    uint256 _numStaticFields = schema.numStaticFields();
    // Schema must not have more than MAX_TOTAL_FIELDS in total
    uint256 _numTotalFields = _numStaticFields + _numDynamicFields;
    if (_numTotalFields > MAX_TOTAL_FIELDS) revert ISchemaErrors.Schema_InvalidLength(_numTotalFields);

    // No dynamic field can be before a dynamic field
    uint256 _staticDataLength;
    for (uint256 i; i < _numStaticFields; ) {
      uint256 staticByteLength = schema.atIndex(i).getStaticByteLength();
      if (staticByteLength == 0) {
        revert ISchemaErrors.Schema_StaticTypeAfterDynamicType();
      }
      _staticDataLength += staticByteLength;
      unchecked {
        i++;
      }
    }

    // Static length sums must match
    if (_staticDataLength != schema.staticDataLength()) {
      revert ISchemaErrors.Schema_InvalidLength(schema.staticDataLength());
    }

    // No static field can be after a dynamic field
    for (uint256 i = _numStaticFields; i < _numTotalFields; ) {
      uint256 staticByteLength = schema.atIndex(i).getStaticByteLength();
      if (staticByteLength > 0) {
        revert ISchemaErrors.Schema_StaticTypeAfterDynamicType();
      }
      unchecked {
        i++;
      }
    }
  }

  /**
   * @notice Unwraps the schema to its underlying bytes32 representation.
   * @param schema The schema to unwrap.
   * @return The bytes32 representation of the schema.
   */
  function unwrap(Schema schema) internal pure returns (bytes32) {
    return Schema.unwrap(schema);
  }
}

// node_modules/@latticexyz/store/src/Storage.sol

/**
 * @title Storage Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Provides functions for low-level storage manipulation, including storing and retrieving bytes.
 */
library Storage {
  /**
   * @notice Store a single word of data at a specific storage pointer.
   * @param storagePointer The location to store the data.
   * @param data The 32-byte word of data to store.
   */
  function store(uint256 storagePointer, bytes32 data) internal {
    assembly {
      sstore(storagePointer, data)
    }
  }

  /**
   * @notice Store bytes of data at a specific storage pointer and offset.
   * @param storagePointer The base storage location.
   * @param offset Offset within the storage location.
   * @param data Bytes to store.
   */
  function store(uint256 storagePointer, uint256 offset, bytes memory data) internal {
    store(storagePointer, offset, data.length, Memory.dataPointer(data));
  }

  /**
   * @notice Stores raw bytes to storage at a given pointer, offset, and length, keeping the rest of the word intact.
   * @param storagePointer The base storage location.
   * @param offset Offset within the storage location.
   * @param memoryPointer Pointer to the start of the data in memory.
   * @param length Length of the data in bytes.
   */
  function store(uint256 storagePointer, uint256 offset, uint256 length, uint256 memoryPointer) internal {
    if (offset > 0) {
      // Support offsets that are greater than 32 bytes by incrementing the storagePointer and decrementing the offset
      if (offset >= 32) {
        unchecked {
          storagePointer += offset / 32;
          offset %= 32;
        }
      }

      // For the first word, if there is an offset, apply a mask to beginning
      if (offset > 0) {
        // Get the word's remaining length after the offset
        uint256 wordRemainder;
        // (safe because of `offset %= 32` at the start)
        unchecked {
          wordRemainder = 32 - offset;
        }

        uint256 mask = ~rightMask(length);
        /// @solidity memory-safe-assembly
        assembly {
          // Load data from memory and offset it to match storage
          let bitOffset := mul(offset, BYTE_TO_BITS)
          mask := shr(bitOffset, mask)
          let offsetData := shr(bitOffset, mload(memoryPointer))

          sstore(
            storagePointer,
            or(
              // Store the middle part
              and(offsetData, mask),
              // Preserve the surrounding parts
              and(sload(storagePointer), not(mask))
            )
          )
        }
        // Return if done
        if (length <= wordRemainder) return;

        // Advance pointers
        // (safe because of `length <= wordRemainder` earlier)
        unchecked {
          storagePointer += 1;
          memoryPointer += wordRemainder;
          length -= wordRemainder;
        }
      }
    }

    // Store full words
    while (length >= 32) {
      /// @solidity memory-safe-assembly
      assembly {
        sstore(storagePointer, mload(memoryPointer))
      }
      unchecked {
        storagePointer += 1;
        memoryPointer += 32;
        length -= 32;
      }
    }

    // For the last partial word, apply a mask to the end
    if (length > 0) {
      uint256 mask = rightMask(length);
      /// @solidity memory-safe-assembly
      assembly {
        sstore(
          storagePointer,
          or(
            // store the left part
            and(mload(memoryPointer), not(mask)),
            // preserve the right part
            and(sload(storagePointer), mask)
          )
        )
      }
    }
  }

  /**
   * @notice Set multiple storage locations to zero.
   * @param storagePointer The starting storage location.
   * @param length The number of storage locations to set to zero, in bytes
   */
  function zero(uint256 storagePointer, uint256 length) internal {
    // Ceil division to round up to the nearest word
    uint256 limit = storagePointer + (length + 31) / 32;
    while (storagePointer < limit) {
      /// @solidity memory-safe-assembly
      assembly {
        sstore(storagePointer, 0)
        storagePointer := add(storagePointer, 1)
      }
    }
  }

  /**
   * @notice Load a single word of data from a specific storage pointer.
   * @param storagePointer The location to load the data from.
   * @return word The loaded 32-byte word of data.
   */
  function load(uint256 storagePointer) internal view returns (bytes32 word) {
    assembly {
      word := sload(storagePointer)
    }
  }

  /**
   * @notice Load raw bytes from storage at a given pointer, offset, and length.
   * @param storagePointer The base storage location.
   * @param length Length of the data in bytes.
   * @param offset Offset within the storage location.
   * @return result The loaded bytes of data.
   */
  function load(uint256 storagePointer, uint256 offset, uint256 length) internal view returns (bytes memory result) {
    uint256 memoryPointer;
    /// @solidity memory-safe-assembly
    assembly {
      // Solidity's YulUtilFunctions::roundUpFunction
      function round_up_to_mul_of_32(value) -> _result {
        _result := and(add(value, 0x1F), not(0x1F))
      }

      // Allocate memory
      result := mload(0x40)
      memoryPointer := add(result, 0x20)
      mstore(0x40, round_up_to_mul_of_32(add(memoryPointer, length)))
      // Store length
      mstore(result, length)
    }
    load(storagePointer, offset, length, memoryPointer);
    return result;
  }

  /**
   * @notice Append raw bytes from storage at a given pointer, offset, and length to a specific memory pointer.
   * @param storagePointer The base storage location.
   * @param length Length of the data in bytes.
   * @param offset Offset within the storage location.
   * @param memoryPointer Pointer to the location in memory to append the data.
   */
  function load(uint256 storagePointer, uint256 offset, uint256 length, uint256 memoryPointer) internal view {
    if (offset > 0) {
      // Support offsets that are greater than 32 bytes by incrementing the storagePointer and decrementing the offset
      if (offset >= 32) {
        unchecked {
          storagePointer += offset / 32;
          offset %= 32;
        }
      }

      // For the first word, if there is an offset, apply a mask to beginning
      if (offset > 0) {
        // Get the word's remaining length after the offset
        uint256 wordRemainder;
        // (safe because of `offset %= 32` at the start)
        unchecked {
          wordRemainder = 32 - offset;
        }

        uint256 mask;
        if (length < wordRemainder) {
          mask = rightMask(length);
        } else {
          mask = rightMask(wordRemainder);
        }
        /// @solidity memory-safe-assembly
        assembly {
          // Load data from storage and offset it to match memory
          let offsetData := shl(mul(offset, BYTE_TO_BITS), sload(storagePointer))

          mstore(
            memoryPointer,
            or(
              // store the left part
              and(offsetData, not(mask)),
              // preserve the right parts
              and(mload(memoryPointer), mask)
            )
          )
        }
        // Return if done
        if (length <= wordRemainder) return;

        // Advance pointers
        // (safe because of `length <= wordRemainder` earlier)
        unchecked {
          storagePointer += 1;
          memoryPointer += wordRemainder;
          length -= wordRemainder;
        }
      }
    }

    // Load full words
    while (length >= 32) {
      /// @solidity memory-safe-assembly
      assembly {
        mstore(memoryPointer, sload(storagePointer))
      }
      unchecked {
        storagePointer += 1;
        memoryPointer += 32;
        length -= 32;
      }
    }

    // For the last partial word, apply a mask to the end
    if (length > 0) {
      uint256 mask = rightMask(length);
      /// @solidity memory-safe-assembly
      assembly {
        mstore(
          memoryPointer,
          or(
            // store the left part
            and(sload(storagePointer), not(mask)),
            // preserve the right part
            and(mload(memoryPointer), mask)
          )
        )
      }
    }
  }

  /**
   * @notice Load up to 32 bytes from storage at a given pointer and offset.
   * @dev Since fields are tightly packed, they can span more than one slot.
   * Since they're max 32 bytes, they can span at most 2 slots.
   * @param storagePointer The base storage location.
   * @param length Length of the data in bytes.
   * @param offset Offset within the storage location.
   * @return result The loaded bytes, left-aligned bytes. Bytes beyond the length are not zeroed.
   */
  function loadField(uint256 storagePointer, uint256 length, uint256 offset) internal view returns (bytes32 result) {
    if (offset >= 32) {
      unchecked {
        storagePointer += offset / 32;
        offset %= 32;
      }
    }

    // Extra data past length is not truncated
    // This assumes that the caller will handle the overflow bits appropriately
    assembly {
      result := shl(mul(offset, BYTE_TO_BITS), sload(storagePointer))
    }

    uint256 wordRemainder;
    // (safe because of `offset %= 32` at the start)
    unchecked {
      wordRemainder = 32 - offset;
    }

    // Read from the next slot if field spans 2 slots
    if (length > wordRemainder) {
      assembly {
        result := or(result, shr(mul(wordRemainder, BYTE_TO_BITS), sload(add(storagePointer, 1))))
      }
    }
  }
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IModuleInstallationSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IModuleInstallationSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IModuleInstallationSystem {
  function installModule(IModule module, bytes memory encodedArgs) external;
}

// node_modules/@latticexyz/world/src/constants.sol

bytes14 constant ROOT_NAMESPACE = "";
bytes16 constant ROOT_NAME = "";

ResourceId constant STORE_NAMESPACE_ID = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_NAMESPACE, bytes14("store"), ROOT_NAME))
);

ResourceId constant WORLD_NAMESPACE_ID = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_NAMESPACE, bytes14("world"), ROOT_NAME))
);

ResourceId constant ROOT_NAMESPACE_ID = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_NAMESPACE, ROOT_NAMESPACE, ROOT_NAME))
);

ResourceId constant UNLIMITED_DELEGATION = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_SYSTEM, ROOT_NAMESPACE, bytes16("unlimited")))
);

// node_modules/@latticexyz/store/src/IStoreEvents.sol

/**
 * @title IStoreEvents
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
interface IStoreEvents {
  /**
   * @notice Emitted when the Store is created.
   * @param storeVersion The protocol version of the Store.
   */
  event HelloStore(bytes32 indexed storeVersion);

  /**
   * @notice Emitted when a new record is set in the store.
   * @param tableId The ID of the table where the record is set.
   * @param keyTuple An array representing the composite key for the record.
   * @param staticData The static data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param dynamicData The dynamic data of the record.
   */
  event Store_SetRecord(
    ResourceId indexed tableId,
    bytes32[] keyTuple,
    bytes staticData,
    EncodedLengths encodedLengths,
    bytes dynamicData
  );

  /**
   * @notice Emitted when static data in the store is spliced.
   * @dev In static data, data is always overwritten starting at the start position,
   * so the total length of the data remains the same and no data is shifted.
   * @param tableId The ID of the table where the data is spliced.
   * @param keyTuple An array representing the key for the record.
   * @param start The start position in bytes for the splice operation.
   * @param data The data to write to the static data of the record at the start byte.
   */
  event Store_SpliceStaticData(ResourceId indexed tableId, bytes32[] keyTuple, uint48 start, bytes data);

  /**
   * @notice Emitted when dynamic data in the store is spliced.
   * @param tableId The ID of the table where the data is spliced.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to splice data, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @param start The start position in bytes for the splice operation.
   * @param deleteCount The number of bytes to delete in the splice operation.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param data The data to insert into the dynamic data of the record at the start byte.
   */
  event Store_SpliceDynamicData(
    ResourceId indexed tableId,
    bytes32[] keyTuple,
    uint8 dynamicFieldIndex,
    uint48 start,
    uint40 deleteCount,
    EncodedLengths encodedLengths,
    bytes data
  );

  /**
   * @notice Emitted when a record is deleted from the store.
   * @param tableId The ID of the table where the record is deleted.
   * @param keyTuple An array representing the composite key for the record.
   */
  event Store_DeleteRecord(ResourceId indexed tableId, bytes32[] keyTuple);
}

// node_modules/@latticexyz/world/src/WorldResourceId.sol

uint256 constant NAMESPACE_BYTES = 14;
uint256 constant NAMESPACE_BITS = 14 * 8; // 14 bytes * 8 bits per byte
uint256 constant NAME_BITS = 16 * 8; // 16 bytes * 8 bits per byte

bytes32 constant NAMESPACE_MASK = bytes32(~bytes14("")) >> (TYPE_BITS);

/**
 * @title WorldResourceIdLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice A library for handling World Resource ID encoding and decoding.
 */
library WorldResourceIdLib {
  /**
   * @notice Encode a resource ID.
   * @param typeId The resource type ID.
   * @param namespace The namespace of the resource.
   * @param name The name of the resource.
   * @return A 32-byte resource ID.
   */
  function encode(bytes2 typeId, bytes14 namespace, bytes16 name) internal pure returns (ResourceId) {
    return
      ResourceId.wrap(
        bytes32(typeId) | (bytes32(namespace) >> TYPE_BITS) | (bytes32(name) >> (TYPE_BITS + NAMESPACE_BITS))
      );
  }

  /**
   * @notice Encode a namespace to resource ID.
   * @param namespace The namespace to be encoded.
   * @return A 32-byte resource ID with the namespace encoded.
   */
  function encodeNamespace(bytes14 namespace) internal pure returns (ResourceId) {
    return ResourceId.wrap(bytes32(RESOURCE_NAMESPACE) | (bytes32(namespace) >> (TYPE_BITS)));
  }

  /**
   * @notice Convert a padded string to a trimmed string.
   * @param paddedString The input string with potential padding.
   * @return A string without trailing null ASCII characters.
   */
  function toTrimmedString(bytes16 paddedString) internal pure returns (string memory) {
    uint256 length;
    for (; length < 16; length++) if (Bytes.getBytes1(paddedString, length) == 0) break;
    bytes memory packedSelector = abi.encodePacked(paddedString);
    return string(Bytes.setLength(packedSelector, length));
  }
}

/**
 * @title WorldResourceIdInstance
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice A library for handling instances of World Resource IDs.
 */
library WorldResourceIdInstance {
  /**
   * @notice Get the namespace from a resource ID.
   * @param resourceId The resource ID.
   * @return A 14-byte namespace.
   */
  function getNamespace(ResourceId resourceId) internal pure returns (bytes14) {
    return bytes14(ResourceId.unwrap(resourceId) << (TYPE_BITS));
  }

  /**
   * @notice Get the namespace ID from a resource ID.
   * @param resourceId The resource ID.
   * @return A 32-byte namespace resource ID.
   */
  function getNamespaceId(ResourceId resourceId) internal pure returns (ResourceId) {
    return ResourceId.wrap((ResourceId.unwrap(resourceId) & NAMESPACE_MASK) | MASK_RESOURCE_NAMESPACE);
  }

  /**
   * @notice Get the name from a resource ID.
   * @param resourceId The resource ID.
   * @return A 16-byte name.
   */
  function getName(ResourceId resourceId) internal pure returns (bytes16) {
    return bytes16(ResourceId.unwrap(resourceId) << (TYPE_BITS + NAMESPACE_BITS));
  }

  /**
   * @notice Convert a resource ID to a string.
   * @param resourceId The resource ID.
   * @return A string representation of the resource ID.
   */
  function toString(ResourceId resourceId) internal pure returns (string memory) {
    bytes2 resourceType = ResourceIdInstance.getType(resourceId);
    bytes14 resourceNamespace = getNamespace(resourceId);
    bytes16 resourceName = getName(resourceId);
    return
      string(
        abi.encodePacked(
          resourceType,
          ":",
          resourceNamespace == ROOT_NAMESPACE ? "<root>" : WorldResourceIdLib.toTrimmedString(resourceNamespace),
          ":",
          resourceName == ROOT_NAME ? "<root>" : WorldResourceIdLib.toTrimmedString(resourceName)
        )
      );
  }
}

// node_modules/@latticexyz/store/src/Slice.sol

// Acknowledgements:
// Based on @dk1a's Slice.sol library (https://github.com/dk1a/solidity-stringutils/blob/main/src/Slice.sol)

// First 16 bytes are the pointer to the data, followed by 16 bytes of data length.
type Slice is uint256;

using SliceInstance for Slice global;
using DecodeSlice for Slice global;

/**
 * @title Static functions for Slice
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
library SliceLib {
  uint256 constant MASK_LEN = uint256(type(uint128).max);

  /**
   * @notice Converts a bytes array to a slice (without copying data)
   * @param data The bytes array to be converted
   * @return A new Slice representing the bytes array
   */
  function fromBytes(bytes memory data) internal pure returns (Slice) {
    uint256 pointer;
    assembly {
      pointer := add(data, 0x20) // pointer to first data byte
    }

    // Pointer is stored in upper 128 bits, length is stored in lower 128 bits
    return Slice.wrap((pointer << 128) | (data.length & MASK_LEN));
  }

  /**
   * @notice Subslice a bytes array using the given start index until the end of the array (without copying data)
   * @param data The bytes array to subslice
   * @param start The start index for the subslice
   * @return A new Slice representing the subslice
   */
  function getSubslice(bytes memory data, uint256 start) internal pure returns (Slice) {
    return getSubslice(data, start, data.length);
  }

  /**
   * @notice Subslice a bytes array using the given indexes (without copying data)
   * @dev The start index is inclusive, the end index is exclusive
   * @param data The bytes array to subslice
   * @param start The start index for the subslice
   * @param end The end index for the subslice
   * @return A new Slice representing the subslice
   */
  function getSubslice(bytes memory data, uint256 start, uint256 end) internal pure returns (Slice) {
    // TODO this check helps catch bugs and can eventually be removed
    if (start > end || end > data.length) revert ISliceErrors.Slice_OutOfBounds(data, start, end);

    uint256 pointer;
    assembly {
      pointer := add(data, 0x20) // pointer to first data byte
    }

    pointer += start;
    uint256 _len = end - start;

    // Pointer is stored in upper 128 bits, length is stored in lower 128 bits
    return Slice.wrap((pointer << 128) | (_len & MASK_LEN));
  }
}

/**
 * @title Instance functions for Slice
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
library SliceInstance {
  /**
   * @notice Returns the pointer to the start of a slice
   * @param self The slice whose pointer needs to be fetched
   * @return The pointer to the start of the slice
   */
  function pointer(Slice self) internal pure returns (uint256) {
    return Slice.unwrap(self) >> 128;
  }

  /**
   * @notice Returns the slice length in bytes
   * @param self The slice whose length needs to be fetched
   * @return The length of the slice
   */
  function length(Slice self) internal pure returns (uint256) {
    return Slice.unwrap(self) & SliceLib.MASK_LEN;
  }

  /**
   * @notice Converts a Slice to bytes
   * @dev This function internally manages the conversion of a slice into a bytes format.
   * @param self The Slice to be converted to bytes.
   * @return data The bytes representation of the provided Slice.
   */
  function toBytes(Slice self) internal pure returns (bytes memory data) {
    uint256 fromPointer = pointer(self);
    uint256 _length = length(self);

    // Allocate a new bytes array and get the pointer to it
    data = new bytes(_length);
    uint256 toPointer;
    assembly {
      toPointer := add(data, 0x20)
    }
    // Copy the slice contents to the array
    Memory.copy(fromPointer, toPointer, _length);
  }

  /**
   * @notice Converts a Slice to bytes32
   * @dev This function converts a slice into a fixed-length bytes32. Uses inline assembly for the conversion.
   * @param self The Slice to be converted to bytes32.
   * @return result The bytes32 representation of the provided Slice.
   */
  function toBytes32(Slice self) internal pure returns (bytes32 result) {
    uint256 memoryPointer = pointer(self);
    /// @solidity memory-safe-assembly
    assembly {
      result := mload(memoryPointer)
    }
    return result;
  }
}

// node_modules/@latticexyz/store/src/tightcoder/DecodeSlice.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title DecodeSlice Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice A library for decoding slices of data into specific data types.
 * @dev This library provides functions for decoding slices into arrays of basic uint types.
 */
library DecodeSlice {
  /**
   * @notice Decodes a slice into an array of uint8.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint8.
   */
  function decodeArray_uint8(Slice _input) internal pure returns (uint8[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 1, 248);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint16.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint16.
   */
  function decodeArray_uint16(Slice _input) internal pure returns (uint16[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 2, 240);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint24.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint24.
   */
  function decodeArray_uint24(Slice _input) internal pure returns (uint24[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 3, 232);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint32.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint32.
   */
  function decodeArray_uint32(Slice _input) internal pure returns (uint32[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 4, 224);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint40.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint40.
   */
  function decodeArray_uint40(Slice _input) internal pure returns (uint40[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 5, 216);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint48.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint48.
   */
  function decodeArray_uint48(Slice _input) internal pure returns (uint48[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 6, 208);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint56.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint56.
   */
  function decodeArray_uint56(Slice _input) internal pure returns (uint56[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 7, 200);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint64.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint64.
   */
  function decodeArray_uint64(Slice _input) internal pure returns (uint64[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 8, 192);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint72.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint72.
   */
  function decodeArray_uint72(Slice _input) internal pure returns (uint72[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 9, 184);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint80.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint80.
   */
  function decodeArray_uint80(Slice _input) internal pure returns (uint80[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 10, 176);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint88.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint88.
   */
  function decodeArray_uint88(Slice _input) internal pure returns (uint88[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 11, 168);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint96.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint96.
   */
  function decodeArray_uint96(Slice _input) internal pure returns (uint96[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 12, 160);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint104.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint104.
   */
  function decodeArray_uint104(Slice _input) internal pure returns (uint104[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 13, 152);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint112.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint112.
   */
  function decodeArray_uint112(Slice _input) internal pure returns (uint112[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 14, 144);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint120.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint120.
   */
  function decodeArray_uint120(Slice _input) internal pure returns (uint120[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 15, 136);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint128.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint128.
   */
  function decodeArray_uint128(Slice _input) internal pure returns (uint128[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 16, 128);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint136.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint136.
   */
  function decodeArray_uint136(Slice _input) internal pure returns (uint136[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 17, 120);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint144.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint144.
   */
  function decodeArray_uint144(Slice _input) internal pure returns (uint144[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 18, 112);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint152.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint152.
   */
  function decodeArray_uint152(Slice _input) internal pure returns (uint152[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 19, 104);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint160.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint160.
   */
  function decodeArray_uint160(Slice _input) internal pure returns (uint160[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 20, 96);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint168.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint168.
   */
  function decodeArray_uint168(Slice _input) internal pure returns (uint168[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 21, 88);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint176.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint176.
   */
  function decodeArray_uint176(Slice _input) internal pure returns (uint176[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 22, 80);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint184.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint184.
   */
  function decodeArray_uint184(Slice _input) internal pure returns (uint184[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 23, 72);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint192.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint192.
   */
  function decodeArray_uint192(Slice _input) internal pure returns (uint192[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 24, 64);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint200.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint200.
   */
  function decodeArray_uint200(Slice _input) internal pure returns (uint200[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 25, 56);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint208.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint208.
   */
  function decodeArray_uint208(Slice _input) internal pure returns (uint208[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 26, 48);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint216.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint216.
   */
  function decodeArray_uint216(Slice _input) internal pure returns (uint216[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 27, 40);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint224.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint224.
   */
  function decodeArray_uint224(Slice _input) internal pure returns (uint224[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 28, 32);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint232.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint232.
   */
  function decodeArray_uint232(Slice _input) internal pure returns (uint232[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 29, 24);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint240.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint240.
   */
  function decodeArray_uint240(Slice _input) internal pure returns (uint240[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 30, 16);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint248.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint248.
   */
  function decodeArray_uint248(Slice _input) internal pure returns (uint248[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 31, 8);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of uint256.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of uint256.
   */
  function decodeArray_uint256(Slice _input) internal pure returns (uint256[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 32, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int8.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int8.
   */
  function decodeArray_int8(Slice _input) internal pure returns (int8[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 1, 248);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int16.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int16.
   */
  function decodeArray_int16(Slice _input) internal pure returns (int16[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 2, 240);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int24.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int24.
   */
  function decodeArray_int24(Slice _input) internal pure returns (int24[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 3, 232);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int32.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int32.
   */
  function decodeArray_int32(Slice _input) internal pure returns (int32[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 4, 224);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int40.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int40.
   */
  function decodeArray_int40(Slice _input) internal pure returns (int40[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 5, 216);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int48.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int48.
   */
  function decodeArray_int48(Slice _input) internal pure returns (int48[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 6, 208);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int56.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int56.
   */
  function decodeArray_int56(Slice _input) internal pure returns (int56[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 7, 200);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int64.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int64.
   */
  function decodeArray_int64(Slice _input) internal pure returns (int64[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 8, 192);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int72.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int72.
   */
  function decodeArray_int72(Slice _input) internal pure returns (int72[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 9, 184);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int80.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int80.
   */
  function decodeArray_int80(Slice _input) internal pure returns (int80[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 10, 176);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int88.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int88.
   */
  function decodeArray_int88(Slice _input) internal pure returns (int88[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 11, 168);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int96.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int96.
   */
  function decodeArray_int96(Slice _input) internal pure returns (int96[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 12, 160);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int104.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int104.
   */
  function decodeArray_int104(Slice _input) internal pure returns (int104[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 13, 152);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int112.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int112.
   */
  function decodeArray_int112(Slice _input) internal pure returns (int112[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 14, 144);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int120.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int120.
   */
  function decodeArray_int120(Slice _input) internal pure returns (int120[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 15, 136);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int128.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int128.
   */
  function decodeArray_int128(Slice _input) internal pure returns (int128[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 16, 128);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int136.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int136.
   */
  function decodeArray_int136(Slice _input) internal pure returns (int136[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 17, 120);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int144.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int144.
   */
  function decodeArray_int144(Slice _input) internal pure returns (int144[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 18, 112);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int152.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int152.
   */
  function decodeArray_int152(Slice _input) internal pure returns (int152[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 19, 104);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int160.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int160.
   */
  function decodeArray_int160(Slice _input) internal pure returns (int160[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 20, 96);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int168.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int168.
   */
  function decodeArray_int168(Slice _input) internal pure returns (int168[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 21, 88);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int176.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int176.
   */
  function decodeArray_int176(Slice _input) internal pure returns (int176[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 22, 80);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int184.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int184.
   */
  function decodeArray_int184(Slice _input) internal pure returns (int184[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 23, 72);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int192.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int192.
   */
  function decodeArray_int192(Slice _input) internal pure returns (int192[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 24, 64);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int200.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int200.
   */
  function decodeArray_int200(Slice _input) internal pure returns (int200[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 25, 56);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int208.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int208.
   */
  function decodeArray_int208(Slice _input) internal pure returns (int208[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 26, 48);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int216.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int216.
   */
  function decodeArray_int216(Slice _input) internal pure returns (int216[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 27, 40);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int224.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int224.
   */
  function decodeArray_int224(Slice _input) internal pure returns (int224[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 28, 32);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int232.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int232.
   */
  function decodeArray_int232(Slice _input) internal pure returns (int232[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 29, 24);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int240.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int240.
   */
  function decodeArray_int240(Slice _input) internal pure returns (int240[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 30, 16);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int248.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int248.
   */
  function decodeArray_int248(Slice _input) internal pure returns (int248[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 31, 8);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of int256.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of int256.
   */
  function decodeArray_int256(Slice _input) internal pure returns (int256[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 32, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes1.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes1.
   */
  function decodeArray_bytes1(Slice _input) internal pure returns (bytes1[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 1, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes2.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes2.
   */
  function decodeArray_bytes2(Slice _input) internal pure returns (bytes2[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 2, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes3.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes3.
   */
  function decodeArray_bytes3(Slice _input) internal pure returns (bytes3[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 3, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes4.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes4.
   */
  function decodeArray_bytes4(Slice _input) internal pure returns (bytes4[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 4, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes5.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes5.
   */
  function decodeArray_bytes5(Slice _input) internal pure returns (bytes5[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 5, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes6.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes6.
   */
  function decodeArray_bytes6(Slice _input) internal pure returns (bytes6[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 6, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes7.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes7.
   */
  function decodeArray_bytes7(Slice _input) internal pure returns (bytes7[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 7, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes8.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes8.
   */
  function decodeArray_bytes8(Slice _input) internal pure returns (bytes8[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 8, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes9.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes9.
   */
  function decodeArray_bytes9(Slice _input) internal pure returns (bytes9[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 9, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes10.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes10.
   */
  function decodeArray_bytes10(Slice _input) internal pure returns (bytes10[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 10, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes11.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes11.
   */
  function decodeArray_bytes11(Slice _input) internal pure returns (bytes11[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 11, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes12.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes12.
   */
  function decodeArray_bytes12(Slice _input) internal pure returns (bytes12[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 12, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes13.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes13.
   */
  function decodeArray_bytes13(Slice _input) internal pure returns (bytes13[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 13, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes14.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes14.
   */
  function decodeArray_bytes14(Slice _input) internal pure returns (bytes14[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 14, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes15.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes15.
   */
  function decodeArray_bytes15(Slice _input) internal pure returns (bytes15[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 15, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes16.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes16.
   */
  function decodeArray_bytes16(Slice _input) internal pure returns (bytes16[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 16, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes17.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes17.
   */
  function decodeArray_bytes17(Slice _input) internal pure returns (bytes17[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 17, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes18.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes18.
   */
  function decodeArray_bytes18(Slice _input) internal pure returns (bytes18[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 18, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes19.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes19.
   */
  function decodeArray_bytes19(Slice _input) internal pure returns (bytes19[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 19, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes20.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes20.
   */
  function decodeArray_bytes20(Slice _input) internal pure returns (bytes20[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 20, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes21.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes21.
   */
  function decodeArray_bytes21(Slice _input) internal pure returns (bytes21[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 21, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes22.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes22.
   */
  function decodeArray_bytes22(Slice _input) internal pure returns (bytes22[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 22, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes23.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes23.
   */
  function decodeArray_bytes23(Slice _input) internal pure returns (bytes23[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 23, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes24.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes24.
   */
  function decodeArray_bytes24(Slice _input) internal pure returns (bytes24[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 24, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes25.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes25.
   */
  function decodeArray_bytes25(Slice _input) internal pure returns (bytes25[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 25, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes26.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes26.
   */
  function decodeArray_bytes26(Slice _input) internal pure returns (bytes26[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 26, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes27.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes27.
   */
  function decodeArray_bytes27(Slice _input) internal pure returns (bytes27[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 27, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes28.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes28.
   */
  function decodeArray_bytes28(Slice _input) internal pure returns (bytes28[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 28, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes29.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes29.
   */
  function decodeArray_bytes29(Slice _input) internal pure returns (bytes29[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 29, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes30.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes30.
   */
  function decodeArray_bytes30(Slice _input) internal pure returns (bytes30[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 30, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes31.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes31.
   */
  function decodeArray_bytes31(Slice _input) internal pure returns (bytes31[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 31, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bytes32.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bytes32.
   */
  function decodeArray_bytes32(Slice _input) internal pure returns (bytes32[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 32, 0);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of bool.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of bool.
   */
  function decodeArray_bool(Slice _input) internal pure returns (bool[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 1, 248);
    assembly {
      _output := _genericArray
    }
  }

  /**
   * @notice Decodes a slice into an array of address.
   * @dev Uses TightCoder for initial decoding, and then assembly for memory conversion.
   * @param _input The slice to decode.
   * @return _output The decoded array of address.
   */
  function decodeArray_address(Slice _input) internal pure returns (address[] memory _output) {
    bytes32[] memory _genericArray = TightCoder.decode(_input, 20, 96);
    assembly {
      _output := _genericArray
    }
  }
}

// node_modules/@latticexyz/store/src/tightcoder/TightCoder.sol

/**
 * @title TightCoder
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Provides low-level generic implementations of tight encoding and decoding for arrays.
 * This is consistent with Solidity's internal tight encoding for array data in storage.
 */
library TightCoder {
  /**
   * @dev Copies the array to a new bytes array, tightly packing its elements.
   * @param array The array to encode.
   * @param elementSize The size of each element in bytes.
   * @param leftPaddingBits The amount to shift each element to the left.
   * @return data A tightly packed byte array.
   * @notice elementSize and leftPaddingBits must be correctly provided by the caller based on the array's element type.
   */
  function encode(
    bytes32[] memory array,
    uint256 elementSize,
    uint256 leftPaddingBits
  ) internal pure returns (bytes memory data) {
    uint256 arrayLength = array.length;
    uint256 packedLength = array.length * elementSize;

    // Manual memory allocation is cheaper and removes the issue of memory corruption at the tail
    /// @solidity memory-safe-assembly
    assembly {
      // Solidity's YulUtilFunctions::roundUpFunction
      function round_up_to_mul_of_32(value) -> _result {
        _result := and(add(value, 0x1F), not(0x1F))
      }

      // Allocate memory
      data := mload(0x40)
      let packedPointer := add(data, 0x20)
      mstore(0x40, round_up_to_mul_of_32(add(packedPointer, packedLength)))
      // Store length
      mstore(data, packedLength)

      for {
        let i := 0
        // Skip array length
        let arrayPointer := add(array, 0x20)
      } lt(i, arrayLength) {
        // Loop until we reach the end of the array
        i := add(i, 1)
        // Increment array pointer by one word
        arrayPointer := add(arrayPointer, 0x20)
        // Increment packed pointer by one element size
        packedPointer := add(packedPointer, elementSize)
      } {
        // Pack one array element
        mstore(packedPointer, shl(leftPaddingBits, mload(arrayPointer)))
      }
    }
  }

  /**
   * @notice Decodes a tightly packed byte slice into a bytes32 array.
   * @param packedSlice The tightly packed data to be decoded.
   * @param elementSize The size of each element in bytes.
   * @param leftPaddingBits The number of padding bits on the left side of each element.
   * @dev elementSize and leftPaddingBits must be correctly provided based on the desired output array's element type.
   * @return array The resulting array of bytes32 elements from decoding the packed slice.
   */
  function decode(
    Slice packedSlice,
    uint256 elementSize,
    uint256 leftPaddingBits
  ) internal pure returns (bytes32[] memory array) {
    uint256 packedPointer = packedSlice.pointer();
    uint256 packedLength = packedSlice.length();
    // Array length (number of elements)
    uint256 arrayLength;
    unchecked {
      arrayLength = packedLength / elementSize;
    }

    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      array := mload(0x40)
      let arrayPointer := add(array, 0x20)
      mstore(0x40, add(arrayPointer, mul(arrayLength, 0x20)))
      // Store length
      mstore(array, arrayLength)

      for {
        let i := 0
      } lt(i, arrayLength) {
        // Loop until we reach the end of the array
        i := add(i, 1)
        // Increment array pointer by one word
        arrayPointer := add(arrayPointer, 0x20)
        // Increment packed pointer by one element size
        packedPointer := add(packedPointer, elementSize)
      } {
        // Unpack one array element
        mstore(arrayPointer, shr(leftPaddingBits, mload(packedPointer)))
      }
    }
  }
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IAccessManagementSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IAccessManagementSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IAccessManagementSystem {
  function grantAccess(ResourceId resourceId, address grantee) external;

  function revokeAccess(ResourceId resourceId, address grantee) external;

  function transferOwnership(ResourceId namespaceId, address newOwner) external;

  function renounceOwnership(ResourceId namespaceId) external;
}

// node_modules/@latticexyz/store/src/IStoreHook.sol

/**
 * @title IStoreHook
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
interface IStoreHook is IERC165_0 {
  /// @notice Error emitted when a function is not implemented.
  error StoreHook_NotImplemented();

  /**
   * @notice Called before setting a record in the store.
   * @param tableId The ID of the table where the record is to be set.
   * @param keyTuple An array representing the composite key for the record.
   * @param staticData The static data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param dynamicData The dynamic data of the record.
   * @param fieldLayout The layout of the field, see FieldLayout.sol.
   */
  function onBeforeSetRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    bytes memory staticData,
    EncodedLengths encodedLengths,
    bytes memory dynamicData,
    FieldLayout fieldLayout
  ) external;

  /**
   * @notice Called after setting a record in the store.
   * @param tableId The ID of the table where the record was set.
   * @param keyTuple An array representing the composite key for the record.
   * @param staticData The static data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param dynamicData The dynamic data of the record.
   * @param fieldLayout The layout of the field, see FieldLayout.sol.
   */
  function onAfterSetRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    bytes memory staticData,
    EncodedLengths encodedLengths,
    bytes memory dynamicData,
    FieldLayout fieldLayout
  ) external;

  /**
   * @notice Called before splicing static data in the store.
   * @dev Splice operations in static data always overwrite data starting at the start position,
   * so the total length of the data remains the same and no data is shifted.
   * @param tableId The ID of the table where the data is to be spliced.
   * @param keyTuple An array representing the composite key for the record.
   * @param start The start byte position for splicing.
   * @param data The data to be written to the static data of the record at the start byte.
   */
  function onBeforeSpliceStaticData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint48 start,
    bytes memory data
  ) external;

  /**
   * @notice Called after splicing static data in the store.
   * @dev Splice operations in static data always overwrite data starting at the start position,
   * so the total length of the data remains the same and no data is shifted.
   * @param tableId The ID of the table where the data was spliced.
   * @param keyTuple An array representing the composite key for the record.
   * @param start The start byte position for splicing.
   * @param data The data written to the static data of the record at the start byte.
   */
  function onAfterSpliceStaticData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint48 start,
    bytes memory data
  ) external;

  /**
   * @notice Called before splicing dynamic data in the store.
   * @dev Splice operations in dynamic data always reach the end of the dynamic data
   * to avoid shifting data after the inserted or deleted data.
   * @param tableId The ID of the table where the data is to be spliced.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field.
   * @param startWithinField The start byte position within the field for splicing.
   * @param deleteCount The number of bytes to delete in the dynamic data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param data The data to be inserted into the dynamic data of the record at the start byte.
   */
  function onBeforeSpliceDynamicData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    EncodedLengths encodedLengths,
    bytes memory data
  ) external;

  /**
   * @notice Called after splicing dynamic data in the store.
   * @dev Splice operations in dynamic data always reach the end of the dynamic data
   * to avoid shifting data after the inserted or deleted data.
   * @param tableId The ID of the table where the data was spliced.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field.
   * @param startWithinField The start byte position within the field for splicing.
   * @param deleteCount The number of bytes deleted in the dynamic data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param data The data inserted into the dynamic data of the record at the start byte.
   */
  function onAfterSpliceDynamicData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    EncodedLengths encodedLengths,
    bytes memory data
  ) external;

  /**
   * @notice Called before deleting a record from the store.
   * @param tableId The ID of the table where the record is to be deleted.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldLayout The layout of the field, see FieldLayout.sol.
   */
  function onBeforeDeleteRecord(ResourceId tableId, bytes32[] memory keyTuple, FieldLayout fieldLayout) external;

  /**
   * @notice Called after deleting a record from the store.
   * @param tableId The ID of the table where the record was deleted.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldLayout The layout of the field, see FieldLayout.sol.
   */
  function onAfterDeleteRecord(ResourceId tableId, bytes32[] memory keyTuple, FieldLayout fieldLayout) external;
}

// node_modules/@latticexyz/store/src/IStoreWrite.sol

/**
 * @title IStoreWrite
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
interface IStoreWrite is IStoreEvents {
  // Set full record (including full dynamic data)
  function setRecord(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    bytes calldata staticData,
    EncodedLengths encodedLengths,
    bytes calldata dynamicData
  ) external;

  // Splice data in the static part of the record
  function spliceStaticData(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint48 start,
    bytes calldata data
  ) external;

  // Splice data in the dynamic part of the record
  function spliceDynamicData(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    bytes calldata data
  ) external;

  // Set partial data at field index
  function setField(ResourceId tableId, bytes32[] calldata keyTuple, uint8 fieldIndex, bytes calldata data) external;

  // Set partial data at field index
  function setField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 fieldIndex,
    bytes calldata data,
    FieldLayout fieldLayout
  ) external;

  function setStaticField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 fieldIndex,
    bytes calldata data,
    FieldLayout fieldLayout
  ) external;

  function setDynamicField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 dynamicFieldIndex,
    bytes calldata data
  ) external;

  // Push encoded items to the dynamic field at field index
  function pushToDynamicField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 dynamicFieldIndex,
    bytes calldata dataToPush
  ) external;

  // Pop byte length from the dynamic field at field index
  function popFromDynamicField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 dynamicFieldIndex,
    uint256 byteLengthToPop
  ) external;

  // Set full record (including full dynamic data)
  function deleteRecord(ResourceId tableId, bytes32[] memory keyTuple) external;
}

// node_modules/@latticexyz/store/src/tightcoder/EncodeArray.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title EncodeArray
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This library provides utilities for encoding arrays into tightly packed bytes representations.
 */
library EncodeArray {
  /**
   * @notice Encodes an array of uint8 into a tightly packed bytes representation.
   * @param _input The array of uint8 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint8[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 1, 248);
  }

  /**
   * @notice Encodes an array of uint16 into a tightly packed bytes representation.
   * @param _input The array of uint16 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint16[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 2, 240);
  }

  /**
   * @notice Encodes an array of uint24 into a tightly packed bytes representation.
   * @param _input The array of uint24 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint24[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 3, 232);
  }

  /**
   * @notice Encodes an array of uint32 into a tightly packed bytes representation.
   * @param _input The array of uint32 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint32[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 4, 224);
  }

  /**
   * @notice Encodes an array of uint40 into a tightly packed bytes representation.
   * @param _input The array of uint40 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint40[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 5, 216);
  }

  /**
   * @notice Encodes an array of uint48 into a tightly packed bytes representation.
   * @param _input The array of uint48 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint48[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 6, 208);
  }

  /**
   * @notice Encodes an array of uint56 into a tightly packed bytes representation.
   * @param _input The array of uint56 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint56[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 7, 200);
  }

  /**
   * @notice Encodes an array of uint64 into a tightly packed bytes representation.
   * @param _input The array of uint64 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint64[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 8, 192);
  }

  /**
   * @notice Encodes an array of uint72 into a tightly packed bytes representation.
   * @param _input The array of uint72 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint72[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 9, 184);
  }

  /**
   * @notice Encodes an array of uint80 into a tightly packed bytes representation.
   * @param _input The array of uint80 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint80[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 10, 176);
  }

  /**
   * @notice Encodes an array of uint88 into a tightly packed bytes representation.
   * @param _input The array of uint88 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint88[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 11, 168);
  }

  /**
   * @notice Encodes an array of uint96 into a tightly packed bytes representation.
   * @param _input The array of uint96 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint96[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 12, 160);
  }

  /**
   * @notice Encodes an array of uint104 into a tightly packed bytes representation.
   * @param _input The array of uint104 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint104[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 13, 152);
  }

  /**
   * @notice Encodes an array of uint112 into a tightly packed bytes representation.
   * @param _input The array of uint112 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint112[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 14, 144);
  }

  /**
   * @notice Encodes an array of uint120 into a tightly packed bytes representation.
   * @param _input The array of uint120 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint120[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 15, 136);
  }

  /**
   * @notice Encodes an array of uint128 into a tightly packed bytes representation.
   * @param _input The array of uint128 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint128[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 16, 128);
  }

  /**
   * @notice Encodes an array of uint136 into a tightly packed bytes representation.
   * @param _input The array of uint136 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint136[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 17, 120);
  }

  /**
   * @notice Encodes an array of uint144 into a tightly packed bytes representation.
   * @param _input The array of uint144 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint144[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 18, 112);
  }

  /**
   * @notice Encodes an array of uint152 into a tightly packed bytes representation.
   * @param _input The array of uint152 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint152[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 19, 104);
  }

  /**
   * @notice Encodes an array of uint160 into a tightly packed bytes representation.
   * @param _input The array of uint160 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint160[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 20, 96);
  }

  /**
   * @notice Encodes an array of uint168 into a tightly packed bytes representation.
   * @param _input The array of uint168 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint168[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 21, 88);
  }

  /**
   * @notice Encodes an array of uint176 into a tightly packed bytes representation.
   * @param _input The array of uint176 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint176[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 22, 80);
  }

  /**
   * @notice Encodes an array of uint184 into a tightly packed bytes representation.
   * @param _input The array of uint184 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint184[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 23, 72);
  }

  /**
   * @notice Encodes an array of uint192 into a tightly packed bytes representation.
   * @param _input The array of uint192 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint192[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 24, 64);
  }

  /**
   * @notice Encodes an array of uint200 into a tightly packed bytes representation.
   * @param _input The array of uint200 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint200[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 25, 56);
  }

  /**
   * @notice Encodes an array of uint208 into a tightly packed bytes representation.
   * @param _input The array of uint208 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint208[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 26, 48);
  }

  /**
   * @notice Encodes an array of uint216 into a tightly packed bytes representation.
   * @param _input The array of uint216 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint216[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 27, 40);
  }

  /**
   * @notice Encodes an array of uint224 into a tightly packed bytes representation.
   * @param _input The array of uint224 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint224[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 28, 32);
  }

  /**
   * @notice Encodes an array of uint232 into a tightly packed bytes representation.
   * @param _input The array of uint232 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint232[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 29, 24);
  }

  /**
   * @notice Encodes an array of uint240 into a tightly packed bytes representation.
   * @param _input The array of uint240 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint240[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 30, 16);
  }

  /**
   * @notice Encodes an array of uint248 into a tightly packed bytes representation.
   * @param _input The array of uint248 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint248[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 31, 8);
  }

  /**
   * @notice Encodes an array of uint256 into a tightly packed bytes representation.
   * @param _input The array of uint256 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(uint256[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 32, 0);
  }

  /**
   * @notice Encodes an array of int8 into a tightly packed bytes representation.
   * @param _input The array of int8 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int8[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 1, 248);
  }

  /**
   * @notice Encodes an array of int16 into a tightly packed bytes representation.
   * @param _input The array of int16 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int16[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 2, 240);
  }

  /**
   * @notice Encodes an array of int24 into a tightly packed bytes representation.
   * @param _input The array of int24 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int24[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 3, 232);
  }

  /**
   * @notice Encodes an array of int32 into a tightly packed bytes representation.
   * @param _input The array of int32 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int32[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 4, 224);
  }

  /**
   * @notice Encodes an array of int40 into a tightly packed bytes representation.
   * @param _input The array of int40 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int40[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 5, 216);
  }

  /**
   * @notice Encodes an array of int48 into a tightly packed bytes representation.
   * @param _input The array of int48 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int48[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 6, 208);
  }

  /**
   * @notice Encodes an array of int56 into a tightly packed bytes representation.
   * @param _input The array of int56 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int56[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 7, 200);
  }

  /**
   * @notice Encodes an array of int64 into a tightly packed bytes representation.
   * @param _input The array of int64 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int64[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 8, 192);
  }

  /**
   * @notice Encodes an array of int72 into a tightly packed bytes representation.
   * @param _input The array of int72 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int72[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 9, 184);
  }

  /**
   * @notice Encodes an array of int80 into a tightly packed bytes representation.
   * @param _input The array of int80 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int80[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 10, 176);
  }

  /**
   * @notice Encodes an array of int88 into a tightly packed bytes representation.
   * @param _input The array of int88 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int88[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 11, 168);
  }

  /**
   * @notice Encodes an array of int96 into a tightly packed bytes representation.
   * @param _input The array of int96 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int96[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 12, 160);
  }

  /**
   * @notice Encodes an array of int104 into a tightly packed bytes representation.
   * @param _input The array of int104 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int104[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 13, 152);
  }

  /**
   * @notice Encodes an array of int112 into a tightly packed bytes representation.
   * @param _input The array of int112 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int112[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 14, 144);
  }

  /**
   * @notice Encodes an array of int120 into a tightly packed bytes representation.
   * @param _input The array of int120 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int120[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 15, 136);
  }

  /**
   * @notice Encodes an array of int128 into a tightly packed bytes representation.
   * @param _input The array of int128 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int128[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 16, 128);
  }

  /**
   * @notice Encodes an array of int136 into a tightly packed bytes representation.
   * @param _input The array of int136 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int136[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 17, 120);
  }

  /**
   * @notice Encodes an array of int144 into a tightly packed bytes representation.
   * @param _input The array of int144 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int144[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 18, 112);
  }

  /**
   * @notice Encodes an array of int152 into a tightly packed bytes representation.
   * @param _input The array of int152 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int152[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 19, 104);
  }

  /**
   * @notice Encodes an array of int160 into a tightly packed bytes representation.
   * @param _input The array of int160 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int160[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 20, 96);
  }

  /**
   * @notice Encodes an array of int168 into a tightly packed bytes representation.
   * @param _input The array of int168 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int168[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 21, 88);
  }

  /**
   * @notice Encodes an array of int176 into a tightly packed bytes representation.
   * @param _input The array of int176 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int176[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 22, 80);
  }

  /**
   * @notice Encodes an array of int184 into a tightly packed bytes representation.
   * @param _input The array of int184 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int184[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 23, 72);
  }

  /**
   * @notice Encodes an array of int192 into a tightly packed bytes representation.
   * @param _input The array of int192 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int192[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 24, 64);
  }

  /**
   * @notice Encodes an array of int200 into a tightly packed bytes representation.
   * @param _input The array of int200 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int200[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 25, 56);
  }

  /**
   * @notice Encodes an array of int208 into a tightly packed bytes representation.
   * @param _input The array of int208 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int208[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 26, 48);
  }

  /**
   * @notice Encodes an array of int216 into a tightly packed bytes representation.
   * @param _input The array of int216 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int216[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 27, 40);
  }

  /**
   * @notice Encodes an array of int224 into a tightly packed bytes representation.
   * @param _input The array of int224 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int224[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 28, 32);
  }

  /**
   * @notice Encodes an array of int232 into a tightly packed bytes representation.
   * @param _input The array of int232 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int232[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 29, 24);
  }

  /**
   * @notice Encodes an array of int240 into a tightly packed bytes representation.
   * @param _input The array of int240 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int240[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 30, 16);
  }

  /**
   * @notice Encodes an array of int248 into a tightly packed bytes representation.
   * @param _input The array of int248 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int248[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 31, 8);
  }

  /**
   * @notice Encodes an array of int256 into a tightly packed bytes representation.
   * @param _input The array of int256 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(int256[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 32, 0);
  }

  /**
   * @notice Encodes an array of bytes1 into a tightly packed bytes representation.
   * @param _input The array of bytes1 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes1[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 1, 0);
  }

  /**
   * @notice Encodes an array of bytes2 into a tightly packed bytes representation.
   * @param _input The array of bytes2 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes2[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 2, 0);
  }

  /**
   * @notice Encodes an array of bytes3 into a tightly packed bytes representation.
   * @param _input The array of bytes3 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes3[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 3, 0);
  }

  /**
   * @notice Encodes an array of bytes4 into a tightly packed bytes representation.
   * @param _input The array of bytes4 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes4[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 4, 0);
  }

  /**
   * @notice Encodes an array of bytes5 into a tightly packed bytes representation.
   * @param _input The array of bytes5 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes5[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 5, 0);
  }

  /**
   * @notice Encodes an array of bytes6 into a tightly packed bytes representation.
   * @param _input The array of bytes6 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes6[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 6, 0);
  }

  /**
   * @notice Encodes an array of bytes7 into a tightly packed bytes representation.
   * @param _input The array of bytes7 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes7[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 7, 0);
  }

  /**
   * @notice Encodes an array of bytes8 into a tightly packed bytes representation.
   * @param _input The array of bytes8 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes8[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 8, 0);
  }

  /**
   * @notice Encodes an array of bytes9 into a tightly packed bytes representation.
   * @param _input The array of bytes9 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes9[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 9, 0);
  }

  /**
   * @notice Encodes an array of bytes10 into a tightly packed bytes representation.
   * @param _input The array of bytes10 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes10[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 10, 0);
  }

  /**
   * @notice Encodes an array of bytes11 into a tightly packed bytes representation.
   * @param _input The array of bytes11 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes11[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 11, 0);
  }

  /**
   * @notice Encodes an array of bytes12 into a tightly packed bytes representation.
   * @param _input The array of bytes12 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes12[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 12, 0);
  }

  /**
   * @notice Encodes an array of bytes13 into a tightly packed bytes representation.
   * @param _input The array of bytes13 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes13[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 13, 0);
  }

  /**
   * @notice Encodes an array of bytes14 into a tightly packed bytes representation.
   * @param _input The array of bytes14 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes14[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 14, 0);
  }

  /**
   * @notice Encodes an array of bytes15 into a tightly packed bytes representation.
   * @param _input The array of bytes15 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes15[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 15, 0);
  }

  /**
   * @notice Encodes an array of bytes16 into a tightly packed bytes representation.
   * @param _input The array of bytes16 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes16[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 16, 0);
  }

  /**
   * @notice Encodes an array of bytes17 into a tightly packed bytes representation.
   * @param _input The array of bytes17 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes17[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 17, 0);
  }

  /**
   * @notice Encodes an array of bytes18 into a tightly packed bytes representation.
   * @param _input The array of bytes18 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes18[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 18, 0);
  }

  /**
   * @notice Encodes an array of bytes19 into a tightly packed bytes representation.
   * @param _input The array of bytes19 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes19[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 19, 0);
  }

  /**
   * @notice Encodes an array of bytes20 into a tightly packed bytes representation.
   * @param _input The array of bytes20 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes20[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 20, 0);
  }

  /**
   * @notice Encodes an array of bytes21 into a tightly packed bytes representation.
   * @param _input The array of bytes21 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes21[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 21, 0);
  }

  /**
   * @notice Encodes an array of bytes22 into a tightly packed bytes representation.
   * @param _input The array of bytes22 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes22[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 22, 0);
  }

  /**
   * @notice Encodes an array of bytes23 into a tightly packed bytes representation.
   * @param _input The array of bytes23 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes23[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 23, 0);
  }

  /**
   * @notice Encodes an array of bytes24 into a tightly packed bytes representation.
   * @param _input The array of bytes24 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes24[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 24, 0);
  }

  /**
   * @notice Encodes an array of bytes25 into a tightly packed bytes representation.
   * @param _input The array of bytes25 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes25[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 25, 0);
  }

  /**
   * @notice Encodes an array of bytes26 into a tightly packed bytes representation.
   * @param _input The array of bytes26 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes26[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 26, 0);
  }

  /**
   * @notice Encodes an array of bytes27 into a tightly packed bytes representation.
   * @param _input The array of bytes27 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes27[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 27, 0);
  }

  /**
   * @notice Encodes an array of bytes28 into a tightly packed bytes representation.
   * @param _input The array of bytes28 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes28[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 28, 0);
  }

  /**
   * @notice Encodes an array of bytes29 into a tightly packed bytes representation.
   * @param _input The array of bytes29 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes29[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 29, 0);
  }

  /**
   * @notice Encodes an array of bytes30 into a tightly packed bytes representation.
   * @param _input The array of bytes30 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes30[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 30, 0);
  }

  /**
   * @notice Encodes an array of bytes31 into a tightly packed bytes representation.
   * @param _input The array of bytes31 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes31[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 31, 0);
  }

  /**
   * @notice Encodes an array of bytes32 into a tightly packed bytes representation.
   * @param _input The array of bytes32 values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bytes32[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 32, 0);
  }

  /**
   * @notice Encodes an array of bool into a tightly packed bytes representation.
   * @param _input The array of bool values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(bool[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 1, 248);
  }

  /**
   * @notice Encodes an array of address into a tightly packed bytes representation.
   * @param _input The array of address values to be encoded.
   * @return The resulting tightly packed bytes representation of the input array.
   */
  function encode(address[] memory _input) internal pure returns (bytes memory) {
    bytes32[] memory _genericArray;
    assembly {
      _genericArray := _input
    }
    return TightCoder.encode(_genericArray, 20, 96);
  }
}

// node_modules/@latticexyz/world/src/ISystemHook.sol

/**
 * @title ISystemHook
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Interface defining system hooks for external functionality.
 * Provides pre and post hooks that can be triggered before and after a system call respectively.
 * This interface adheres to the ERC-165 standard for determining interface support.
 */
interface ISystemHook is IERC165_1 {
  /**
   * @notice Executes before a system call.
   * @dev Provides the ability to add custom logic or checks before a system is invoked.
   * @param msgSender The original sender of the system call.
   * @param systemId The identifier for the system being called.
   * @param callData Data being sent as part of the system call.
   */
  function onBeforeCallSystem(address msgSender, ResourceId systemId, bytes memory callData) external;

  /**
   * @notice Executes after a system call.
   * @dev Provides the ability to add custom logic or checks after a system call completes.
   * @param msgSender The original sender of the system call.
   * @param systemId The identifier for the system that was called.
   * @param callData Data that was sent as part of the system call.
   */
  function onAfterCallSystem(address msgSender, ResourceId systemId, bytes memory callData) external;
}

// node_modules/@latticexyz/store/src/IStoreRead.sol

/**
 * @title IStoreRead
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
interface IStoreRead {
  function getFieldLayout(ResourceId tableId) external view returns (FieldLayout fieldLayout);

  function getValueSchema(ResourceId tableId) external view returns (Schema valueSchema);

  function getKeySchema(ResourceId tableId) external view returns (Schema keySchema);

  /**
   * Get full record (all fields, static and dynamic data) for the given tableId and key tuple, loading the field layout from storage
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] calldata keyTuple
  ) external view returns (bytes memory staticData, EncodedLengths encodedLengths, bytes memory dynamicData);

  /**
   * Get full record (all fields, static and dynamic data) for the given tableId and key tuple, with the given field layout
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    FieldLayout fieldLayout
  ) external view returns (bytes memory staticData, EncodedLengths encodedLengths, bytes memory dynamicData);

  /**
   * Get a single field from the given tableId and key tuple, loading the field layout from storage
   */
  function getField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 fieldIndex
  ) external view returns (bytes memory data);

  /**
   * Get a single field from the given tableId and key tuple, with the given field layout
   */
  function getField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) external view returns (bytes memory data);

  /**
   * Get a single static field from the given tableId and key tuple, with the given value field layout.
   * Note: the field value is left-aligned in the returned bytes32, the rest of the word is not zeroed out.
   * Consumers are expected to truncate the returned value as needed.
   */
  function getStaticField(
    ResourceId tableId,
    bytes32[] calldata keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) external view returns (bytes32);

  /**
   * Get a single dynamic field from the given tableId and key tuple at the given dynamic field index.
   * (Dynamic field index = field index - number of static fields)
   */
  function getDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) external view returns (bytes memory);

  /**
   * Get the byte length of a single field from the given tableId and key tuple, loading the field layout from storage
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex
  ) external view returns (uint256);

  /**
   * Get the byte length of a single field from the given tableId and key tuple, with the given value field layout
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) external view returns (uint256);

  /**
   * Get the byte length of a single dynamic field from the given tableId and key tuple
   */
  function getDynamicFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) external view returns (uint256);

  /**
   * Get a byte slice (including start, excluding end) of a single dynamic field from the given tableId and key tuple, with the given value field layout.
   * The slice is unchecked and will return invalid data if `start`:`end` overflow.
   */
  function getDynamicFieldSlice(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint256 start,
    uint256 end
  ) external view returns (bytes memory data);
}

// node_modules/@latticexyz/world/src/IWorldEvents.sol

/**
 * @title IWorldEvents
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev We bundle these events in an interface (instead of at the file-level or in their corresponding library) so they can be inherited by IWorldKernel.
 * This ensures that all events are included in the IWorldKernel ABI for proper decoding in the frontend.
 */
interface IWorldEvents {
  /**
   * @notice Emitted when the World is created.
   * @param worldVersion The protocol version of the World.
   */
  event HelloWorld(bytes32 indexed worldVersion);
}

// node_modules/@latticexyz/store/src/IStoreRegistration.sol

/**
 * @title IStoreRegistration
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface includes methods for managing table field layouts, metadata, and hooks, which are usually called once in the setup phase of an application, making them less performance critical than the methods.
 */
interface IStoreRegistration {
  function registerTable(
    ResourceId tableId,
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    string[] calldata keyNames,
    string[] calldata fieldNames
  ) external;

  // Register hook to be called when a record or field is set or deleted
  function registerStoreHook(ResourceId tableId, IStoreHook hookAddress, uint8 enabledHooksBitmap) external;

  // Unregister a hook for the given tableId
  function unregisterStoreHook(ResourceId tableId, IStoreHook hookAddress) external;
}

// node_modules/@latticexyz/world/src/IWorldKernel.sol

/**
 * @title World Module Installation Interface
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface defines the contract responsible for managing root modules installation.
 */
interface IWorldModuleInstallation {
  /**
   * @notice Install the given root module in the World.
   * @dev Requires the caller to own the root namespace. The module is delegatecalled and installed in the root namespace.
   * @param module The module to be installed.
   * @param encodedArgs The ABI encoded arguments for the module installation.
   */
  function installRootModule(IModule module, bytes memory encodedArgs) external;
}

/**
 * @title World Call Interface
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface defines the contract for executing calls on the World's systems.
 */
interface IWorldCall {
  /**
   * @notice Call the system at the given system ID.
   * @dev If the system is not public, the caller must have access to the namespace or name (encoded in the system ID).
   * @param systemId The ID of the system to be called.
   * @param callData The data to pass with the call,
   * function selector (4 bytes) followed by the ABI encoded parameters.
   * @return The abi encoded return data from the called system.
   */
  function call(ResourceId systemId, bytes memory callData) external payable returns (bytes memory);

  /**
   * @notice Call the system at the given system ID on behalf of the given delegator.
   * @dev If the system is not public, the delegator must have access to the namespace or name (encoded in the system ID).
   * @param delegator The address on whose behalf the call is made.
   * @param systemId The ID of the system to be called.
   * @param callData The data to pass with the call,
   * function selector (4 bytes) followed by the ABI encoded parameters.
   * @return The abi encoded return data from the called system.
   */
  function callFrom(
    address delegator,
    ResourceId systemId,
    bytes memory callData
  ) external payable returns (bytes memory);
}

/**
 * @title World Kernel Interface
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice The IWorldKernel interface includes all methods that are part of the World contract's
 * internal bytecode. Consumers should use the `IBaseWorld` interface instead, which includes dynamically
 * registered functions selectors from the `InitModule`.
 * @dev The IWorldKernel interface inherits IModuleErrors because the world can be delegatecalled with module code,
 * so it's ABI should include these errors.
 */
interface IWorldKernel is IWorldModuleInstallation, IWorldCall, IWorldErrors, IWorldEvents, IModuleErrors {
  /**
   * @notice Retrieve the protocol version of the World.
   * @return The protocol version of the World.
   */
  function worldVersion() external view returns (bytes32);

  /**
   * @notice Retrieve the immutable original deployer of the World.
   * @return The address of the World's creator.
   */
  function creator() external view returns (address);

  /**
   * @notice Initializes the World.
   * @dev Can only be called once by the creator.
   * @param initModule The InitModule to be installed during initialization.
   */
  function initialize(IModule initModule) external;
}

// node_modules/@latticexyz/store/src/IStoreKernel.sol

/**
 * @title IStoreKernel
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice IStoreKernel includes the error interfaces for each library that it uses.
 */
interface IStoreKernel is
  IStoreRead,
  IStoreWrite,
  IStoreErrors,
  IFieldLayoutErrors,
  IEncodedLengthsErrors,
  ISchemaErrors,
  ISliceErrors
{
  /**
   * @notice Returns the protocol version of the Store contract.
   * @return version The protocol version of the Store contract.
   */
  function storeVersion() external view returns (bytes32 version);
}

// node_modules/@latticexyz/store/src/IStore.sol

/**
 * @title IStore
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 */
interface IStore is IStoreKernel, IStoreRegistration {}

// node_modules/@latticexyz/store/src/Hook.sol

// 20 bytes address, 1 byte bitmap of enabled hooks
type Hook is bytes21;

using HookInstance for Hook global;

/**
 * @title HookLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Library for encoding hooks and filtering hooks from a list by address.
 */
library HookLib {
  /**
   * @notice Packs the bitmap of enabled hooks with the hook address into a Hook value (bytes21).
   * @dev The hook address is stored in the leftmost 20 bytes, and the bitmap is stored in the rightmost byte.
   * @param hookAddress The address of the hook.
   * @param encodedHooks The encoded hooks in a bitmap.
   * @return A Hook type with packed hook address and bitmap.
   */
  function encode(address hookAddress, uint8 encodedHooks) internal pure returns (Hook) {
    // Move the address to the leftmost 20 bytes and the bitmap to the rightmost byte
    return Hook.wrap(bytes21(bytes20(hookAddress)) | bytes21(uint168(encodedHooks)));
  }

  /**
   * @notice Filter a hook from the hook list by its address.
   * @dev This function writes the updated hook list to the table in place.
   * @param hookTableId The resource ID of the hook table.
   * @param resourceWithHooks The resource ID of the table with hooks to filter.
   * @param hookAddressToRemove The address of the hook to remove.
   */
  function filterListByAddress(
    ResourceId hookTableId,
    ResourceId resourceWithHooks,
    address hookAddressToRemove
  ) internal {
    bytes21[] memory currentHooks = Hooks._get(hookTableId, resourceWithHooks);

    // Initialize the new hooks array with the same length because we don't know if the hook is registered yet
    bytes21[] memory newHooks = new bytes21[](currentHooks.length);

    // Filter the array of current hooks
    uint256 newHooksIndex;
    unchecked {
      for (uint256 currentHooksIndex; currentHooksIndex < currentHooks.length; currentHooksIndex++) {
        if (Hook.wrap(currentHooks[currentHooksIndex]).getAddress() != address(hookAddressToRemove)) {
          newHooks[newHooksIndex] = currentHooks[currentHooksIndex];
          newHooksIndex++;
        }
      }
    }

    // Set the new hooks table length in place
    // (Note: this does not update the free memory pointer)
    assembly {
      mstore(newHooks, newHooksIndex)
    }

    // Set the new hooks table
    Hooks._set(hookTableId, resourceWithHooks, newHooks);
  }
}

/**
 * @title HookInstance
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev Library for interacting with Hook instances.
 **/
library HookInstance {
  /**
   * @notice Check if the given hook types are enabled in the hook.
   * @dev We check multiple hook types at once by using a bitmap.
   * @param self The Hook instance to check.
   * @param hookTypes A bitmap of hook types to check.
   * @return True if the hook types are enabled, false otherwise.
   */
  function isEnabled(Hook self, uint8 hookTypes) internal pure returns (bool) {
    return (getBitmap(self) & hookTypes) == hookTypes;
  }

  /**
   * @notice Get the address from the hook.
   * @dev The address is stored in the leftmost 20 bytes.
   * @param self The Hook instance to get the address from.
   * @return The address contained in the Hook instance.
   */
  function getAddress(Hook self) internal pure returns (address) {
    // Extract the address from the leftmost 20 bytes
    return address(bytes20(Hook.unwrap(self)));
  }

  /**
   * @notice Get the bitmap from the hook.
   * @dev The bitmap is stored in the rightmost byte.
   * @param self The Hook instance to get the bitmap from.
   * @return The bitmap contained in the Hook instance.
   */
  function getBitmap(Hook self) internal pure returns (uint8) {
    // Extract the bitmap from the rightmost bytes
    return uint8(uint168(Hook.unwrap(self)));
  }
}

// node_modules/@latticexyz/store/src/StoreCore.sol

/**
 * @title StoreCore Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This library includes implementations for all IStore methods and events related to the store actions.
 */
library StoreCore {
  /**
   * @notice Initialize the store address in StoreSwitch.
   * @dev Consumers must call this function in their constructor.
   * StoreSwitch uses the storeAddress to decide where to write data to.
   * If StoreSwitch is called in the context of a Store contract (storeAddress == address(this)),
   * StoreSwitch uses internal methods to write data instead of external calls.
   */
  function initialize() internal {
    StoreSwitch.setStoreAddress(address(this));
  }

  /**
   * @notice Register Store protocol's internal tables in the store.
   * @dev Consumers must call this function in their constructor before setting
   * any table data to allow indexers to decode table events.
   */
  function registerInternalTables() internal {
    // Because `registerTable` writes to both `Tables` and `ResourceIds`, we can't use it
    // directly here without creating a race condition, where we'd write to one or the other
    // before they exist (depending on the order of registration).
    //
    // Instead, we'll register them manually, writing everything to the `Tables` table first,
    // then the `ResourceIds` table. The logic here ought to be kept in sync with the internals
    // of the `registerTable` function below.
    if (ResourceIds._getExists(Tables._tableId)) {
      revert IStoreErrors.Store_TableAlreadyExists(Tables._tableId, string(abi.encodePacked(Tables._tableId)));
    }
    if (ResourceIds._getExists(ResourceIds._tableId)) {
      revert IStoreErrors.Store_TableAlreadyExists(
        ResourceIds._tableId,
        string(abi.encodePacked(ResourceIds._tableId))
      );
    }
    Tables._set(
      Tables._tableId,
      Tables._fieldLayout,
      Tables._keySchema,
      Tables._valueSchema,
      abi.encode(Tables.getKeyNames()),
      abi.encode(Tables.getFieldNames())
    );
    Tables._set(
      ResourceIds._tableId,
      ResourceIds._fieldLayout,
      ResourceIds._keySchema,
      ResourceIds._valueSchema,
      abi.encode(ResourceIds.getKeyNames()),
      abi.encode(ResourceIds.getFieldNames())
    );
    ResourceIds._setExists(Tables._tableId, true);
    ResourceIds._setExists(ResourceIds._tableId, true);

    // Now we can register the rest of the core tables as regular tables.
    StoreHooks.register();
  }

  /************************************************************************
   *
   *    SCHEMA
   *
   ************************************************************************/

  /**
   * @notice Get the field layout for the given table ID.
   * @param tableId The ID of the table for which to get the field layout.
   * @return The field layout for the given table ID.
   */
  function getFieldLayout(ResourceId tableId) internal view returns (FieldLayout) {
    // Explicit check for the Tables table to solve the bootstraping issue
    // of the Tables table not having a field layout before it is registered
    // since the field layout is stored in the Tables table.
    if (ResourceId.unwrap(tableId) == ResourceId.unwrap(Tables._tableId)) {
      return Tables._fieldLayout;
    }
    return
      FieldLayout.wrap(
        Storage.loadField({
          storagePointer: StoreCoreInternal._getStaticDataLocation(Tables._tableId, ResourceId.unwrap(tableId)),
          length: 32,
          offset: 0
        })
      );
  }

  /**
   * @notice Get the key schema for the given table ID.
   * @dev Reverts if the table ID is not registered.
   * @param tableId The ID of the table for which to get the key schema.
   * @return keySchema The key schema for the given table ID.
   */
  function getKeySchema(ResourceId tableId) internal view returns (Schema keySchema) {
    keySchema = Tables._getKeySchema(tableId);
    // key schemas can be empty for singleton tables, so we can't depend on key schema for table check
    if (!ResourceIds._getExists(tableId)) {
      revert IStoreErrors.Store_TableNotFound(tableId, string(abi.encodePacked(tableId)));
    }
  }

  /**
   * @notice Get the value schema for the given table ID.
   * @dev Reverts if the table ID is not registered.
   * @param tableId The ID of the table for which to get the value schema.
   * @return valueSchema The value schema for the given table ID.
   */
  function getValueSchema(ResourceId tableId) internal view returns (Schema valueSchema) {
    valueSchema = Tables._getValueSchema(tableId);
    if (valueSchema.isEmpty()) {
      revert IStoreErrors.Store_TableNotFound(tableId, string(abi.encodePacked(tableId)));
    }
  }

  /**
   * @notice Register a new table with the given configuration.
   * @dev This method reverts if
   * - The table ID is not of type RESOURCE_TABLE or RESOURCE_OFFCHAIN_TABLE.
   * - The field layout is invalid.
   * - The key schema is invalid.
   * - The value schema is invalid.
   * - The number of key names does not match the number of key schema types.
   * - The number of field names does not match the number of field layout fields.
   * @param tableId The ID of the table to register.
   * @param fieldLayout The field layout of the table.
   * @param keySchema The key schema of the table.
   * @param valueSchema The value schema of the table.
   * @param keyNames The names of the keys in the table.
   * @param fieldNames The names of the fields in the table.
   */
  function registerTable(
    ResourceId tableId,
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    string[] memory keyNames,
    string[] memory fieldNames
  ) internal {
    // Verify the table ID is of type RESOURCE_TABLE or RESOURCE_OFFCHAIN_TABLE
    if (tableId.getType() != RESOURCE_TABLE && tableId.getType() != RESOURCE_OFFCHAIN_TABLE) {
      revert IStoreErrors.Store_InvalidResourceType(RESOURCE_TABLE, tableId, string(abi.encodePacked(tableId)));
    }

    // Verify the field layout is valid
    fieldLayout.validate();

    // Verify the schema is valid
    keySchema.validate({ allowEmpty: true });
    valueSchema.validate({ allowEmpty: false });

    // Verify the number of key names matches the number of key schema types
    if (keyNames.length != keySchema.numFields()) {
      revert IStoreErrors.Store_InvalidKeyNamesLength(keySchema.numFields(), keyNames.length);
    }

    // Verify the number of value names
    if (fieldNames.length != fieldLayout.numFields()) {
      revert IStoreErrors.Store_InvalidFieldNamesLength(fieldLayout.numFields(), fieldNames.length);
    }

    // Verify the number of value schema types
    if (valueSchema.numFields() != fieldLayout.numFields()) {
      revert IStoreErrors.Store_InvalidValueSchemaLength(fieldLayout.numFields(), valueSchema.numFields());
    }
    if (valueSchema.numStaticFields() != fieldLayout.numStaticFields()) {
      revert IStoreErrors.Store_InvalidValueSchemaStaticLength(
        fieldLayout.numStaticFields(),
        valueSchema.numStaticFields()
      );
    }
    if (valueSchema.numDynamicFields() != fieldLayout.numDynamicFields()) {
      revert IStoreErrors.Store_InvalidValueSchemaDynamicLength(
        fieldLayout.numDynamicFields(),
        valueSchema.numDynamicFields()
      );
    }

    // Verify that static field lengths are consistent between Schema and FieldLayout
    for (uint256 i; i < fieldLayout.numStaticFields(); i++) {
      if (fieldLayout.atIndex(i) != valueSchema.atIndex(i).getStaticByteLength()) {
        revert IStoreErrors.Store_InvalidStaticDataLength(
          fieldLayout.atIndex(i),
          valueSchema.atIndex(i).getStaticByteLength()
        );
      }
    }

    // Verify that there is no table or offchain table with the same name
    ResourceId onchainTableId = ResourceIdLib.encode(RESOURCE_TABLE, tableId.getResourceName());
    ResourceId offchainTableId = ResourceIdLib.encode(RESOURCE_OFFCHAIN_TABLE, tableId.getResourceName());
    if (ResourceIds._getExists(onchainTableId) || ResourceIds._getExists(offchainTableId)) {
      revert IStoreErrors.Store_TableAlreadyExists(tableId, string(abi.encodePacked(tableId)));
    }

    // Register the table metadata
    Tables._set(tableId, fieldLayout, keySchema, valueSchema, abi.encode(keyNames), abi.encode(fieldNames));

    // Register the table ID
    ResourceIds._setExists(tableId, true);
  }

  /************************************************************************
   *
   *    REGISTER HOOKS
   *
   ************************************************************************/

  /**
   * @notice Register hooks to be called when a record or field is set or deleted.
   * @dev This method reverts for all resource IDs other than tables.
   * Hooks are not supported for offchain tables.
   * @param tableId The ID of the table to register the hook for.
   * @param hookAddress The address of the hook contract to register.
   * @param enabledHooksBitmap The bitmap of enabled hooks.
   */
  function registerStoreHook(ResourceId tableId, IStoreHook hookAddress, uint8 enabledHooksBitmap) internal {
    // Hooks are only supported for tables, not for offchain tables
    if (tableId.getType() != RESOURCE_TABLE) {
      revert IStoreErrors.Store_InvalidResourceType(RESOURCE_TABLE, tableId, string(abi.encodePacked(tableId)));
    }

    // Require the table to exist
    if (!ResourceIds._getExists(tableId)) {
      revert IStoreErrors.Store_TableNotFound(tableId, string(abi.encodePacked(tableId)));
    }

    StoreHooks._push(tableId, Hook.unwrap(HookLib.encode(address(hookAddress), enabledHooksBitmap)));
  }

  /**
   * @notice Unregister a hook from the given table ID.
   * @param tableId The ID of the table to unregister the hook from.
   * @param hookAddress The address of the hook to unregister.
   */
  function unregisterStoreHook(ResourceId tableId, IStoreHook hookAddress) internal {
    HookLib.filterListByAddress(StoreHooks._tableId, tableId, address(hookAddress));
  }

  /************************************************************************
   *
   *    SET DATA
   *
   ************************************************************************/

  /**
   * @notice Set a full record for the given table ID and key tuple.
   * @dev Calling this method emits a Store_SetRecord event.
   * This method internally calls another overload of setRecord by fetching the field layout for the given table ID.
   * If the field layout is available to the caller, it is recommended to use the other overload to avoid an additional storage read.
   * @param tableId The ID of the table to set the record for.
   * @param keyTuple An array representing the composite key for the record.
   * @param staticData The static data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param dynamicData The dynamic data of the record.
   */
  function setRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    bytes memory staticData,
    EncodedLengths encodedLengths,
    bytes memory dynamicData
  ) internal {
    setRecord(tableId, keyTuple, staticData, encodedLengths, dynamicData, getFieldLayout(tableId));
  }

  /**
   * @notice Set a full data record for the given table ID, key tuple, and field layout.
   * @dev For onchain tables, the method emits a `Store_SetRecord` event, updates the data in storage,
   * calls `onBeforeSetRecord` hooks before actually modifying the state, and calls `onAfterSetRecord`
   * hooks after modifying the state. For offchain tables, the method returns early after emitting the
   * event without calling hooks or modifying the state.
   * @param tableId The ID of the table to set the record for.
   * @param keyTuple An array representing the composite key for the record.
   * @param staticData The static data of the record.
   * @param encodedLengths The encoded lengths of the dynamic data of the record.
   * @param dynamicData The dynamic data of the record.
   * @param fieldLayout The field layout for the record.
   */
  function setRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    bytes memory staticData,
    EncodedLengths encodedLengths,
    bytes memory dynamicData,
    FieldLayout fieldLayout
  ) internal {
    // Early return if the table is an offchain table
    if (tableId.getType() == RESOURCE_OFFCHAIN_TABLE) {
      // Emit event to notify indexers
      emit IStoreEvents.Store_SetRecord(tableId, keyTuple, staticData, encodedLengths, dynamicData);
      return;
    }

    // Call onBeforeSetRecord hooks (before actually modifying the state, so observers have access to the previous state if needed)
    bytes21[] memory hooks = StoreHooks._get(tableId);
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(BEFORE_SET_RECORD)) {
        IStoreHook(hook.getAddress()).onBeforeSetRecord(
          tableId,
          keyTuple,
          staticData,
          encodedLengths,
          dynamicData,
          fieldLayout
        );
      }
    }

    // Emit event to notify indexers
    emit IStoreEvents.Store_SetRecord(tableId, keyTuple, staticData, encodedLengths, dynamicData);

    // Store the static data at the static data location
    uint256 staticDataLocation = StoreCoreInternal._getStaticDataLocation(tableId, keyTuple);
    uint256 memoryPointer = Memory.dataPointer(staticData);
    Storage.store({
      storagePointer: staticDataLocation,
      offset: 0,
      length: staticData.length,
      memoryPointer: memoryPointer
    });

    // Set the dynamic data if there are dynamic fields
    if (fieldLayout.numDynamicFields() > 0) {
      // Store the dynamic data length at the dynamic data length location
      uint256 dynamicDataLengthLocation = StoreCoreInternal._getDynamicDataLengthLocation(tableId, keyTuple);
      Storage.store({ storagePointer: dynamicDataLengthLocation, data: encodedLengths.unwrap() });

      // Move the memory pointer to the start of the dynamic data
      memoryPointer = Memory.dataPointer(dynamicData);

      // For every dynamic element, slice off the dynamic data and store it at the dynamic location
      uint256 dynamicDataLocation;
      uint256 dynamicDataLength;
      for (uint8 i; i < fieldLayout.numDynamicFields(); ) {
        dynamicDataLocation = StoreCoreInternal._getDynamicDataLocation(tableId, keyTuple, i);
        dynamicDataLength = encodedLengths.atIndex(i);
        Storage.store({
          storagePointer: dynamicDataLocation,
          offset: 0,
          length: dynamicDataLength,
          memoryPointer: memoryPointer
        });
        memoryPointer += dynamicDataLength; // move the memory pointer to the start of the next dynamic data
        unchecked {
          i++;
        }
      }
    }

    // Call onAfterSetRecord hooks (after modifying the state)
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(AFTER_SET_RECORD)) {
        IStoreHook(hook.getAddress()).onAfterSetRecord(
          tableId,
          keyTuple,
          staticData,
          encodedLengths,
          dynamicData,
          fieldLayout
        );
      }
    }
  }

  /**
   * @notice Splice the static data for the given table ID and key tuple.
   * @dev This method emits a `Store_SpliceStaticData` event, updates the data in storage, and calls
   * `onBeforeSpliceStaticData` and `onAfterSpliceStaticData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to splice the static data for.
   * @param keyTuple An array representing the composite key for the record.
   * @param start The start position in bytes for the splice operation.
   * @param data The data to write to the static data of the record at the start byte.
   */
  function spliceStaticData(ResourceId tableId, bytes32[] memory keyTuple, uint48 start, bytes memory data) internal {
    // Early return if the table is an offchain table
    if (tableId.getType() == RESOURCE_OFFCHAIN_TABLE) {
      // Emit event to notify offchain indexers
      emit IStoreEvents.Store_SpliceStaticData({ tableId: tableId, keyTuple: keyTuple, start: start, data: data });
      return;
    }

    uint256 location = StoreCoreInternal._getStaticDataLocation(tableId, keyTuple);

    // Call onBeforeSpliceStaticData hooks (before actually modifying the state, so observers have access to the previous state if needed)
    bytes21[] memory hooks = StoreHooks._get(tableId);
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(BEFORE_SPLICE_STATIC_DATA)) {
        IStoreHook(hook.getAddress()).onBeforeSpliceStaticData({
          tableId: tableId,
          keyTuple: keyTuple,
          start: start,
          data: data
        });
      }
    }

    // Emit event to notify offchain indexers
    emit IStoreEvents.Store_SpliceStaticData({ tableId: tableId, keyTuple: keyTuple, start: start, data: data });

    // Store the provided value in storage
    Storage.store({ storagePointer: location, offset: start, data: data });

    // Call onAfterSpliceStaticData hooks
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(AFTER_SPLICE_STATIC_DATA)) {
        IStoreHook(hook.getAddress()).onAfterSpliceStaticData({
          tableId: tableId,
          keyTuple: keyTuple,
          start: start,
          data: data
        });
      }
    }
  }

  /**
   * @notice Splice the dynamic data for the given table ID, key tuple, and dynamic field index.
   * @dev This method emits a `Store_SpliceDynamicData` event, updates the data in storage, and calls
   * `onBeforeSpliceDynamicData` and `onAfterSpliceDynamicData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to splice the dynamic data for.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to splice. (Dynamic field index = field index - number of static fields)
   * @param startWithinField The start position within the field for the splice operation.
   * @param deleteCount The number of bytes to delete in the splice operation.
   * @param data The data to insert into the dynamic data of the record at the start byte.
   */
  function spliceDynamicData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    bytes memory data
  ) internal {
    StoreCoreInternal._spliceDynamicData({
      tableId: tableId,
      keyTuple: keyTuple,
      dynamicFieldIndex: dynamicFieldIndex,
      startWithinField: startWithinField,
      deleteCount: deleteCount,
      data: data,
      previousEncodedLengths: StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple)
    });
  }

  /**
   * @notice Set data for a field at the given index in a table with the given tableId, key tuple, and value field layout.
   * @dev This method internally calls another overload of setField by fetching the field layout for the given table ID.
   * If the field layout is available to the caller, it is recommended to use the other overload to avoid an additional storage read.
   * This function emits a `Store_SpliceStaticData` or `Store_SpliceDynamicData` event and calls the corresponding hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to set the field for.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the field.
   */
  function setField(ResourceId tableId, bytes32[] memory keyTuple, uint8 fieldIndex, bytes memory data) internal {
    setField(tableId, keyTuple, fieldIndex, data, getFieldLayout(tableId));
  }

  /**
   * @notice Set data for a field at the given index in a table with the given tableId, key tuple, and value field layout.
   * @dev This method internally calls to `setStaticField` or `setDynamicField` based on the field index and layout.
   * Calling `setStaticField` or `setDynamicField` directly is recommended if the caller is aware of the field layout.
   * This function emits a `Store_SpliceStaticData` or `Store_SpliceDynamicData` event, updates the data in storage,
   * and calls the corresponding hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to set the field for.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the field.
   * @param fieldLayout The field layout for the record.
   */
  function setField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    bytes memory data,
    FieldLayout fieldLayout
  ) internal {
    if (fieldIndex < fieldLayout.numStaticFields()) {
      setStaticField(tableId, keyTuple, fieldIndex, data, fieldLayout);
    } else {
      setDynamicField(tableId, keyTuple, fieldIndex - uint8(fieldLayout.numStaticFields()), data);
    }
  }

  /**
   * @notice Set a static field for the given table ID, key tuple, field index, and field layout.
   * @dev This method emits a `Store_SpliceStaticData` event, updates the data in storage and calls the
   * `onBeforeSpliceStaticData` and `onAfterSpliceStaticData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to set the static field for.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the static field.
   * @param fieldLayout The field layout for the record.
   */
  function setStaticField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    bytes memory data,
    FieldLayout fieldLayout
  ) internal {
    spliceStaticData({
      tableId: tableId,
      keyTuple: keyTuple,
      start: uint48(StoreCoreInternal._getStaticDataOffset(fieldLayout, fieldIndex)),
      data: data
    });
  }

  /**
   * @notice Set a dynamic field for the given table ID, key tuple, and dynamic field index.
   * @dev This method emits a `Store_SpliceDynamicData` event, updates the data in storage and calls the
   * `onBeforeSpliceDynamicaData` and `onAfterSpliceDynamicData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to set the dynamic field for.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to set. (Dynamic field index = field index - number of static fields).
   * @param data The data to set for the dynamic field.
   */
  function setDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    bytes memory data
  ) internal {
    // Load the previous length of the field to set from storage to compute how much data to delete
    EncodedLengths previousEncodedLengths = StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple);
    uint40 previousFieldLength = uint40(previousEncodedLengths.atIndex(dynamicFieldIndex));

    StoreCoreInternal._spliceDynamicData({
      tableId: tableId,
      keyTuple: keyTuple,
      dynamicFieldIndex: dynamicFieldIndex,
      startWithinField: 0,
      deleteCount: previousFieldLength,
      data: data,
      previousEncodedLengths: previousEncodedLengths
    });
  }

  /**
   * @notice Delete a record for the given table ID and key tuple.
   * @dev This method internally calls another overload of deleteRecord by fetching the field layout for the given table ID.
   * This method deletes static data and sets the dynamic data length to 0, but does not
   * actually modify the dynamic data. It emits a `Store_DeleteRecord` event and emits the
   * `onBeforeDeleteRecord` and `onAfterDeleteRecord` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to delete the record from.
   * @param keyTuple An array representing the composite key for the record.
   */
  function deleteRecord(ResourceId tableId, bytes32[] memory keyTuple) internal {
    deleteRecord(tableId, keyTuple, getFieldLayout(tableId));
  }

  /**
   * @notice Delete a record for the given table ID and key tuple.
   * @dev This method deletes static data and sets the dynamic data length to 0, but does not
   * actually modify the dynamic data. It emits a `Store_DeleteRecord` event and emits the
   * `onBeforeDeleteRecord` and `onAfterDeleteRecord` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to delete the record from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldLayout The field layout for the record.
   */
  function deleteRecord(ResourceId tableId, bytes32[] memory keyTuple, FieldLayout fieldLayout) internal {
    // Early return if the table is an offchain table
    if (tableId.getType() == RESOURCE_OFFCHAIN_TABLE) {
      // Emit event to notify indexers
      emit IStoreEvents.Store_DeleteRecord(tableId, keyTuple);
      return;
    }

    // Call onBeforeDeleteRecord hooks (before actually modifying the state, so observers have access to the previous state if needed)
    bytes21[] memory hooks = StoreHooks._get(tableId);
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(BEFORE_DELETE_RECORD)) {
        IStoreHook(hook.getAddress()).onBeforeDeleteRecord(tableId, keyTuple, fieldLayout);
      }
    }

    // Emit event to notify indexers
    emit IStoreEvents.Store_DeleteRecord(tableId, keyTuple);

    // Delete static data
    uint256 staticDataLocation = StoreCoreInternal._getStaticDataLocation(tableId, keyTuple);
    Storage.store({ storagePointer: staticDataLocation, offset: 0, data: new bytes(fieldLayout.staticDataLength()) });

    // If there are dynamic fields, set the dynamic data length to 0.
    // We don't need to delete the dynamic data because it will be overwritten when a new record is set.
    if (fieldLayout.numDynamicFields() > 0) {
      uint256 dynamicDataLengthLocation = StoreCoreInternal._getDynamicDataLengthLocation(tableId, keyTuple);
      Storage.zero({ storagePointer: dynamicDataLengthLocation, length: 32 });
    }

    // Call onAfterDeleteRecord hooks
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(AFTER_DELETE_RECORD)) {
        IStoreHook(hook.getAddress()).onAfterDeleteRecord(tableId, keyTuple, fieldLayout);
      }
    }
  }

  /**
   * @notice Push data to a field at the dynamic field index in a table with the given table ID and key tuple.
   * @dev This method emits a `Store_SpliceDynamicData` event, updates the data in storage and calls the
   * `onBeforeSpliceDynamicData` and `onAfterSpliceDynamicData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to push data to the dynamic field.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to push data to.
   * @param dataToPush The data to push to the dynamic field.
   */
  function pushToDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    bytes memory dataToPush
  ) internal {
    // Load the previous length of the field to set from storage to compute where to start to push
    EncodedLengths previousEncodedLengths = StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple);
    uint40 previousFieldLength = uint40(previousEncodedLengths.atIndex(dynamicFieldIndex));

    // Splice the dynamic data
    StoreCoreInternal._spliceDynamicData({
      tableId: tableId,
      keyTuple: keyTuple,
      dynamicFieldIndex: dynamicFieldIndex,
      startWithinField: uint40(previousFieldLength),
      deleteCount: 0,
      data: dataToPush,
      previousEncodedLengths: previousEncodedLengths
    });
  }

  /**
   * @notice Pop data from a field at the dynamic field index in a table with the given table ID and key tuple.
   * @dev This method emits a `Store_SpliceDynamicData` event, updates the data in storage and calls the
   * `onBeforeSpliceDynamicData` and `onAfterSpliceDynamicData` hooks.
   * For offchain tables, it returns early after emitting the event.
   * @param tableId The ID of the table to pop data from the dynamic field.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to pop data from.
   * @param byteLengthToPop The byte length to pop from the dynamic field.
   */
  function popFromDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint256 byteLengthToPop
  ) internal {
    // Load the previous length of the field to set from storage to compute where to start to push
    EncodedLengths previousEncodedLengths = StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple);
    uint40 previousFieldLength = uint40(previousEncodedLengths.atIndex(dynamicFieldIndex));

    // Splice the dynamic data
    StoreCoreInternal._spliceDynamicData({
      tableId: tableId,
      keyTuple: keyTuple,
      dynamicFieldIndex: dynamicFieldIndex,
      startWithinField: uint40(previousFieldLength - byteLengthToPop),
      deleteCount: uint40(byteLengthToPop),
      data: new bytes(0),
      previousEncodedLengths: previousEncodedLengths
    });
  }

  /************************************************************************
   *
   *    GET DATA
   *
   ************************************************************************/

  /**
   * @notice Get the full record (all fields, static and dynamic data) for the given table ID and key tuple.
   * @dev This function internally calls another overload of `getRecord`, loading the field layout from storage.
   * If the field layout is available to the caller, it is recommended to use the other overload to avoid an additional storage read.
   * @param tableId The ID of the table to get the record from.
   * @param keyTuple An array representing the composite key for the record.
   * @return staticData The static data of the record.
   * @return encodedLengths The encoded lengths of the dynamic data of the record.
   * @return dynamicData The dynamic data of the record.
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple
  ) internal view returns (bytes memory staticData, EncodedLengths encodedLengths, bytes memory dynamicData) {
    return getRecord(tableId, keyTuple, getFieldLayout(tableId));
  }

  /**
   * @notice Get the full record (all fields, static and dynamic data) for the given table ID and key tuple, with the given field layout.
   * @param tableId The ID of the table to get the record from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldLayout The field layout for the record.
   * @return staticData The static data of the record.
   * @return encodedLengths The encoded lengths of the dynamic data of the record.
   * @return dynamicData The dynamic data of the record.
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    FieldLayout fieldLayout
  ) internal view returns (bytes memory staticData, EncodedLengths encodedLengths, bytes memory dynamicData) {
    // Get the static data length
    uint256 staticLength = fieldLayout.staticDataLength();

    // Load the static data from storage
    staticData = StoreCoreInternal._getStaticData(tableId, keyTuple, staticLength);

    // Load the dynamic data if there are dynamic fields
    uint256 numDynamicFields = fieldLayout.numDynamicFields();
    if (numDynamicFields > 0) {
      // Load the encoded dynamic data length
      encodedLengths = StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple);

      // Append dynamic data
      dynamicData = new bytes(encodedLengths.total());
      uint256 memoryPointer = Memory.dataPointer(dynamicData);

      for (uint8 i; i < numDynamicFields; i++) {
        uint256 dynamicDataLocation = StoreCoreInternal._getDynamicDataLocation(tableId, keyTuple, i);
        uint256 length = encodedLengths.atIndex(i);
        Storage.load({ storagePointer: dynamicDataLocation, offset: 0, length: length, memoryPointer: memoryPointer });
        // Advance memoryPointer by the length of this dynamic field
        memoryPointer += length;
      }
    }
  }

  /**
   * @notice Get a single field from the given table ID and key tuple.
   * @dev This function internally calls another overload of `getField`, loading the field layout from storage.
   * @param tableId The ID of the table to get the field from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get.
   * @return The data of the field.
   */
  function getField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex
  ) internal view returns (bytes memory) {
    return getField(tableId, keyTuple, fieldIndex, getFieldLayout(tableId));
  }

  /**
   * @notice Get a single field from the given table ID and key tuple, with the given field layout.
   * @param tableId The ID of the table to get the field from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get.
   * @param fieldLayout The field layout for the record.
   * @return The data of the field.
   */
  function getField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (bytes memory) {
    if (fieldIndex < fieldLayout.numStaticFields()) {
      return StoreCoreInternal._getStaticFieldBytes(tableId, keyTuple, fieldIndex, fieldLayout);
    } else {
      return getDynamicField(tableId, keyTuple, fieldIndex - uint8(fieldLayout.numStaticFields()));
    }
  }

  /**
   * @notice Get a single static field from the given table ID and key tuple, with the given value field layout.
   * @dev The field value is left-aligned in the returned bytes32, the rest of the word is not zeroed out.
   * Consumers are expected to truncate the returned value as needed.
   * @param tableId The ID of the table to get the static field from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get.
   * @param fieldLayout The field layout for the record.
   * @return The data of the static field.
   */
  function getStaticField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (bytes32) {
    // Get the length, storage location and offset of the static field
    // and load the data from storage
    return
      Storage.loadField({
        storagePointer: StoreCoreInternal._getStaticDataLocation(tableId, keyTuple),
        length: fieldLayout.atIndex(fieldIndex),
        offset: StoreCoreInternal._getStaticDataOffset(fieldLayout, fieldIndex)
      });
  }

  /**
   * @notice Get a single dynamic field from the given table ID and key tuple.
   * @param tableId The ID of the table to get the dynamic field from.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to get, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @return The data of the dynamic field.
   */
  function getDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) internal view returns (bytes memory) {
    // Get the storage location of the dynamic field
    // and load the data from storage
    return
      Storage.load({
        storagePointer: StoreCoreInternal._getDynamicDataLocation(tableId, keyTuple, dynamicFieldIndex),
        offset: 0,
        length: StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple).atIndex(dynamicFieldIndex)
      });
  }

  /**
   * @notice Get the byte length of a single field from the given table ID and key tuple.
   * @dev This function internally calls another overload of `getFieldLength`, loading the field layout from storage.
   * If the field layout is available to the caller, it is recommended to use the other overload to avoid an additional storage read.
   * @param tableId The ID of the table to get the field length from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get the length for.
   * @return The byte length of the field.
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex
  ) internal view returns (uint256) {
    return getFieldLength(tableId, keyTuple, fieldIndex, getFieldLayout(tableId));
  }

  /**
   * @notice Get the byte length of a single field from the given table ID and key tuple.
   * @param tableId The ID of the table to get the field length from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get the length for.
   * @param fieldLayout The field layout for the record.
   * @return The byte length of the field.
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (uint256) {
    uint8 numStaticFields = uint8(fieldLayout.numStaticFields());
    if (fieldIndex < numStaticFields) {
      return fieldLayout.atIndex(fieldIndex);
    } else {
      return getDynamicFieldLength(tableId, keyTuple, fieldIndex - numStaticFields);
    }
  }

  /**
   * @notice Get the byte length of a single dynamic field from the given table ID and key tuple.
   * @param tableId The ID of the table to get the dynamic field length from.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to get the length for, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @return The byte length of the dynamic field.
   */
  function getDynamicFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) internal view returns (uint256) {
    return StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple).atIndex(dynamicFieldIndex);
  }

  /**
   * @notice Get a byte slice (including start, excluding end) of a single dynamic field from the given table ID and key tuple.
   * @param tableId The ID of the table to get the dynamic field slice from.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to get the slice from, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @param start The start index within the dynamic field for the slice operation (inclusive).
   * @param end The end index within the dynamic field for the slice operation (exclusive).
   * @return The byte slice of the dynamic field.
   */
  function getDynamicFieldSlice(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint256 start,
    uint256 end
  ) internal view returns (bytes memory) {
    // Verify the slice bounds are valid
    if (start > end) {
      revert IStoreErrors.Store_InvalidBounds(start, end);
    }
    // Verify the accessed data is within the bounds of the dynamic field.
    // This is necessary because we don't delete the dynamic data when a record is deleted,
    // but only decrease its length.
    EncodedLengths encodedLengths = StoreCoreInternal._loadEncodedDynamicDataLength(tableId, keyTuple);
    uint256 fieldLength = encodedLengths.atIndex(dynamicFieldIndex);
    if (start >= fieldLength || end > fieldLength) {
      revert IStoreErrors.Store_IndexOutOfBounds(fieldLength, start >= fieldLength ? start : end - 1);
    }

    // Get the length and storage location of the dynamic field
    uint256 location = StoreCoreInternal._getDynamicDataLocation(tableId, keyTuple, dynamicFieldIndex);

    unchecked {
      return Storage.load({ storagePointer: location, offset: start, length: end - start });
    }
  }
}

/**
 * @title StoreCoreInternal
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This library contains internal functions used by StoreCore.
 * They are not intended to be used directly by consumers of StoreCore.
 */
library StoreCoreInternal {
  bytes32 internal constant SLOT = keccak256("mud.store");
  bytes32 internal constant DYNAMIC_DATA_SLOT = keccak256("mud.store.dynamicData");
  bytes32 internal constant DYNAMIC_DATA_LENGTH_SLOT = keccak256("mud.store.dynamicDataLength");

  /************************************************************************
   *
   *    SET DATA
   *
   ************************************************************************/

  /**
   * @notice Splice dynamic data in the store.
   * @dev This function checks various conditions to ensure the operation is valid.
   * It emits a `Store_SpliceDynamicData` event, calls `onBeforeSpliceDynamicData` hooks before actually modifying the storage,
   * and calls `onAfterSpliceDynamicData` hooks after modifying the storage.
   * It reverts with `Store_InvalidResourceType` if the table ID is not a table.
   * (Splicing dynamic data is not supported for offchain tables, as it requires reading the previous encoded lengths from storage.)
   * It reverts with `Store_InvalidSplice` if the splice total length of the field is changed but the splice is not at the end of the field.
   * It reverts with `Store_IndexOutOfBounds` if the start index is larger than the previous length of the field.
   * @param tableId The ID of the table to splice dynamic data.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to splice data, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @param startWithinField The start index within the field for the splice operation.
   * @param deleteCount The number of bytes to delete in the splice operation.
   * @param data The data to insert into the dynamic data of the record at the start byte.
   * @param previousEncodedLengths The previous encoded lengths of the dynamic data of the record.
   */
  function _spliceDynamicData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    bytes memory data,
    EncodedLengths previousEncodedLengths
  ) internal {
    // Splicing dynamic data is not supported for offchain tables, because it
    // requires reading the previous encoded lengths from storage
    if (tableId.getType() != RESOURCE_TABLE) {
      revert IStoreErrors.Store_InvalidResourceType(RESOURCE_TABLE, tableId, string(abi.encodePacked(tableId)));
    }

    uint256 previousFieldLength = previousEncodedLengths.atIndex(dynamicFieldIndex);
    uint256 updatedFieldLength = previousFieldLength - deleteCount + data.length;

    // If the total length of the field is changed, the data has to be appended/removed at the end of the field.
    // Otherwise offchain indexers would shift the data after inserted data, while onchain the data is truncated at the end.
    if (previousFieldLength != updatedFieldLength && startWithinField + deleteCount != previousFieldLength) {
      revert IStoreErrors.Store_InvalidSplice(startWithinField, deleteCount, uint40(previousFieldLength));
    }

    // The start index can't be larger than the previous length of the field
    if (startWithinField > previousFieldLength) {
      revert IStoreErrors.Store_IndexOutOfBounds(previousFieldLength, startWithinField);
    }

    // Update the encoded length
    EncodedLengths updatedEncodedLengths = previousEncodedLengths.setAtIndex(dynamicFieldIndex, updatedFieldLength);

    // Call onBeforeSpliceDynamicData hooks (before actually modifying the state, so observers have access to the previous state if needed)
    bytes21[] memory hooks = StoreHooks._get(tableId);
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(BEFORE_SPLICE_DYNAMIC_DATA)) {
        IStoreHook(hook.getAddress()).onBeforeSpliceDynamicData({
          tableId: tableId,
          keyTuple: keyTuple,
          dynamicFieldIndex: dynamicFieldIndex,
          startWithinField: startWithinField,
          deleteCount: deleteCount,
          encodedLengths: previousEncodedLengths,
          data: data
        });
      }
    }

    {
      // Compute start index for the splice
      uint256 start = startWithinField;
      unchecked {
        // (safe because it's a few uint40 values, which can't overflow uint48)
        for (uint8 i; i < dynamicFieldIndex; i++) {
          start += previousEncodedLengths.atIndex(i);
        }
      }

      // Emit event to notify offchain indexers
      emit IStoreEvents.Store_SpliceDynamicData({
        tableId: tableId,
        keyTuple: keyTuple,
        dynamicFieldIndex: dynamicFieldIndex,
        start: uint48(start),
        deleteCount: deleteCount,
        encodedLengths: updatedEncodedLengths,
        data: data
      });
    }

    // Store the updated encoded lengths in storage
    if (previousFieldLength != updatedFieldLength) {
      uint256 dynamicSchemaLengthSlot = _getDynamicDataLengthLocation(tableId, keyTuple);
      Storage.store({ storagePointer: dynamicSchemaLengthSlot, data: updatedEncodedLengths.unwrap() });
    }

    // Store the provided value in storage
    {
      uint256 dynamicDataLocation = _getDynamicDataLocation(tableId, keyTuple, dynamicFieldIndex);
      Storage.store({ storagePointer: dynamicDataLocation, offset: startWithinField, data: data });
    }

    // Call onAfterSpliceDynamicData hooks
    for (uint256 i; i < hooks.length; i++) {
      Hook hook = Hook.wrap(hooks[i]);
      if (hook.isEnabled(AFTER_SPLICE_DYNAMIC_DATA)) {
        IStoreHook(hook.getAddress()).onAfterSpliceDynamicData({
          tableId: tableId,
          keyTuple: keyTuple,
          dynamicFieldIndex: dynamicFieldIndex,
          startWithinField: startWithinField,
          deleteCount: deleteCount,
          encodedLengths: updatedEncodedLengths,
          data: data
        });
      }
    }
  }

  /************************************************************************
   *
   *    GET DATA
   *
   ************************************************************************/

  /**
   * @notice Get full static data for the given table ID and key tuple, with the given length in bytes.
   * @param tableId The ID of the table to get the static data from.
   * @param keyTuple An array representing the composite key for the record.
   * @param length The length of the static data to retrieve.
   * @return The full static data of the specified length.
   */
  function _getStaticData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint256 length
  ) internal view returns (bytes memory) {
    if (length == 0) return "";

    // Load the data from storage
    uint256 location = _getStaticDataLocation(tableId, keyTuple);
    return Storage.load({ storagePointer: location, offset: 0, length: length });
  }

  /**
   * @notice Get a single static field from the given table ID and key tuple, with the given value field layout.
   * @param tableId The ID of the table to get the static field from.
   * @param keyTuple An array representing the composite key for the record.
   * @param fieldIndex The index of the field to get.
   * @param fieldLayout The field layout for the record.
   * @return The static field data as dynamic bytes in the size of the field.
   */
  function _getStaticFieldBytes(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (bytes memory) {
    // Get the length, storage location and offset of the static field
    // and load the data from storage
    return
      Storage.load({
        storagePointer: _getStaticDataLocation(tableId, keyTuple),
        offset: _getStaticDataOffset(fieldLayout, fieldIndex),
        length: fieldLayout.atIndex(fieldIndex)
      });
  }

  /************************************************************************
   *
   *    HELPER FUNCTIONS
   *
   ************************************************************************/

  /////////////////////////////////////////////////////////////////////////
  //    STATIC DATA
  /////////////////////////////////////////////////////////////////////////

  /**
   * @notice Compute the storage location based on table ID and key tuple.
   * @param tableId The ID of the table.
   * @param keyTuple An array representing the composite key for the record.
   * @return The computed storage location based on table ID and key tuple.
   */
  function _getStaticDataLocation(ResourceId tableId, bytes32[] memory keyTuple) internal pure returns (uint256) {
    return uint256(SLOT ^ keccak256(abi.encodePacked(tableId, keyTuple)));
  }

  /**
   * @notice Compute the storage location based on table ID and a single key.
   * @param tableId The ID of the table.
   * @param key The single key for the record.
   * @return The computed storage location based on table ID and key.
   */
  function _getStaticDataLocation(ResourceId tableId, bytes32 key) internal pure returns (uint256) {
    // keccak256(abi.encodePacked(tableId, key)) is equivalent to keccak256(abi.encodePacked(tableId, [key]))
    return uint256(SLOT ^ keccak256(abi.encodePacked(tableId, key)));
  }

  /**
   * @notice Get storage offset for the given value field layout and index.
   * @param fieldLayout The field layout for the record.
   * @param fieldIndex The index of the field to get the offset for.
   * @return The storage offset for the specified field layout and index.
   */
  function _getStaticDataOffset(FieldLayout fieldLayout, uint8 fieldIndex) internal pure returns (uint256) {
    uint256 offset = 0;
    for (uint256 i; i < fieldIndex; i++) {
      offset += fieldLayout.atIndex(i);
    }
    return offset;
  }

  /////////////////////////////////////////////////////////////////////////
  //    DYNAMIC DATA
  /////////////////////////////////////////////////////////////////////////

  /**
   * @notice Compute the storage location based on table ID, key tuple, and dynamic field index.
   * @param tableId The ID of the table.
   * @param keyTuple An array representing the composite key for the record.
   * @param dynamicFieldIndex The index of the dynamic field, relative to the start of the dynamic fields.
   * (Dynamic field index = field index - number of static fields)
   * @return The computed storage location based on table ID, key tuple, and dynamic field index.
   */
  function _getDynamicDataLocation(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) internal pure returns (uint256) {
    return uint256(DYNAMIC_DATA_SLOT ^ bytes1(dynamicFieldIndex) ^ keccak256(abi.encodePacked(tableId, keyTuple)));
  }

  /**
   * @notice Compute the storage location for the length of the dynamic data based on table ID and key tuple.
   * @param tableId The ID of the table.
   * @param keyTuple An array representing the composite key for the record.
   * @return The computed storage location for the length of the dynamic data based on table ID and key tuple.
   */
  function _getDynamicDataLengthLocation(
    ResourceId tableId,
    bytes32[] memory keyTuple
  ) internal pure returns (uint256) {
    return uint256(DYNAMIC_DATA_LENGTH_SLOT ^ keccak256(abi.encodePacked(tableId, keyTuple)));
  }

  /**
   * @notice Load the encoded dynamic data length from storage for the given table ID and key tuple.
   * @param tableId The ID of the table.
   * @param keyTuple An array representing the composite key for the record.
   * @return The loaded encoded dynamic data length from storage for the given table ID and key tuple.
   */
  function _loadEncodedDynamicDataLength(
    ResourceId tableId,
    bytes32[] memory keyTuple
  ) internal view returns (EncodedLengths) {
    // Load dynamic data length from storage
    return EncodedLengths.wrap(Storage.load({ storagePointer: _getDynamicDataLengthLocation(tableId, keyTuple) }));
  }
}

// node_modules/@latticexyz/store/src/StoreSwitch.sol

/**
 * @title StoreSwitch Library
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This library serves as an interface switch to interact with the store,
 *         either by directing calls to itself or to a designated external store.
 * @dev The primary purpose is to abstract the storage details, such that the
 *      calling function doesn't need to know if it's interacting with its own
 *      storage or with an external contract's storage.
 */
library StoreSwitch {
  /// @dev Internal constant representing the storage slot used by the library.
  bytes32 private constant STORAGE_SLOT = keccak256("mud.store.storage.StoreSwitch");

  /**
   * @dev Represents the layout of the storage slot (currently just the address)
   */
  struct StorageSlotLayout {
    address storeAddress; // Address of the external store (or self).
  }

  /**
   * @notice Gets the storage layout.
   * @return layout The current storage layout.
   */
  function _layout() private pure returns (StorageSlotLayout storage layout) {
    bytes32 slot = STORAGE_SLOT;
    assembly {
      layout.slot := slot
    }
  }

  /**
   * @notice Fetch the store address to be used for data operations.
   * If _storeAddress is zero, it means that it's uninitialized and
   * therefore it's the default (msg.sender).
   * @return Address of the store, or `msg.sender` if uninitialized.
   */
  function getStoreAddress() internal view returns (address) {
    address _storeAddress = _layout().storeAddress;
    if (_storeAddress == address(0)) {
      return msg.sender;
    } else {
      return _storeAddress;
    }
  }

  /**
   * @notice Set the store address for subsequent operations.
   * @dev If it stays uninitialized, StoreSwitch falls back to calling store methods on msg.sender.
   * @param _storeAddress The address of the external store contract.
   */
  function setStoreAddress(address _storeAddress) internal {
    _layout().storeAddress = _storeAddress;
  }

  /**
   * @notice Register a store hook for a particular table.
   * @param tableId Unique identifier of the table.
   * @param hookAddress Address of the hook contract.
   * @param enabledHooksBitmap Bitmap representing the hooks which this contract overrides.
   */
  function registerStoreHook(ResourceId tableId, IStoreHook hookAddress, uint8 enabledHooksBitmap) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.registerStoreHook(tableId, hookAddress, enabledHooksBitmap);
    } else {
      IStore(_storeAddress).registerStoreHook(tableId, hookAddress, enabledHooksBitmap);
    }
  }

  /**
   * @notice Unregister a previously registered store hook.
   * @param tableId Unique identifier of the table.
   * @param hookAddress Address of the hook contract to be unregistered.
   */
  function unregisterStoreHook(ResourceId tableId, IStoreHook hookAddress) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.unregisterStoreHook(tableId, hookAddress);
    } else {
      IStore(_storeAddress).unregisterStoreHook(tableId, hookAddress);
    }
  }

  /**
   * @dev Fetches the field layout for a specified table.
   * @param tableId The ID of the table for which to retrieve the field layout.
   * @return fieldLayout The layout of the fields in the specified table.
   */
  function getFieldLayout(ResourceId tableId) internal view returns (FieldLayout fieldLayout) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      fieldLayout = StoreCore.getFieldLayout(tableId);
    } else {
      fieldLayout = IStore(_storeAddress).getFieldLayout(tableId);
    }
  }

  /**
   * @dev Retrieves the value schema for a specified table.
   * @param tableId The ID of the table for which to retrieve the value schema.
   * @return valueSchema The schema for values in the specified table.
   */
  function getValueSchema(ResourceId tableId) internal view returns (Schema valueSchema) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      valueSchema = StoreCore.getValueSchema(tableId);
    } else {
      valueSchema = IStore(_storeAddress).getValueSchema(tableId);
    }
  }

  /**
   * @dev Retrieves the key schema for a specified table.
   * @param tableId The ID of the table for which to retrieve the key schema.
   * @return keySchema The schema for keys in the specified table.
   */
  function getKeySchema(ResourceId tableId) internal view returns (Schema keySchema) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      keySchema = StoreCore.getKeySchema(tableId);
    } else {
      keySchema = IStore(_storeAddress).getKeySchema(tableId);
    }
  }

  /**
   * @dev Registers a table with specified configurations.
   * @param tableId The ID of the table to register.
   * @param fieldLayout The layout of the fields for the table.
   * @param keySchema The schema for keys in the table.
   * @param valueSchema The schema for values in the table.
   * @param keyNames Names of keys in the table.
   * @param fieldNames Names of fields in the table.
   */
  function registerTable(
    ResourceId tableId,
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    string[] memory keyNames,
    string[] memory fieldNames
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.registerTable(tableId, fieldLayout, keySchema, valueSchema, keyNames, fieldNames);
    } else {
      IStore(_storeAddress).registerTable(tableId, fieldLayout, keySchema, valueSchema, keyNames, fieldNames);
    }
  }

  /**
   * @dev Sets a record in the store.
   * @param tableId The table's ID.
   * @param keyTuple Array of key values.
   * @param staticData Fixed-length fields data.
   * @param encodedLengths Encoded lengths for dynamic data.
   * @param dynamicData Dynamic-length fields data.
   */
  function setRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    bytes memory staticData,
    EncodedLengths encodedLengths,
    bytes memory dynamicData
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.setRecord(tableId, keyTuple, staticData, encodedLengths, dynamicData);
    } else {
      IStore(_storeAddress).setRecord(tableId, keyTuple, staticData, encodedLengths, dynamicData);
    }
  }

  /**
   * @dev Splices the static (fixed length) data for a given table ID and key tuple, starting at a specific point.
   * @param tableId The ID of the resource table.
   * @param keyTuple An array of bytes32 keys identifying the data record.
   * @param start The position to begin splicing.
   * @param data The data to splice into the record.
   */
  function spliceStaticData(ResourceId tableId, bytes32[] memory keyTuple, uint48 start, bytes memory data) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.spliceStaticData(tableId, keyTuple, start, data);
    } else {
      IStore(_storeAddress).spliceStaticData(tableId, keyTuple, start, data);
    }
  }

  /**
   * @dev Splices the dynamic data for a given table ID, key tuple, and dynamic field index.
   * @param tableId The ID of the resource table.
   * @param keyTuple An array of bytes32 keys identifying the data record.
   * @param dynamicFieldIndex The index of the dynamic field to splice.
   * @param startWithinField The position within the dynamic field to start splicing.
   * @param deleteCount The number of bytes to delete starting from the splice point.
   * @param data The data to splice into the dynamic field.
   */
  function spliceDynamicData(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint40 startWithinField,
    uint40 deleteCount,
    bytes memory data
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.spliceDynamicData(tableId, keyTuple, dynamicFieldIndex, startWithinField, deleteCount, data);
    } else {
      IStore(_storeAddress).spliceDynamicData(
        tableId,
        keyTuple,
        dynamicFieldIndex,
        startWithinField,
        deleteCount,
        data
      );
    }
  }

  /**
   * @dev Sets the data for a specific field in a record identified by table ID and key tuple.
   * @param tableId The ID of the resource table.
   * @param keyTuple An array of bytes32 keys identifying the data record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the field.
   */
  function setField(ResourceId tableId, bytes32[] memory keyTuple, uint8 fieldIndex, bytes memory data) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.setField(tableId, keyTuple, fieldIndex, data);
    } else {
      IStore(_storeAddress).setField(tableId, keyTuple, fieldIndex, data);
    }
  }

  /**
   * @dev Sets the data for a specific field in a record, considering a specific field layout.
   * @param tableId The ID of the resource table.
   * @param keyTuple An array of bytes32 keys identifying the data record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the field.
   * @param fieldLayout The layout structure of the field.
   */
  function setField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    bytes memory data,
    FieldLayout fieldLayout
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.setField(tableId, keyTuple, fieldIndex, data, fieldLayout);
    } else {
      IStore(_storeAddress).setField(tableId, keyTuple, fieldIndex, data, fieldLayout);
    }
  }

  /**
   * @dev Sets the data for a specific static (fixed length) field in a record, considering a specific field layout.
   * @param tableId The ID of the resource table.
   * @param keyTuple An array of bytes32 keys identifying the data record.
   * @param fieldIndex The index of the field to set.
   * @param data The data to set for the field.
   * @param fieldLayout The layout structure of the field.
   */
  function setStaticField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    bytes memory data,
    FieldLayout fieldLayout
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.setStaticField(tableId, keyTuple, fieldIndex, data, fieldLayout);
    } else {
      IStore(_storeAddress).setStaticField(tableId, keyTuple, fieldIndex, data, fieldLayout);
    }
  }

  /**
   * @dev Sets the value of a specific dynamic (variable-length) field in a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to set.
   * @param data The data to set for the field.
   */
  function setDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    bytes memory data
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.setDynamicField(tableId, keyTuple, dynamicFieldIndex, data);
    } else {
      IStore(_storeAddress).setDynamicField(tableId, keyTuple, dynamicFieldIndex, data);
    }
  }

  /**
   * @dev Appends data to a specific dynamic (variable length) field of a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field.
   * @param dataToPush The data to append to the field.
   */
  function pushToDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    bytes memory dataToPush
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.pushToDynamicField(tableId, keyTuple, dynamicFieldIndex, dataToPush);
    } else {
      IStore(_storeAddress).pushToDynamicField(tableId, keyTuple, dynamicFieldIndex, dataToPush);
    }
  }

  /**
   * @dev Removes data from the end of a specific dynamic (variable length) field of a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field.
   * @param byteLengthToPop The number of bytes to remove from the end of the field.
   */
  function popFromDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint256 byteLengthToPop
  ) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.popFromDynamicField(tableId, keyTuple, dynamicFieldIndex, byteLengthToPop);
    } else {
      IStore(_storeAddress).popFromDynamicField(tableId, keyTuple, dynamicFieldIndex, byteLengthToPop);
    }
  }

  /**
   * @dev Deletes a record from a table.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   */
  function deleteRecord(ResourceId tableId, bytes32[] memory keyTuple) internal {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      StoreCore.deleteRecord(tableId, keyTuple);
    } else {
      IStore(_storeAddress).deleteRecord(tableId, keyTuple);
    }
  }

  /**
   * @dev Retrieves a record from a table.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @return staticData The static data of the record.
   * @return encodedLengths Encoded lengths of dynamic data.
   * @return dynamicData The dynamic data of the record.
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple
  ) internal view returns (bytes memory, EncodedLengths, bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getRecord(tableId, keyTuple);
    } else {
      return IStore(_storeAddress).getRecord(tableId, keyTuple);
    }
  }

  /**
   * @dev Retrieves a record from a table with a specific layout.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldLayout The layout of the fields in the record.
   * @return staticData The static data of the record.
   * @return encodedLengths Encoded lengths of dynamic data.
   * @return dynamicData The dynamic data of the record.
   */
  function getRecord(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    FieldLayout fieldLayout
  ) internal view returns (bytes memory, EncodedLengths, bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getRecord(tableId, keyTuple, fieldLayout);
    } else {
      return IStore(_storeAddress).getRecord(tableId, keyTuple, fieldLayout);
    }
  }

  /**
   * @dev Retrieves a specific field from a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field to retrieve.
   * @return Returns the data of the specified field.
   */
  function getField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex
  ) internal view returns (bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getField(tableId, keyTuple, fieldIndex);
    } else {
      return IStore(_storeAddress).getField(tableId, keyTuple, fieldIndex);
    }
  }

  /**
   * @dev Retrieves a specific field from a record with a given layout.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field to retrieve.
   * @param fieldLayout The layout of the field being retrieved.
   * @return Returns the data of the specified field.
   */
  function getField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getField(tableId, keyTuple, fieldIndex, fieldLayout);
    } else {
      return IStore(_storeAddress).getField(tableId, keyTuple, fieldIndex, fieldLayout);
    }
  }

  /**
   * @dev Retrieves a specific static (fixed length) field from a record with a given layout.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the static field to retrieve.
   * @param fieldLayout The layout of the static field being retrieved.
   * @return Returns the data of the specified static field.
   */
  function getStaticField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (bytes32) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getStaticField(tableId, keyTuple, fieldIndex, fieldLayout);
    } else {
      return IStore(_storeAddress).getStaticField(tableId, keyTuple, fieldIndex, fieldLayout);
    }
  }

  /**
   * @dev Retrieves a specific dynamic (variable length) field from a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field to retrieve.
   * @return Returns the data of the specified dynamic field.
   */
  function getDynamicField(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) internal view returns (bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getDynamicField(tableId, keyTuple, dynamicFieldIndex);
    } else {
      return IStore(_storeAddress).getDynamicField(tableId, keyTuple, dynamicFieldIndex);
    }
  }

  /**
   * @dev Retrieves the length of a specific field in a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field whose length is to be retrieved.
   * @return Returns the length of the specified field.
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex
  ) internal view returns (uint256) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getFieldLength(tableId, keyTuple, fieldIndex);
    } else {
      return IStore(_storeAddress).getFieldLength(tableId, keyTuple, fieldIndex);
    }
  }

  /**
   * @dev Retrieves the length of a specific field in a record with a given layout.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param fieldIndex The index of the field whose length is to be retrieved.
   * @param fieldLayout The layout of the field whose length is to be retrieved.
   * @return Returns the length of the specified field.
   */
  function getFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 fieldIndex,
    FieldLayout fieldLayout
  ) internal view returns (uint256) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getFieldLength(tableId, keyTuple, fieldIndex, fieldLayout);
    } else {
      return IStore(_storeAddress).getFieldLength(tableId, keyTuple, fieldIndex, fieldLayout);
    }
  }

  /**
   * @dev Retrieves the length of a specific dynamic (variable length) field in a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field whose length is to be retrieved.
   * @return Returns the length of the specified dynamic field.
   */
  function getDynamicFieldLength(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex
  ) internal view returns (uint256) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getDynamicFieldLength(tableId, keyTuple, dynamicFieldIndex);
    } else {
      return IStore(_storeAddress).getDynamicFieldLength(tableId, keyTuple, dynamicFieldIndex);
    }
  }

  /**
   * @dev Retrieves a slice of a dynamic (variable length) field from a record.
   * @param tableId The ID of the table to which the record belongs.
   * @param keyTuple An array representing the key for the record.
   * @param dynamicFieldIndex The index of the dynamic field from which to get the slice.
   * @param start The starting index of the slice.
   * @param end The ending index of the slice.
   * @return Returns the sliced data from the specified dynamic field.
   */
  function getDynamicFieldSlice(
    ResourceId tableId,
    bytes32[] memory keyTuple,
    uint8 dynamicFieldIndex,
    uint256 start,
    uint256 end
  ) internal view returns (bytes memory) {
    address _storeAddress = getStoreAddress();
    if (_storeAddress == address(this)) {
      return StoreCore.getDynamicFieldSlice(tableId, keyTuple, dynamicFieldIndex, start, end);
    } else {
      return IStore(_storeAddress).getDynamicFieldSlice(tableId, keyTuple, dynamicFieldIndex, start, end);
    }
  }
}

// node_modules/@latticexyz/store/src/codegen/index.sol

/* Autogenerated file. Do not edit manually. */

// node_modules/@latticexyz/store/src/codegen/tables/Hooks.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

// Import user types

library Hooks {
  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes21[])
  Schema constant _valueSchema = Schema.wrap(0x00000001b6000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "resourceId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "hooks";
  }

  /**
   * @notice Register the table with its config.
   */
  function register(ResourceId _tableId) internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register(ResourceId _tableId) internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get hooks.
   */
  function getHooks(ResourceId _tableId, ResourceId resourceId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function _getHooks(ResourceId _tableId, ResourceId resourceId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function get(ResourceId _tableId, ResourceId resourceId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function _get(ResourceId _tableId, ResourceId resourceId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Set hooks.
   */
  function setHooks(ResourceId _tableId, ResourceId resourceId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function _setHooks(ResourceId _tableId, ResourceId resourceId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function set(ResourceId _tableId, ResourceId resourceId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function _set(ResourceId _tableId, ResourceId resourceId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Get the length of hooks.
   */
  function lengthHooks(ResourceId _tableId, ResourceId resourceId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function _lengthHooks(ResourceId _tableId, ResourceId resourceId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function length(ResourceId _tableId, ResourceId resourceId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function _length(ResourceId _tableId, ResourceId resourceId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemHooks(ResourceId _tableId, ResourceId resourceId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemHooks(ResourceId _tableId, ResourceId resourceId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(ResourceId _tableId, ResourceId resourceId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(ResourceId _tableId, ResourceId resourceId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Push an element to hooks.
   */
  function pushHooks(ResourceId _tableId, ResourceId resourceId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function _pushHooks(ResourceId _tableId, ResourceId resourceId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function push(ResourceId _tableId, ResourceId resourceId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function _push(ResourceId _tableId, ResourceId resourceId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from hooks.
   */
  function popHooks(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function _popHooks(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function pop(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function _pop(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function updateHooks(ResourceId _tableId, ResourceId resourceId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function _updateHooks(ResourceId _tableId, ResourceId resourceId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function update(ResourceId _tableId, ResourceId resourceId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function _update(ResourceId _tableId, ResourceId resourceId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId _tableId, ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes21[] memory hooks) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(hooks.length * 21);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes21[] memory hooks) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((hooks)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes21[] memory hooks) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(hooks);
    bytes memory _dynamicData = encodeDynamic(hooks);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId resourceId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    return _keyTuple;
  }
}

// node_modules/@latticexyz/store/src/codegen/tables/ResourceIds.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

// Import user types

library ResourceIds {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "store", name: "ResourceIds", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746273746f72650000000000000000005265736f757263654964730000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0001010001000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bool)
  Schema constant _valueSchema = Schema.wrap(0x0001010060000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "resourceId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "exists";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get exists.
   */
  function getExists(ResourceId resourceId) internal view returns (bool exists) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get exists.
   */
  function _getExists(ResourceId resourceId) internal view returns (bool exists) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get exists.
   */
  function get(ResourceId resourceId) internal view returns (bool exists) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get exists.
   */
  function _get(ResourceId resourceId) internal view returns (bool exists) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set exists.
   */
  function setExists(ResourceId resourceId, bool exists) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((exists)), _fieldLayout);
  }

  /**
   * @notice Set exists.
   */
  function _setExists(ResourceId resourceId, bool exists) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((exists)), _fieldLayout);
  }

  /**
   * @notice Set exists.
   */
  function set(ResourceId resourceId, bool exists) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((exists)), _fieldLayout);
  }

  /**
   * @notice Set exists.
   */
  function _set(ResourceId resourceId, bool exists) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((exists)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId resourceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(bool exists) internal pure returns (bytes memory) {
    return abi.encodePacked(exists);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bool exists) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(exists);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId resourceId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(resourceId);

    return _keyTuple;
  }
}

/**
 * @notice Cast a value to a bool.
 * @dev Boolean values are encoded as uint8 (1 = true, 0 = false), but Solidity doesn't allow casting between uint8 and bool.
 * @param value The uint8 value to convert.
 * @return result The boolean value.
 */
function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}

// node_modules/@latticexyz/store/src/codegen/tables/StoreHooks.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

// Import user types

library StoreHooks {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "store", name: "StoreHooks", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746273746f726500000000000000000053746f7265486f6f6b73000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes21[])
  Schema constant _valueSchema = Schema.wrap(0x00000001b6000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "tableId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "hooks";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get hooks.
   */
  function getHooks(ResourceId tableId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function _getHooks(ResourceId tableId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function get(ResourceId tableId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Get hooks.
   */
  function _get(ResourceId tableId) internal view returns (bytes21[] memory hooks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes21());
  }

  /**
   * @notice Set hooks.
   */
  function setHooks(ResourceId tableId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function _setHooks(ResourceId tableId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function set(ResourceId tableId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Set hooks.
   */
  function _set(ResourceId tableId, bytes21[] memory hooks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((hooks)));
  }

  /**
   * @notice Get the length of hooks.
   */
  function lengthHooks(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function _lengthHooks(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function length(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get the length of hooks.
   */
  function _length(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 21;
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemHooks(ResourceId tableId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemHooks(ResourceId tableId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(ResourceId tableId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Get an item of hooks.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(ResourceId tableId, uint256 _index) internal view returns (bytes21) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 21, (_index + 1) * 21);
      return (bytes21(_blob));
    }
  }

  /**
   * @notice Push an element to hooks.
   */
  function pushHooks(ResourceId tableId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function _pushHooks(ResourceId tableId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function push(ResourceId tableId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to hooks.
   */
  function _push(ResourceId tableId, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from hooks.
   */
  function popHooks(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function _popHooks(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function pop(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Pop an element from hooks.
   */
  function _pop(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 21);
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function updateHooks(ResourceId tableId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function _updateHooks(ResourceId tableId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function update(ResourceId tableId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of hooks at `_index`.
   */
  function _update(ResourceId tableId, uint256 _index, bytes21 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 21), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes21[] memory hooks) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(hooks.length * 21);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes21[] memory hooks) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((hooks)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes21[] memory hooks) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(hooks);
    bytes memory _dynamicData = encodeDynamic(hooks);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId tableId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    return _keyTuple;
  }
}

// node_modules/@latticexyz/store/src/codegen/tables/Tables.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

// Import user types

struct TablesData {
  FieldLayout fieldLayout;
  Schema keySchema;
  Schema valueSchema;
  bytes abiEncodedKeyNames;
  bytes abiEncodedFieldNames;
}

library Tables {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "store", name: "Tables", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746273746f72650000000000000000005461626c657300000000000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0060030220202000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes32, bytes32, bytes32, bytes, bytes)
  Schema constant _valueSchema = Schema.wrap(0x006003025f5f5fc4c40000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "tableId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](5);
    fieldNames[0] = "fieldLayout";
    fieldNames[1] = "keySchema";
    fieldNames[2] = "valueSchema";
    fieldNames[3] = "abiEncodedKeyNames";
    fieldNames[4] = "abiEncodedFieldNames";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get fieldLayout.
   */
  function getFieldLayout(ResourceId tableId) internal view returns (FieldLayout fieldLayout) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return FieldLayout.wrap(bytes32(_blob));
  }

  /**
   * @notice Get fieldLayout.
   */
  function _getFieldLayout(ResourceId tableId) internal view returns (FieldLayout fieldLayout) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return FieldLayout.wrap(bytes32(_blob));
  }

  /**
   * @notice Set fieldLayout.
   */
  function setFieldLayout(ResourceId tableId, FieldLayout fieldLayout) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(FieldLayout.unwrap(fieldLayout)), _fieldLayout);
  }

  /**
   * @notice Set fieldLayout.
   */
  function _setFieldLayout(ResourceId tableId, FieldLayout fieldLayout) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(FieldLayout.unwrap(fieldLayout)), _fieldLayout);
  }

  /**
   * @notice Get keySchema.
   */
  function getKeySchema(ResourceId tableId) internal view returns (Schema keySchema) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return Schema.wrap(bytes32(_blob));
  }

  /**
   * @notice Get keySchema.
   */
  function _getKeySchema(ResourceId tableId) internal view returns (Schema keySchema) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return Schema.wrap(bytes32(_blob));
  }

  /**
   * @notice Set keySchema.
   */
  function setKeySchema(ResourceId tableId, Schema keySchema) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked(Schema.unwrap(keySchema)), _fieldLayout);
  }

  /**
   * @notice Set keySchema.
   */
  function _setKeySchema(ResourceId tableId, Schema keySchema) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked(Schema.unwrap(keySchema)), _fieldLayout);
  }

  /**
   * @notice Get valueSchema.
   */
  function getValueSchema(ResourceId tableId) internal view returns (Schema valueSchema) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return Schema.wrap(bytes32(_blob));
  }

  /**
   * @notice Get valueSchema.
   */
  function _getValueSchema(ResourceId tableId) internal view returns (Schema valueSchema) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return Schema.wrap(bytes32(_blob));
  }

  /**
   * @notice Set valueSchema.
   */
  function setValueSchema(ResourceId tableId, Schema valueSchema) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked(Schema.unwrap(valueSchema)), _fieldLayout);
  }

  /**
   * @notice Set valueSchema.
   */
  function _setValueSchema(ResourceId tableId, Schema valueSchema) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked(Schema.unwrap(valueSchema)), _fieldLayout);
  }

  /**
   * @notice Get abiEncodedKeyNames.
   */
  function getAbiEncodedKeyNames(ResourceId tableId) internal view returns (bytes memory abiEncodedKeyNames) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Get abiEncodedKeyNames.
   */
  function _getAbiEncodedKeyNames(ResourceId tableId) internal view returns (bytes memory abiEncodedKeyNames) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Set abiEncodedKeyNames.
   */
  function setAbiEncodedKeyNames(ResourceId tableId, bytes memory abiEncodedKeyNames) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((abiEncodedKeyNames)));
  }

  /**
   * @notice Set abiEncodedKeyNames.
   */
  function _setAbiEncodedKeyNames(ResourceId tableId, bytes memory abiEncodedKeyNames) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((abiEncodedKeyNames)));
  }

  /**
   * @notice Get the length of abiEncodedKeyNames.
   */
  function lengthAbiEncodedKeyNames(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of abiEncodedKeyNames.
   */
  function _lengthAbiEncodedKeyNames(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of abiEncodedKeyNames.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemAbiEncodedKeyNames(ResourceId tableId, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of abiEncodedKeyNames.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemAbiEncodedKeyNames(ResourceId tableId, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Push a slice to abiEncodedKeyNames.
   */
  function pushAbiEncodedKeyNames(ResourceId tableId, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to abiEncodedKeyNames.
   */
  function _pushAbiEncodedKeyNames(ResourceId tableId, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from abiEncodedKeyNames.
   */
  function popAbiEncodedKeyNames(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from abiEncodedKeyNames.
   */
  function _popAbiEncodedKeyNames(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Update a slice of abiEncodedKeyNames at `_index`.
   */
  function updateAbiEncodedKeyNames(ResourceId tableId, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of abiEncodedKeyNames at `_index`.
   */
  function _updateAbiEncodedKeyNames(ResourceId tableId, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get abiEncodedFieldNames.
   */
  function getAbiEncodedFieldNames(ResourceId tableId) internal view returns (bytes memory abiEncodedFieldNames) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (bytes(_blob));
  }

  /**
   * @notice Get abiEncodedFieldNames.
   */
  function _getAbiEncodedFieldNames(ResourceId tableId) internal view returns (bytes memory abiEncodedFieldNames) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (bytes(_blob));
  }

  /**
   * @notice Set abiEncodedFieldNames.
   */
  function setAbiEncodedFieldNames(ResourceId tableId, bytes memory abiEncodedFieldNames) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((abiEncodedFieldNames)));
  }

  /**
   * @notice Set abiEncodedFieldNames.
   */
  function _setAbiEncodedFieldNames(ResourceId tableId, bytes memory abiEncodedFieldNames) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((abiEncodedFieldNames)));
  }

  /**
   * @notice Get the length of abiEncodedFieldNames.
   */
  function lengthAbiEncodedFieldNames(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of abiEncodedFieldNames.
   */
  function _lengthAbiEncodedFieldNames(ResourceId tableId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of abiEncodedFieldNames.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemAbiEncodedFieldNames(ResourceId tableId, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of abiEncodedFieldNames.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemAbiEncodedFieldNames(ResourceId tableId, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Push a slice to abiEncodedFieldNames.
   */
  function pushAbiEncodedFieldNames(ResourceId tableId, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to abiEncodedFieldNames.
   */
  function _pushAbiEncodedFieldNames(ResourceId tableId, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from abiEncodedFieldNames.
   */
  function popAbiEncodedFieldNames(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from abiEncodedFieldNames.
   */
  function _popAbiEncodedFieldNames(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Update a slice of abiEncodedFieldNames at `_index`.
   */
  function updateAbiEncodedFieldNames(ResourceId tableId, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of abiEncodedFieldNames at `_index`.
   */
  function _updateAbiEncodedFieldNames(ResourceId tableId, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(ResourceId tableId) internal view returns (TablesData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(ResourceId tableId) internal view returns (TablesData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    ResourceId tableId,
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    bytes memory abiEncodedKeyNames,
    bytes memory abiEncodedFieldNames
  ) internal {
    bytes memory _staticData = encodeStatic(fieldLayout, keySchema, valueSchema);

    EncodedLengths _encodedLengths = encodeLengths(abiEncodedKeyNames, abiEncodedFieldNames);
    bytes memory _dynamicData = encodeDynamic(abiEncodedKeyNames, abiEncodedFieldNames);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    ResourceId tableId,
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    bytes memory abiEncodedKeyNames,
    bytes memory abiEncodedFieldNames
  ) internal {
    bytes memory _staticData = encodeStatic(fieldLayout, keySchema, valueSchema);

    EncodedLengths _encodedLengths = encodeLengths(abiEncodedKeyNames, abiEncodedFieldNames);
    bytes memory _dynamicData = encodeDynamic(abiEncodedKeyNames, abiEncodedFieldNames);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(ResourceId tableId, TablesData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.fieldLayout, _table.keySchema, _table.valueSchema);

    EncodedLengths _encodedLengths = encodeLengths(_table.abiEncodedKeyNames, _table.abiEncodedFieldNames);
    bytes memory _dynamicData = encodeDynamic(_table.abiEncodedKeyNames, _table.abiEncodedFieldNames);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(ResourceId tableId, TablesData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.fieldLayout, _table.keySchema, _table.valueSchema);

    EncodedLengths _encodedLengths = encodeLengths(_table.abiEncodedKeyNames, _table.abiEncodedFieldNames);
    bytes memory _dynamicData = encodeDynamic(_table.abiEncodedKeyNames, _table.abiEncodedFieldNames);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (FieldLayout fieldLayout, Schema keySchema, Schema valueSchema) {
    fieldLayout = FieldLayout.wrap(Bytes.getBytes32(_blob, 0));

    keySchema = Schema.wrap(Bytes.getBytes32(_blob, 32));

    valueSchema = Schema.wrap(Bytes.getBytes32(_blob, 64));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (bytes memory abiEncodedKeyNames, bytes memory abiEncodedFieldNames) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    abiEncodedKeyNames = (bytes(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    abiEncodedFieldNames = (bytes(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (TablesData memory _table) {
    (_table.fieldLayout, _table.keySchema, _table.valueSchema) = decodeStatic(_staticData);

    (_table.abiEncodedKeyNames, _table.abiEncodedFieldNames) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId tableId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(fieldLayout, keySchema, valueSchema);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    bytes memory abiEncodedKeyNames,
    bytes memory abiEncodedFieldNames
  ) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(bytes(abiEncodedKeyNames).length, bytes(abiEncodedFieldNames).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(
    bytes memory abiEncodedKeyNames,
    bytes memory abiEncodedFieldNames
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(bytes((abiEncodedKeyNames)), bytes((abiEncodedFieldNames)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    FieldLayout fieldLayout,
    Schema keySchema,
    Schema valueSchema,
    bytes memory abiEncodedKeyNames,
    bytes memory abiEncodedFieldNames
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(fieldLayout, keySchema, valueSchema);

    EncodedLengths _encodedLengths = encodeLengths(abiEncodedKeyNames, abiEncodedFieldNames);
    bytes memory _dynamicData = encodeDynamic(abiEncodedKeyNames, abiEncodedFieldNames);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId tableId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(tableId);

    return _keyTuple;
  }
}

// node_modules/@eveworld/world/src/codegen/tables/CharactersTable.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

struct CharactersTableData {
  address characterAddress;
  uint256 corpId;
  uint256 createdAt;
}

library CharactersTable {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "eveworld", name: "CharactersTable", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x7462657665776f726c64000000000000436861726163746572735461626c6500);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0054030014202000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (uint256)
  Schema constant _keySchema = Schema.wrap(0x002001001f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (address, uint256, uint256)
  Schema constant _valueSchema = Schema.wrap(0x00540300611f1f00000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "characterId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "characterAddress";
    fieldNames[1] = "corpId";
    fieldNames[2] = "createdAt";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get characterAddress.
   */
  function getCharacterAddress(uint256 characterId) internal view returns (address characterAddress) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get characterAddress.
   */
  function _getCharacterAddress(uint256 characterId) internal view returns (address characterAddress) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set characterAddress.
   */
  function setCharacterAddress(uint256 characterId, address characterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((characterAddress)), _fieldLayout);
  }

  /**
   * @notice Set characterAddress.
   */
  function _setCharacterAddress(uint256 characterId, address characterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((characterAddress)), _fieldLayout);
  }

  /**
   * @notice Get corpId.
   */
  function getCorpId(uint256 characterId) internal view returns (uint256 corpId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get corpId.
   */
  function _getCorpId(uint256 characterId) internal view returns (uint256 corpId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set corpId.
   */
  function setCorpId(uint256 characterId, uint256 corpId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((corpId)), _fieldLayout);
  }

  /**
   * @notice Set corpId.
   */
  function _setCorpId(uint256 characterId, uint256 corpId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((corpId)), _fieldLayout);
  }

  /**
   * @notice Get createdAt.
   */
  function getCreatedAt(uint256 characterId) internal view returns (uint256 createdAt) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get createdAt.
   */
  function _getCreatedAt(uint256 characterId) internal view returns (uint256 createdAt) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set createdAt.
   */
  function setCreatedAt(uint256 characterId, uint256 createdAt) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((createdAt)), _fieldLayout);
  }

  /**
   * @notice Set createdAt.
   */
  function _setCreatedAt(uint256 characterId, uint256 createdAt) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((createdAt)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(uint256 characterId) internal view returns (CharactersTableData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(uint256 characterId) internal view returns (CharactersTableData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(uint256 characterId, address characterAddress, uint256 corpId, uint256 createdAt) internal {
    bytes memory _staticData = encodeStatic(characterAddress, corpId, createdAt);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(uint256 characterId, address characterAddress, uint256 corpId, uint256 createdAt) internal {
    bytes memory _staticData = encodeStatic(characterAddress, corpId, createdAt);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(uint256 characterId, CharactersTableData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.characterAddress, _table.corpId, _table.createdAt);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(uint256 characterId, CharactersTableData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.characterAddress, _table.corpId, _table.createdAt);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (address characterAddress, uint256 corpId, uint256 createdAt) {
    characterAddress = (address(Bytes.getBytes20(_blob, 0)));

    corpId = (uint256(Bytes.getBytes32(_blob, 20)));

    createdAt = (uint256(Bytes.getBytes32(_blob, 52)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths,
    bytes memory
  ) internal pure returns (CharactersTableData memory _table) {
    (_table.characterAddress, _table.corpId, _table.createdAt) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(uint256 characterId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(uint256 characterId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    address characterAddress,
    uint256 corpId,
    uint256 createdAt
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(characterAddress, corpId, createdAt);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    address characterAddress,
    uint256 corpId,
    uint256 createdAt
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(characterAddress, corpId, createdAt);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(uint256 characterId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(characterId));

    return _keyTuple;
  }
}

// src/codegen/tables/GateAccess.sol

/* Autogenerated file. Do not edit manually. */

// Import store internals

library GateAccess {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "rohan0", name: "GateAccess", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x7462726f68616e30000000000000000047617465416363657373000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0020010020000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (uint256)
  Schema constant _keySchema = Schema.wrap(0x002001001f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint256)
  Schema constant _valueSchema = Schema.wrap(0x002001001f000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "smartObjectId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "corp";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get corp.
   */
  function getCorp(uint256 smartObjectId) internal view returns (uint256 corp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get corp.
   */
  function _getCorp(uint256 smartObjectId) internal view returns (uint256 corp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get corp.
   */
  function get(uint256 smartObjectId) internal view returns (uint256 corp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get corp.
   */
  function _get(uint256 smartObjectId) internal view returns (uint256 corp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set corp.
   */
  function setCorp(uint256 smartObjectId, uint256 corp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((corp)), _fieldLayout);
  }

  /**
   * @notice Set corp.
   */
  function _setCorp(uint256 smartObjectId, uint256 corp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((corp)), _fieldLayout);
  }

  /**
   * @notice Set corp.
   */
  function set(uint256 smartObjectId, uint256 corp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((corp)), _fieldLayout);
  }

  /**
   * @notice Set corp.
   */
  function _set(uint256 smartObjectId, uint256 corp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((corp)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(uint256 smartObjectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(uint256 smartObjectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint256 corp) internal pure returns (bytes memory) {
    return abi.encodePacked(corp);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(uint256 corp) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(corp);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(uint256 smartObjectId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    return _keyTuple;
  }
}

// node_modules/@latticexyz/world/src/WorldContext.sol

// The context size is 20 bytes for msg.sender, and 32 bytes for msg.value
uint256 constant CONTEXT_BYTES = 20 + 32;

/**
 * @title WorldContextConsumer - Extracting trusted context values from appended calldata.
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This contract is designed to extract trusted context values (like msg.sender and msg.value)
 * from the appended calldata. It provides mechanisms similar to EIP-2771 (https://eips.ethereum.org/EIPS/eip-2771),
 * but allowing any contract to be the trusted forwarder.
 * @dev This contract should only be used for contracts without their own storage, like Systems.
 */
abstract contract WorldContextConsumer is IWorldContextConsumer {
  /**
   * @notice Extract the `msg.sender` from the context appended to the calldata.
   * @return sender The `msg.sender` in the call to the World contract before the World routed the
   * call to the WorldContextConsumer contract.
   */
  function _msgSender() public view returns (address sender) {
    return WorldContextConsumerLib._msgSender();
  }

  /**
   * @notice Extract the `msg.value` from the context appended to the calldata.
   * @return value The `msg.value` in the call to the World contract before the World routed the
   * call to the WorldContextConsumer contract.
   */
  function _msgValue() public pure returns (uint256 value) {
    return WorldContextConsumerLib._msgValue();
  }

  /**
   * @notice Get the address of the World contract that routed the call to this WorldContextConsumer.
   * @return The address of the World contract that routed the call to this WorldContextConsumer.
   */
  function _world() public view returns (address) {
    return WorldContextConsumerLib._world();
  }

  /**
   * @notice Checks if an interface is supported by the contract.
   * using ERC-165 supportsInterface (see https://eips.ethereum.org/EIPS/eip-165)
   * @param interfaceId The ID of the interface in question.
   * @return True if the interface is supported, false otherwise.
   */
  function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool) {
    return interfaceId == type(IWorldContextConsumer).interfaceId || interfaceId == type(IERC165_1).interfaceId;
  }
}

/**
 * @title WorldContextConsumerLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice Helpers for working with data in the context of calling a World
 */
library WorldContextConsumerLib {
  /**
   * @notice Extract the `msg.sender` from the context appended to the calldata.
   * @return sender The `msg.sender` in the call to the World contract before the World routed the
   * call to the WorldContextConsumer contract.
   */
  function _msgSender() internal view returns (address sender) {
    assembly {
      // Load 32 bytes from calldata at position calldatasize() - context size,
      // then shift left 96 bits (to right-align the address)
      // 96 = 256 - 20 * 8
      sender := shr(0x60, calldataload(sub(calldatasize(), CONTEXT_BYTES)))
    }
    if (sender == address(0)) sender = msg.sender;
  }

  /**
   * @notice Extract the `msg.value` from the context appended to the calldata.
   * @return value The `msg.value` in the call to the World contract before the World routed the
   * call to the WorldContextConsumer contract.
   */
  function _msgValue() internal pure returns (uint256 value) {
    assembly {
      // Load 32 bytes from calldata at position calldatasize() - 32 bytes,
      value := calldataload(sub(calldatasize(), 0x20))
    }
  }

  /**
   * @notice Get the address of the World contract that routed the call to this WorldContextConsumer.
   * @return The address of the World contract that routed the call to this WorldContextConsumer.
   */
  function _world() internal view returns (address) {
    return StoreSwitch.getStoreAddress();
  }
}

/**
 * @title WorldContextProviderLib - Utility functions to call contracts with context values appended to calldata.
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This library provides functions to make calls or delegatecalls to other contracts,
 * appending the context values (like msg.sender and msg.value) to the calldata for WorldContextConsumer to consume.
 */
library WorldContextProviderLib {
  /**
   * @notice Appends context values to the given calldata.
   * @param callData The original calldata.
   * @param msgSender The address of the transaction sender.
   * @param msgValue The amount of ether sent with the original transaction.
   * @return The new calldata with context values appended.
   */
  function appendContext(
    bytes memory callData,
    address msgSender,
    uint256 msgValue
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(callData, msgSender, msgValue);
  }

  /**
   * @notice Makes a call to the target contract with context values appended to the calldata.
   * @param msgSender The address of the transaction sender.
   * @param msgValue The amount of ether sent with the original transaction.
   * @param target The address of the contract to call.
   * @param callData The calldata for the call.
   * @return success A boolean indicating whether the call was successful or not.
   * @return data The abi encoded return data from the call.
   */
  function callWithContext(
    address msgSender,
    uint256 msgValue,
    address target,
    bytes memory callData
  ) internal returns (bool success, bytes memory data) {
    (success, data) = target.call{ value: 0 }(
      appendContext({ callData: callData, msgSender: msgSender, msgValue: msgValue })
    );
  }

  /**
   * @notice Makes a delegatecall to the target contract with context values appended to the calldata.
   * @param msgSender The address of the transaction sender.
   * @param msgValue The amount of ether sent with the original transaction.
   * @param target The address of the contract to call.
   * @param callData The calldata for the call.
   * @return success A boolean indicating whether the call was successful or not.
   * @return data The abi encoded return data from the call.
   */
  function delegatecallWithContext(
    address msgSender,
    uint256 msgValue,
    address target,
    bytes memory callData
  ) internal returns (bool success, bytes memory data) {
    (success, data) = target.delegatecall(
      appendContext({ callData: callData, msgSender: msgSender, msgValue: msgValue })
    );
  }

  /**
   * @notice Makes a call to the target contract with context values appended to the calldata.
   * @dev Revert in the case of failure.
   * @param msgSender The address of the transaction sender.
   * @param msgValue The amount of ether sent with the original transaction.
   * @param target The address of the contract to call.
   * @param callData The calldata for the call.
   * @return data The abi encoded return data from the call.
   */
  function callWithContextOrRevert(
    address msgSender,
    uint256 msgValue,
    address target,
    bytes memory callData
  ) internal returns (bytes memory data) {
    (bool success, bytes memory _data) = callWithContext({
      msgSender: msgSender,
      msgValue: msgValue,
      target: target,
      callData: callData
    });
    if (!success) revertWithBytes(_data);
    return _data;
  }

  /**
   * @notice Makes a delegatecall to the target contract with context values appended to the calldata.
   * @dev Revert in the case of failure.
   * @param msgSender The address of the transaction sender.
   * @param msgValue The amount of ether sent with the original transaction.
   * @param target The address of the contract to call.
   * @param callData The calldata for the call.
   * @return data The abi encoded return data from the call.
   */
  function delegatecallWithContextOrRevert(
    address msgSender,
    uint256 msgValue,
    address target,
    bytes memory callData
  ) internal returns (bytes memory data) {
    (bool success, bytes memory _data) = delegatecallWithContext({
      msgSender: msgSender,
      msgValue: msgValue,
      target: target,
      callData: callData
    });
    if (!success) revertWithBytes(_data);
    return _data;
  }
}

// node_modules/@latticexyz/world/src/System.sol

/**
 * @title System
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev The System contract currently acts as an alias for `WorldContextConsumer`.
 * This structure is chosen for potential extensions in the future, where default functionality might be added to the System.
 */
contract System is WorldContextConsumer {
  // Currently, no additional functionality is added. Future enhancements can be introduced here.
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IWorldRegistrationSystem.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IWorldRegistrationSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IWorldRegistrationSystem {
  function registerNamespace(ResourceId namespaceId) external;

  function registerSystemHook(ResourceId systemId, ISystemHook hookAddress, uint8 enabledHooksBitmap) external;

  function unregisterSystemHook(ResourceId systemId, ISystemHook hookAddress) external;

  function registerSystem(ResourceId systemId, System system, bool publicAccess) external;

  function registerFunctionSelector(
    ResourceId systemId,
    string memory systemFunctionSignature
  ) external returns (bytes4 worldFunctionSelector);

  function registerRootFunctionSelector(
    ResourceId systemId,
    string memory worldFunctionSignature,
    string memory systemFunctionSignature
  ) external returns (bytes4 worldFunctionSelector);

  function registerDelegation(address delegatee, ResourceId delegationControlId, bytes memory initCallData) external;

  function unregisterDelegation(address delegatee) external;

  function registerNamespaceDelegation(
    ResourceId namespaceId,
    ResourceId delegationControlId,
    bytes memory initCallData
  ) external;

  function unregisterNamespaceDelegation(ResourceId namespaceId) external;
}

// node_modules/@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol

/* Autogenerated file. Do not edit manually. */

/**
 * @title IBaseWorld
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface integrates all systems and associated function selectors
 * that are dynamically registered in the World during deployment.
 * @dev This is an autogenerated file; do not edit manually.
 */
interface IBaseWorld is
  IStore,
  IWorldKernel,
  IRegistrationSystem,
  IAccessManagementSystem,
  IBalanceTransferSystem,
  IBatchCallSystem,
  IModuleInstallationSystem,
  IWorldRegistrationSystem
{}

// src/systems/SmartGateSystem.sol

/**
 * @dev This contract is an example for implementing logic to a smart gate
 */
contract SmartGateSystem is System {
  function canJump(uint256 characterId, uint256 sourceGateId, uint256 destinationGateId) public view returns (bool) {
    //Get the allowed corp
    uint256 allowedCorp = GateAccess.get(sourceGateId);

    //Get the character corp
    uint256 characterCorp = CharactersTable.getCorpId(characterId);

    //If the corp is the same, allow jumps
    if(allowedCorp == characterCorp){
      return true;
    } else{
      return false;
    }    
  }

  function setAllowedCorp(uint256 sourceGateId, uint256 corpID) public {
    GateAccess.set(sourceGateId, corpID);
  }
}

