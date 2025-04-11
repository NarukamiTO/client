package com.hurlant.crypto.tls {
  import com.hurlant.crypto.cert.X509Certificate;
  import com.hurlant.crypto.cert.X509CertificateCollection;
  import com.hurlant.util.der.PEM;
  import flash.events.Event;
  import flash.events.ProgressEvent;
  import flash.net.Socket;
  import flash.utils.ByteArray;
  import flash.utils.getTimer;

  public class TLSTest {
    public var myDebugData:String;
    public var myCert:Class;
    public var myKey:Class;

    public function TLSTest(param1:String = null, param2:int = 0, param3:int = 0) {
      super();
      if(param1 != null) {
        if(param3 == 0) {
          this.connectLoginYahooCom();
        } else {
          this.connectLocalTLS(param1,param2);
        }
      } else {
        this.testSocket();
      }
    }

    public function connectLoginYahooCom() : void {
      var s:Socket = null;
      s = new Socket("esx.bluebearllc.net",903);
      var clientConfig:TLSConfig = new TLSConfig(TLSEngine.CLIENT,null,null,null,null,null,SSLSecurityParameters.PROTOCOL_VERSION);
      var client:TLSEngine = new TLSEngine(clientConfig,s,s);
      s.addEventListener(ProgressEvent.SOCKET_DATA,client.dataAvailable);
      client.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:*):void {
        s.flush();
      });
      client.start();
    }

    public function connectLocalTLS(param1:String, param2:int) : void {
      var s:Socket = null;
      var host:String = param1;
      var port:int = param2;
      s = new Socket(host,port);
      var clientConfig:TLSConfig = new TLSConfig(TLSEngine.CLIENT);
      var client:TLSEngine = new TLSEngine(clientConfig,s,s);
      s.addEventListener(ProgressEvent.SOCKET_DATA,client.dataAvailable);
      client.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:*):void {
        s.flush();
      });
      client.start();
    }

    public function connectLocalSSL(param1:String, param2:int) : void {
      var s:Socket = null;
      var host:String = param1;
      var port:int = param2;
      s = new Socket(host,port);
      var clientConfig:TLSConfig = new TLSConfig(TLSEngine.CLIENT,null,null,null,null,null,SSLSecurityParameters.PROTOCOL_VERSION);
      var client:TLSEngine = new TLSEngine(clientConfig,s,s);
      s.addEventListener(ProgressEvent.SOCKET_DATA,client.dataAvailable);
      client.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:*):void {
        s.flush();
      });
      client.start();
    }

    public function loopback() : void {
      var x509:X509Certificate;
      var server_write:ByteArray = null;
      var client_write:ByteArray = null;
      var server_write_cursor:uint = 0;
      var client_write_cursor:uint = 0;
      var server:TLSEngine = null;
      var client:TLSEngine = null;
      server_write = new ByteArray();
      client_write = new ByteArray();
      server_write_cursor = 0;
      client_write_cursor = 0;
      var clientConfig:TLSConfig = new TLSConfig(TLSEngine.CLIENT,null,null,null,null,null,SSLSecurityParameters.PROTOCOL_VERSION);
      var serverConfig:TLSConfig = new TLSConfig(TLSEngine.SERVER,null,null,null,null,null,SSLSecurityParameters.PROTOCOL_VERSION);
      var cert:ByteArray = new this.myCert();
      var key:ByteArray = new this.myKey();
      serverConfig.setPEMCertificate(cert.readUTFBytes(cert.length),key.readUTFBytes(key.length));
      cert.position = 0;
      key.position = 0;
      clientConfig.setPEMCertificate(cert.readUTFBytes(cert.length),key.readUTFBytes(key.length));
      clientConfig.CAStore = new X509CertificateCollection();
      cert.position = 0;
      x509 = new X509Certificate(PEM.readCertIntoArray(cert.readUTFBytes(cert.length)));
      clientConfig.CAStore.addCertificate(x509);
      server = new TLSEngine(serverConfig,client_write,server_write);
      client = new TLSEngine(clientConfig,server_write,client_write);
      server.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:* = null):void {
        var local2:uint = server_write.position;
        server_write.position = server_write_cursor;
        client.dataAvailable(param1);
        server_write.position = local2;
        server_write_cursor = local2;
      });
      client.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:* = null):void {
        var local2:uint = client_write.position;
        client_write.position = client_write_cursor;
        server.dataAvailable(param1);
        client_write.position = local2;
        client_write_cursor = local2;
      });
      server.start();
      client.start();
    }

    public function testSocket() : void {
      var hosts:Array = null;
      hosts = ["bugs.adobe.com","login.yahoo.com","login.live.com","banking.wellsfargo.com","www.bankofamerica.com"];
      var i:int = 0;
      (function next():void {
        testHost(hosts[i++],next);
      })();
    }

    private function testHost(param1:String, param2:Function) : void {
      var t1:int;
      var t:TLSSocket = null;
      var host:String = param1;
      var next:Function = param2;
      if(host == null) {
        return;
      }
      t1 = getTimer();
      ;
      t = new TLSSocket();
      t.connect(host,4433);
      t.writeUTFBytes("GET / HTTP/1.0\nHost: " + host + "\n\n");
      t.addEventListener(Event.CLOSE,function(param1:*):void {
        var local2:String = t.readUTFBytes(t.bytesAvailable);
        var local3:ByteArray = new ByteArray();
        t.readBytes(local3,0,t.bytesAvailable);
        next();
      });
    }
  }
}
