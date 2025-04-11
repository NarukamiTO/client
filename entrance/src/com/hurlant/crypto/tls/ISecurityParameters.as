package com.hurlant.crypto.tls {
  import flash.utils.ByteArray;

  public interface ISecurityParameters {
    function get version() : uint;
    function reset() : void;
    function getBulkCipher() : uint;
    function getCipherType() : uint;
    function getMacAlgorithm() : uint;
    function setCipher(param1:uint) : void;
    function setCompression(param1:uint) : void;
    function setPreMasterSecret(param1:ByteArray) : void;
    function setClientRandom(param1:ByteArray) : void;
    function setServerRandom(param1:ByteArray) : void;
    function get useRSA() : Boolean;
    function computeVerifyData(param1:uint, param2:ByteArray) : ByteArray;
    function computeCertificateVerify(param1:uint, param2:ByteArray) : ByteArray;
    function getConnectionStates() : Object;
  }
}
