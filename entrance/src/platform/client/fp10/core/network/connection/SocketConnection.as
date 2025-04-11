package platform.client.fp10.core.network.connection {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.protocol.CompressionType;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import com.hurlant.crypto.tls.TLSConfig;
  import com.hurlant.crypto.tls.TLSEngine;
  import com.hurlant.crypto.tls.TLSSecurityParameters;
  import com.hurlant.crypto.tls.TLSSocket;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.Socket;
  import flash.utils.ByteArray;
  import flash.utils.IDataOutput;
  import platform.client.fp10.core.network.ICommandHandler;
  import platform.client.fp10.core.network.command.IConnectionInitCommand;
  import platform.client.fp10.core.network.connection.protection.PrimitiveProtectionContext;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.errors.CannotEstablishConnectionError;
  import platform.client.fp10.core.service.errormessage.errors.TransportError;
  import platform.client.fp10.core.service.errormessage.errors.UnclassifyedError;

  public class SocketConnection implements IConnection {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var messageBoxService:IErrorMessageService;

    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var networkService:INetworkService;

    protected static var connectionLogger:Logger;
    protected static var networkLogger:Logger;
    protected static var serverCommandLogger:Logger;

    private static const PARAM_CLOSE_ON_ERROR:String = "closeonerror";

    public var host:String;
    public var ports:Vector.<int>;

    protected var portIndex:int;
    protected var connectionStatus:ConnectionStatus;
    protected var protocol:IProtocol;
    protected var commandCodec:ICodec;
    protected var commandHandler:ICommandHandler;
    protected var secure:Boolean;

    private var protectionContext:IProtectionContext;

    protected var rawDataBuffer:ByteArray;

    private var dataBuffer:ByteArray;
    private var currentPacketPosition:int;
    private var socket:Socket;

    public function SocketConnection(param1:ConnectionInitializers) {
      var local2:TLSConfig = null;
      var local3:TLSSocket = null;
      this.connectionStatus = ConnectionStatus.IDLE;
      this.rawDataBuffer = new ByteArray();
      this.dataBuffer = new ByteArray();
      super();
      this.commandCodec = param1.commandCodec;
      this.protocol = param1.protocol;
      this.commandHandler = param1.commandHandler;
      this.secure = param1.secure;
      this.protectionContext = param1.protectionContext;
      initLoggers();
      if(this.secure) {
        local2 = new TLSConfig(TLSEngine.CLIENT);
        local2.version = TLSSecurityParameters.PROTOCOL_VERSION;
        local2.trustAllCertificates = true;
        local2.ignoreCommonNameMismatch = true;
        local2.trustSelfSignedCertificates = true;
        local3 = new TLSSocket();
        local3.setTLSConfig(local2);
        this.socket = local3;
      } else {
        this.socket = new Socket();
      }
      this.initializeListeners();
    }

    private static function initLoggers() : void {
      connectionLogger = connectionLogger || logService.getLogger("connection");
      networkLogger = networkLogger || logService.getLogger("network");
      serverCommandLogger = serverCommandLogger || logService.getLogger("command");
    }

    public function connect(param1:ConnectionConnectParameters) : void {
      this.host = param1.host;
      this.preparePorts(param1);
      this.connectionStatus = ConnectionStatus.CONNECTING;
      this.portIndex = -1;
      this.tryNextPort();
    }

    protected function tryNextPort() : void {
      ++this.portIndex;
      if(this.portIndex < this.ports.length) {
        this.tryConnect();
      } else {
        messageBoxService.showMessage(new CannotEstablishConnectionError(this.host,this.ports));
      }
    }

    protected function writeCommand(param1:Object, param2:IDataOutput) : void {
      var local3:Boolean = param1 is IConnectionInitCommand;
      var local4:ByteArray = new ByteArray();
      var local5:ProtocolBuffer = new ProtocolBuffer(local4,local4,new OptionalMap());
      this.commandCodec.encode(local5,param1);
      local4.position = 0;
      var local6:ByteArray = new ByteArray();
      this.protocol.wrapPacket(local6,local5,CompressionType.DEFLATE_AUTO);
      local6.position = 0;
      var local7:IProtectionContext = local3 ? PrimitiveProtectionContext.INSTANCE : this.protectionContext;
      local7.wrap(param2,local6);
    }

    protected function processDataBuffer() : void {
      var byteArray:ByteArray = null;
      var packetData:ProtocolBuffer = null;
      var command:Object = null;
      this.dataBuffer.position = this.dataBuffer.length;
      this.protectionContext.unwrap(this.dataBuffer,this.rawDataBuffer);
      this.dataBuffer.position = this.currentPacketPosition;
      if(this.dataBuffer.bytesAvailable == 0) {
        return;
      }
      while(true) {
        byteArray = new ByteArray();
        packetData = new ProtocolBuffer(byteArray,byteArray,new OptionalMap());
        if(!this.protocol.unwrapPacket(this.dataBuffer,packetData,CompressionType.NONE)) {
          return;
        }
        ByteArray(packetData.reader).position = 0;
        while(Boolean(packetData.reader.bytesAvailable)) {
          command = null;
          try {
            command = this.commandCodec.decode(packetData);
            if(command == null) {
              throw new Error("Decoded command is null");
            }
          }
          catch(e:Error) {
            handleDataProcessingError("AbstractConnection::processDataBuffer() command decoding error: " + e.message + ", " + e.getStackTrace());
            break;
          }
          this.commandHandler.executeCommand(command);
        }
        if(this.dataBuffer.bytesAvailable == 0) {
          this.dataBuffer.clear();
          this.currentPacketPosition = 0;
          return;
        }
        this.currentPacketPosition = this.dataBuffer.position;
      }
    }

    protected function handleDataProcessingError(param1:String) : void {
      serverCommandLogger.error(param1);
      if(launcherParams.isDebug) {
        messageBoxService.showMessage(new UnclassifyedError(param1));
      }
      if(Boolean(launcherParams.getParameter(PARAM_CLOSE_ON_ERROR))) {
        this.close(ConnectionCloseStatus.DATA_PROCESSING_ERROR,param1);
      }
    }

    protected function handleDataSendingError(param1:Error) : void {
      var local2:String = param1.message + ", " + param1.getStackTrace();
      messageBoxService.showMessage(new UnclassifyedError(local2));
    }

    protected function onTransportError(param1:ErrorEvent) : void {
      networkLogger.error(param1.toString());
      if(this.connectionStatus == ConnectionStatus.CONNECTING) {
        this.tryNextPort();
      } else if(this.connectionStatus == ConnectionStatus.CONNECTED) {
        this.closeConnectionOnTransportError();
      }
    }

    public function closeConnectionOnTransportError() : void {
      messageBoxService.showMessage(new TransportError());
      this.close(ConnectionCloseStatus.CONNECTION_ERROR,"Transport error");
    }

    private function initializeListeners() : void {
      this.socket.addEventListener(Event.CLOSE,this.onSocketClose);
      this.socket.addEventListener(Event.CONNECT,this.onConnect);
      this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.onTransportError);
      this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onTransportError);
      this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
    }

    protected function preparePorts(param1:ConnectionConnectParameters) : void {
      this.ports = param1.ports;
      this.moveLastSuccessfulPortToFront();
    }

    private function moveLastSuccessfulPortToFront() : void {
      var lastPort:int = 0;
      var index:Number = NaN;
      try {
        lastPort = int(networkService.getLastPort(this.host));
        if(lastPort > 0) {
          index = Number(this.ports.indexOf(lastPort));
          if(index >= 0) {
            this.ports.splice(index,1);
            this.ports.unshift(lastPort);
          }
        }
      }
      catch(e:Error) {
        connectionLogger.warning("Error read stored port from shared object, message = %1",[e]);
      }
    }

    protected function onConnect(param1:Event) : void {
      networkService.saveLastPort(this.host,this.ports[this.portIndex]);
      this.connectionStatus = ConnectionStatus.CONNECTED;
      this.commandCodec.init(this.protocol);
      this.commandHandler.onConnectionOpen(this);
    }

    protected function tryConnect() : void {
      this.socket.connect(this.host,this.ports[this.portIndex]);
    }

    public function close(param1:ConnectionCloseStatus, param2:String = null) : void {
      this.socket.flush();
      this.socket.close();
      this.connectionStatus = ConnectionStatus.DISCONNECTED;
      this.commandHandler.onConnectionClose(param1,param2);
    }

    public function sendCommand(param1:Object) : void {
      var command:Object = param1;
      if(this.connectionStatus == ConnectionStatus.CONNECTED) {
        try {
          this.writeCommand(command,this.socket);
          this.socket.flush();
        }
        catch(error:Error) {
          handleDataSendingError(error);
        }
      }
    }

    private function onSocketClose(param1:Event) : void {
      this.close(ConnectionCloseStatus.CLOSED_BY_SERVER);
    }

    private function onSocketData(param1:ProgressEvent) : void {
      this.rawDataBuffer.clear();
      this.socket.readBytes(this.rawDataBuffer);
      this.processDataBuffer();
    }
  }
}
