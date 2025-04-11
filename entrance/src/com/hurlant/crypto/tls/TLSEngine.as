package com.hurlant.crypto.tls {
  import alternativa.osgi.service.clientlog.IClientLog;
  import com.hurlant.crypto.cert.X509Certificate;
  import com.hurlant.crypto.cert.X509CertificateCollection;
  import com.hurlant.crypto.prng.Random;
  import com.hurlant.util.ArrayUtil;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.ProgressEvent;
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;

  [Event(name="data",type="com.hurlant.crypto.tls.TLSEvent")]
  [Event(name="ready",type="com.hurlant.crypto.tls.TLSEvent")]
  [Event(name="socketData",type="flash.events.ProgressEvent")]
  [Event(name="close",type="flash.events.Event")]
  public class TLSEngine extends EventDispatcher {
    [Inject]
    public static var clientLog:IClientLog;

    public static const LOG_CHANNEL:String = "tlsengine";
    public static const SERVER:uint = 0;
    public static const CLIENT:uint = 1;

    private static const PROTOCOL_HANDSHAKE:uint = 22;
    private static const PROTOCOL_ALERT:uint = 21;
    private static const PROTOCOL_CHANGE_CIPHER_SPEC:uint = 20;
    private static const PROTOCOL_APPLICATION_DATA:uint = 23;
    private static const STATE_NEW:uint = 0;
    private static const STATE_NEGOTIATING:uint = 1;
    private static const STATE_READY:uint = 2;
    private static const STATE_CLOSED:uint = 3;
    private static const HANDSHAKE_HELLO_REQUEST:uint = 0;
    private static const HANDSHAKE_CLIENT_HELLO:uint = 1;
    private static const HANDSHAKE_SERVER_HELLO:uint = 2;
    private static const HANDSHAKE_CERTIFICATE:uint = 11;
    private static const HANDSHAKE_SERVER_KEY_EXCHANGE:uint = 12;
    private static const HANDSHAKE_CERTIFICATE_REQUEST:uint = 13;
    private static const HANDSHAKE_HELLO_DONE:uint = 14;
    private static const HANDSHAKE_CERTIFICATE_VERIFY:uint = 15;
    private static const HANDSHAKE_CLIENT_KEY_EXCHANGE:uint = 16;
    private static const HANDSHAKE_FINISHED:uint = 20;

    public var protocol_version:uint;

    private var _entity:uint;
    private var _config:TLSConfig;
    private var _state:uint;
    private var _securityParameters:ISecurityParameters;
    private var _currentReadState:IConnectionState;
    private var _currentWriteState:IConnectionState;
    private var _pendingReadState:IConnectionState;
    private var _pendingWriteState:IConnectionState;
    private var _handshakePayloads:ByteArray;
    private var _handshakeRecords:ByteArray;
    private var _iStream:IDataInput;
    private var _oStream:IDataOutput;
    private var _store:X509CertificateCollection;
    private var _otherCertificate:X509Certificate;
    private var _otherIdentity:String;
    private var _myCertficate:X509Certificate;
    private var _myIdentity:String;
    private var _packetQueue:Array = [];
    private var protocolHandlers:Object;
    private var handshakeHandlersServer:Object;
    private var handshakeHandlersClient:Object;
    private var _entityHandshakeHandlers:Object;
    private var _handshakeCanContinue:Boolean = true;
    private var _handshakeQueue:Array = [];
    private var sendClientCert:Boolean = false;
    private var _writeScheduler:uint;

    public function TLSEngine(param1:TLSConfig, param2:IDataInput, param3:IDataOutput, param4:String = null) {
      this.protocolHandlers = {
        23:this.parseApplicationData,
        22:this.parseHandshake,
        21:this.parseAlert,
        20:this.parseChangeCipherSpec
      };
      this.handshakeHandlersServer = {
        0:this.notifyStateError,
        1:this.parseHandshakeClientHello,
        2:this.notifyStateError,
        11:this.loadCertificates,
        12:this.notifyStateError,
        13:this.notifyStateError,
        14:this.notifyStateError,
        15:this.notifyStateError,
        16:this.parseHandshakeClientKeyExchange,
        20:this.verifyHandshake
      };
      this.handshakeHandlersClient = {
        0:this.parseHandshakeHello,
        1:this.notifyStateError,
        2:this.parseHandshakeServerHello,
        11:this.loadCertificates,
        12:this.parseServerKeyExchange,
        13:this.setStateRespondWithCertificate,
        14:this.sendClientAck,
        15:this.notifyStateError,
        16:this.notifyStateError,
        20:this.verifyHandshake
      };
      super();
      this._entity = param1.entity;
      this._config = param1;
      this._iStream = param2;
      this._oStream = param3;
      this._otherIdentity = param4;
      this._state = STATE_NEW;
      this._entityHandshakeHandlers = this._entity == CLIENT ? this.handshakeHandlersClient : this.handshakeHandlersServer;
      if(this._config.version == SSLSecurityParameters.PROTOCOL_VERSION) {
        this._securityParameters = new SSLSecurityParameters(this._entity);
      } else {
        this._securityParameters = new TLSSecurityParameters(this._entity,this._config.certificate,this._config.privateKey);
      }
      this.protocol_version = this._config.version;
      var local5:Object = this._securityParameters.getConnectionStates();
      this._currentReadState = local5.read;
      this._currentWriteState = local5.write;
      this._handshakePayloads = new ByteArray();
      this._store = new X509CertificateCollection();
    }

    public function get peerCertificate() : X509Certificate {
      return this._otherCertificate;
    }

    public function start() : void {
      if(this._entity == CLIENT) {
        try {
          this.startHandshake();
        }
        catch(e:TLSError) {
          handleTLSError(e);
        }
      }
    }

    public function dataAvailable(param1:* = null) : void {
      var e:* = param1;
      if(this._state == STATE_CLOSED) {
        return;
      }
      try {
        this.parseRecord(this._iStream);
      }
      catch(e:TLSError) {
        handleTLSError(e);
      }
    }

    public function close(param1:TLSError = null) : void {
      if(this._state == STATE_CLOSED) {
        return;
      }
      var local2:ByteArray = new ByteArray();
      if(param1 == null && this._state != STATE_READY) {
        local2[0] = 1;
        local2[1] = TLSError.user_canceled;
        this.sendRecord(PROTOCOL_ALERT,local2);
      }
      local2[0] = 2;
      if(param1 == null) {
        local2[1] = TLSError.close_notify;
      } else {
        local2[1] = param1.errorID;
      }
      this.sendRecord(PROTOCOL_ALERT,local2);
      this._state = STATE_CLOSED;
      dispatchEvent(new Event(Event.CLOSE));
    }

    private function parseRecord(param1:IDataInput) : void {
      var local2:ByteArray = null;
      var local3:uint = 0;
      var local4:uint = 0;
      var local5:uint = 0;
      var local6:uint = 0;
      var local7:Object = null;
      while(this._state != STATE_CLOSED && param1.bytesAvailable > 4) {
        if(this._packetQueue.length > 0) {
          local7 = this._packetQueue.shift();
          local2 = local7.data;
          if(param1.bytesAvailable + local2.length >= local7.length) {
            param1.readBytes(local2,local2.length,local7.length - local2.length);
            this.parseOneRecord(local7.type,local7.length,local2);
          } else {
            param1.readBytes(local2,local2.length,param1.bytesAvailable);
            this._packetQueue.push(local7);
          }
        } else {
          local3 = uint(param1.readByte());
          local4 = uint(param1.readShort());
          local5 = uint(param1.readShort());
          if(local5 > 16384 + 2048) {
            throw new TLSError("Excessive TLS Record length: " + local5,TLSError.record_overflow);
          }
          if(local4 != this._securityParameters.version) {
            throw new TLSError("Unsupported TLS version: " + local4.toString(16),TLSError.protocol_version);
          }
          local2 = new ByteArray();
          local6 = Math.min(param1.bytesAvailable,local5);
          param1.readBytes(local2,0,local6);
          if(local6 == local5) {
            this.parseOneRecord(local3,local5,local2);
          } else {
            this._packetQueue.push({
              "type":local3,
              "length":local5,
              "data":local2
            });
          }
        }
      }
    }

    private function parseOneRecord(param1:uint, param2:uint, param3:ByteArray) : void {
      param3 = this._currentReadState.decrypt(param1,param2,param3);
      if(param3.length > 16384) {
        throw new TLSError("Excessive Decrypted TLS Record length: " + param3.length,TLSError.record_overflow);
      }
      if(this.protocolHandlers.hasOwnProperty(param1)) {
        while(param3 != null) {
          param3 = this.protocolHandlers[param1](param3);
        }
        return;
      }
      throw new TLSError("Unsupported TLS Record Content Type: " + param1.toString(16),TLSError.unexpected_message);
    }

    private function startHandshake() : void {
      this._state = STATE_NEGOTIATING;
      this.sendClientHello();
    }

    private function parseHandshake(param1:ByteArray) : ByteArray {
      var local6:ByteArray = null;
      if(param1.length < 4) {
        return null;
      }
      param1.position = 0;
      var local2:ByteArray = param1;
      var local3:uint = local2.readUnsignedByte();
      var local4:uint = local2.readUnsignedByte();
      var local5:uint = uint(local4 << 16 | local2.readUnsignedShort());
      if(local5 + 4 > param1.length) {
        return null;
      }
      if(local3 != HANDSHAKE_FINISHED) {
        this._handshakePayloads.writeBytes(param1,0,local5 + 4);
      }
      if(this._entityHandshakeHandlers.hasOwnProperty(local3)) {
        if(this._entityHandshakeHandlers[local3] is Function) {
          this._entityHandshakeHandlers[local3](local2);
        }
        if(local5 + 4 < param1.length) {
          local6 = new ByteArray();
          local6.writeBytes(param1,local5 + 4,param1.length - (local5 + 4));
          return local6;
        }
        return null;
      }
      throw new TLSError("Unimplemented or unknown handshake type!",TLSError.internal_error);
    }

    private function notifyStateError(param1:ByteArray) : void {
      throw new TLSError("Invalid handshake state for a TLS Entity type of " + this._entity,TLSError.internal_error);
    }

    private function parseClientKeyExchange(param1:ByteArray) : void {
      throw new TLSError("ClientKeyExchange is currently unimplemented!",TLSError.internal_error);
    }

    private function parseServerKeyExchange(param1:ByteArray) : void {
      throw new TLSError("ServerKeyExchange is currently unimplemented!",TLSError.internal_error);
    }

    private function verifyHandshake(param1:ByteArray) : void {
      var local2:ByteArray = new ByteArray();
      if(this._securityParameters.version == SSLSecurityParameters.PROTOCOL_VERSION) {
        param1.readBytes(local2,0,36);
      } else {
        param1.readBytes(local2,0,12);
      }
      var local3:ByteArray = this._securityParameters.computeVerifyData(1 - this._entity,this._handshakePayloads);
      if(ArrayUtil.equals(local2,local3)) {
        this._state = STATE_READY;
        dispatchEvent(new TLSEvent(TLSEvent.READY));
        return;
      }
      throw new TLSError("Invalid Finished mac.",TLSError.bad_record_mac);
    }

    private function parseHandshakeHello(param1:ByteArray) : void {
      if(this._state != STATE_READY) {
        return;
      }
      this._handshakePayloads = new ByteArray();
      this.startHandshake();
    }

    private function parseHandshakeClientKeyExchange(param1:ByteArray) : void {
      var local2:uint = 0;
      var local3:ByteArray = null;
      var local4:ByteArray = null;
      var local5:Object = null;
      if(this._securityParameters.useRSA) {
        local2 = uint(param1.readShort());
        local3 = new ByteArray();
        param1.readBytes(local3,0,local2);
        local4 = new ByteArray();
        this._config.privateKey.decrypt(local3,local4,local2);
        this._securityParameters.setPreMasterSecret(local4);
        local5 = this._securityParameters.getConnectionStates();
        this._pendingReadState = local5.read;
        this._pendingWriteState = local5.write;
        return;
      }
      throw new TLSError("parseHandshakeClientKeyExchange not implemented for DH modes.",TLSError.internal_error);
    }

    private function parseHandshakeServerHello(param1:IDataInput) : void {
      var local2:uint = uint(param1.readShort());
      if(local2 != this._securityParameters.version) {
        throw new TLSError("Unsupported TLS version: " + local2.toString(16),TLSError.protocol_version);
      }
      var local3:ByteArray = new ByteArray();
      param1.readBytes(local3,0,32);
      var local4:uint = uint(param1.readByte());
      var local5:ByteArray = new ByteArray();
      if(local4 > 0) {
        param1.readBytes(local5,0,local4);
      }
      this._securityParameters.setCipher(param1.readShort());
      this._securityParameters.setCompression(param1.readByte());
      this._securityParameters.setServerRandom(local3);
    }

    private function parseHandshakeClientHello(param1:IDataInput) : void {
      var local2:Object = null;
      var local14:uint = 0;
      var local15:uint = 0;
      var local16:uint = 0;
      var local17:ByteArray = null;
      var local3:uint = uint(param1.readShort());
      if(local3 != this._securityParameters.version) {
        throw new TLSError("Unsupported TLS version: " + local3.toString(16),TLSError.protocol_version);
      }
      var local4:ByteArray = new ByteArray();
      param1.readBytes(local4,0,32);
      var local5:uint = uint(param1.readByte());
      var local6:ByteArray = new ByteArray();
      if(local5 > 0) {
        param1.readBytes(local6,0,local5);
      }
      var local7:Array = [];
      var local8:uint = uint(param1.readShort());
      var local9:uint = 0;
      while(local9 < local8 / 2) {
        local7.push(param1.readShort());
        local9++;
      }
      var local10:Array = [];
      var local11:uint = uint(param1.readByte());
      local9 = 0;
      while(local9 < local11) {
        local10.push(param1.readByte());
        local9++;
      }
      local2 = {
        "random":local4,
        "session":local6,
        "suites":local7,
        "compressions":local10
      };
      var local12:uint = uint(2 + 32 + 1 + local5 + 2 + local8 + 1 + local11);
      var local13:Array = [];
      if(local12 < length) {
        local14 = uint(param1.readShort());
        while(local14 > 0) {
          local15 = uint(param1.readShort());
          local16 = uint(param1.readShort());
          local17 = new ByteArray();
          param1.readBytes(local17,0,local16);
          local14 -= 4 + local16;
          local13.push({
            "type":local15,
            "length":local16,
            "data":local17
          });
        }
      }
      local2.ext = local13;
      this.sendServerHello(local2);
      this.sendCertificate();
      this.sendServerHelloDone();
    }

    private function sendClientHello() : void {
      var local1:ByteArray = new ByteArray();
      local1.writeShort(this._securityParameters.version);
      var local2:Random = new Random();
      var local3:ByteArray = new ByteArray();
      local2.nextBytes(local3,32);
      this._securityParameters.setClientRandom(local3);
      local1.writeBytes(local3,0,32);
      local1.writeByte(32);
      local2.nextBytes(local1,32);
      var local4:Array = this._config.cipherSuites;
      local1.writeShort(2 * local4.length);
      var local5:int = 0;
      while(local5 < local4.length) {
        local1.writeShort(local4[local5]);
        local5++;
      }
      local4 = this._config.compressions;
      local1.writeByte(local4.length);
      local5 = 0;
      while(local5 < local4.length) {
        local1.writeByte(local4[local5]);
        local5++;
      }
      local1.position = 0;
      this.sendHandshake(HANDSHAKE_CLIENT_HELLO,local1.length,local1);
    }

    private function findMatch(param1:Array, param2:Array) : int {
      var local4:uint = 0;
      var local3:int = 0;
      while(local3 < param1.length) {
        local4 = uint(param1[local3]);
        if(param2.indexOf(local4) > -1) {
          return local4;
        }
        local3++;
      }
      return -1;
    }

    private function sendServerHello(param1:Object) : void {
      var local2:int = this.findMatch(this._config.cipherSuites,param1.suites);
      if(local2 == -1) {
        throw new TLSError("No compatible cipher found.",TLSError.handshake_failure);
      }
      this._securityParameters.setCipher(local2);
      var local3:int = this.findMatch(this._config.compressions,param1.compressions);
      if(local3 == 1) {
        throw new TLSError("No compatible compression method found.",TLSError.handshake_failure);
      }
      this._securityParameters.setCompression(local3);
      this._securityParameters.setClientRandom(param1.random);
      var local4:ByteArray = new ByteArray();
      local4.writeShort(this._securityParameters.version);
      var local5:Random = new Random();
      var local6:ByteArray = new ByteArray();
      local5.nextBytes(local6,32);
      this._securityParameters.setServerRandom(local6);
      local4.writeBytes(local6,0,32);
      local4.writeByte(32);
      local5.nextBytes(local4,32);
      local4.writeShort(param1.suites[0]);
      local4.writeByte(param1.compressions[0]);
      local4.position = 0;
      this.sendHandshake(HANDSHAKE_SERVER_HELLO,local4.length,local4);
    }

    private function setStateRespondWithCertificate(param1:ByteArray = null) : void {
      this.sendClientCert = true;
    }

    private function sendCertificate(param1:ByteArray = null) : void {
      var local3:uint = 0;
      var local4:uint = 0;
      var local2:ByteArray = this._config.certificate;
      var local5:ByteArray = new ByteArray();
      if(local2 != null) {
        local3 = local2.length;
        local4 = uint(local2.length + 3);
        local5.writeByte(local4 >> 16);
        local5.writeShort(local4 & 0xFFFF);
        local5.writeByte(local3 >> 16);
        local5.writeShort(local3 & 0xFFFF);
        local5.writeBytes(local2);
      } else {
        local5.writeShort(0);
        local5.writeByte(0);
      }
      local5.position = 0;
      this.sendHandshake(HANDSHAKE_CERTIFICATE,local5.length,local5);
    }

    private function sendCertificateVerify() : void {
      var local1:ByteArray = new ByteArray();
      var local2:ByteArray = this._securityParameters.computeCertificateVerify(this._entity,this._handshakePayloads);
      local2.position = 0;
      this.sendHandshake(HANDSHAKE_CERTIFICATE_VERIFY,local2.length,local2);
    }

    private function sendServerHelloDone() : void {
      var local1:ByteArray = new ByteArray();
      this.sendHandshake(HANDSHAKE_HELLO_DONE,local1.length,local1);
    }

    private function sendClientKeyExchange() : void {
      var local1:ByteArray = null;
      var local2:Random = null;
      var local3:ByteArray = null;
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local6:Object = null;
      if(this._securityParameters.useRSA) {
        local1 = new ByteArray();
        local1.writeShort(this._securityParameters.version);
        local2 = new Random();
        local2.nextBytes(local1,46);
        local1.position = 0;
        local3 = new ByteArray();
        local3.writeBytes(local1,0,local1.length);
        local3.position = 0;
        this._securityParameters.setPreMasterSecret(local3);
        local4 = new ByteArray();
        this._otherCertificate.getPublicKey().encrypt(local3,local4,local3.length);
        local4.position = 0;
        local5 = new ByteArray();
        if(this._securityParameters.version > 768) {
          local5.writeShort(local4.length);
        }
        local5.writeBytes(local4,0,local4.length);
        local5.position = 0;
        this.sendHandshake(HANDSHAKE_CLIENT_KEY_EXCHANGE,local5.length,local5);
        local6 = this._securityParameters.getConnectionStates();
        this._pendingReadState = local6.read;
        this._pendingWriteState = local6.write;
        return;
      }
      throw new TLSError("Non-RSA Client Key Exchange not implemented.",TLSError.internal_error);
    }

    private function sendFinished() : void {
      var local1:ByteArray = this._securityParameters.computeVerifyData(this._entity,this._handshakePayloads);
      local1.position = 0;
      this.sendHandshake(HANDSHAKE_FINISHED,local1.length,local1);
    }

    private function sendHandshake(param1:uint, param2:uint, param3:IDataInput) : void {
      var local4:ByteArray = new ByteArray();
      local4.writeByte(param1);
      local4.writeByte(0);
      local4.writeShort(param2);
      param3.readBytes(local4,local4.position,param2);
      this._handshakePayloads.writeBytes(local4,0,local4.length);
      this.sendRecord(PROTOCOL_HANDSHAKE,local4);
    }

    private function sendChangeCipherSpec() : void {
      var local1:ByteArray = new ByteArray();
      local1[0] = 1;
      this.sendRecord(PROTOCOL_CHANGE_CIPHER_SPEC,local1);
      this._currentWriteState = this._pendingWriteState;
      this._pendingWriteState = null;
    }

    public function sendApplicationData(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void {
      var local4:ByteArray = new ByteArray();
      var local5:uint = param3;
      if(local5 == 0) {
        local5 = param1.length;
      }
      while(local5 > 16384) {
        local4.position = 0;
        local4.writeBytes(param1,param2,16384);
        local4.position = 0;
        this.sendRecord(PROTOCOL_APPLICATION_DATA,local4);
        param2 += 16384;
        local5 -= 16384;
      }
      local4.position = 0;
      local4.writeBytes(param1,param2,local5);
      local4.position = 0;
      this.sendRecord(PROTOCOL_APPLICATION_DATA,local4);
    }

    private function sendRecord(param1:uint, param2:ByteArray) : void {
      param2 = this._currentWriteState.encrypt(param1,param2);
      this._oStream.writeByte(param1);
      this._oStream.writeShort(this._securityParameters.version);
      this._oStream.writeShort(param2.length);
      this._oStream.writeBytes(param2,0,param2.length);
      this.scheduleWrite();
    }

    private function scheduleWrite() : void {
      if(this._writeScheduler != 0) {
        return;
      }
      this._writeScheduler = setTimeout(this.commitWrite,0);
    }

    private function commitWrite() : void {
      clearTimeout(this._writeScheduler);
      this._writeScheduler = 0;
      if(this._state != STATE_CLOSED) {
        dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA));
      }
    }

    private function sendClientAck(param1:ByteArray) : void {
      if(this._handshakeCanContinue) {
        if(this.sendClientCert) {
          this.sendCertificate();
        }
        this.sendClientKeyExchange();
        if(this._config.certificate != null) {
          this.sendCertificateVerify();
        }
        this.sendChangeCipherSpec();
        this.sendFinished();
      }
    }

    private function loadCertificates(param1:ByteArray) : void {
      var local7:Boolean = false;
      var local8:uint = 0;
      var local9:ByteArray = null;
      var local10:X509Certificate = null;
      var local11:String = null;
      var local12:RegExp = null;
      var local2:uint = uint(param1.readByte());
      var local3:uint = uint(local2 << 16 | param1.readShort());
      var local4:Array = [];
      while(local3 > 0) {
        local2 = uint(param1.readByte());
        local8 = uint(local2 << 16 | param1.readShort());
        local9 = new ByteArray();
        param1.readBytes(local9,0,local8);
        local4.push(local9);
        local3 -= 3 + local8;
      }
      var local5:X509Certificate = null;
      var local6:int = 0;
      while(local6 < local4.length) {
        local10 = new X509Certificate(local4[local6]);
        this._store.addCertificate(local10);
        if(local5 == null) {
          local5 = local10;
        }
        local6++;
      }
      if(this._config.trustAllCertificates) {
        local7 = true;
      } else if(this._config.trustSelfSignedCertificates) {
        local7 = local5.isSelfSigned(new Date());
      } else {
        local7 = local5.isSigned(this._store,this._config.CAStore);
      }
      if(local7) {
        if(this._otherIdentity == null || this._config.ignoreCommonNameMismatch) {
          this._otherCertificate = local5;
        } else {
          local11 = local5.getCommonName();
          local12 = new RegExp(local11.replace(/[\^\\\-$.[\]|()?+{}]/g,"\\$&").replace(/\*/g,"[^.]+"),"gi");
          if(local12.exec(this._otherIdentity)) {
            this._otherCertificate = local5;
          } else {
            if(!this._config.promptUserForAcceptCert) {
              throw new TLSError("Invalid common name: " + local5.getCommonName() + ", expected " + this._otherIdentity,TLSError.bad_certificate);
            }
            this._handshakeCanContinue = false;
            dispatchEvent(new TLSEvent(TLSEvent.PROMPT_ACCEPT_CERT));
          }
        }
      } else {
        if(!this._config.promptUserForAcceptCert) {
          throw new TLSError("Cannot verify certificate",TLSError.bad_certificate);
        }
        this._handshakeCanContinue = false;
        dispatchEvent(new TLSEvent(TLSEvent.PROMPT_ACCEPT_CERT));
      }
    }

    public function acceptPeerCertificate() : void {
      this._handshakeCanContinue = true;
      this.sendClientAck(null);
    }

    public function rejectPeerCertificate() : void {
      throw new TLSError("Peer certificate not accepted!",TLSError.bad_certificate);
    }

    private function parseAlert(param1:ByteArray) : void {
      this.close();
    }

    private function parseChangeCipherSpec(param1:ByteArray) : void {
      param1.readUnsignedByte();
      if(this._pendingReadState == null) {
        throw new TLSError("Not ready to Change Cipher Spec, damnit.",TLSError.unexpected_message);
      }
      this._currentReadState = this._pendingReadState;
      this._pendingReadState = null;
    }

    private function parseApplicationData(param1:ByteArray) : void {
      if(this._state != STATE_READY) {
        throw new TLSError("Too soon for data!",TLSError.unexpected_message);
      }
      dispatchEvent(new TLSEvent(TLSEvent.DATA,param1));
    }

    private function handleTLSError(param1:TLSError) : void {
      this.close(param1);
    }
  }
}
