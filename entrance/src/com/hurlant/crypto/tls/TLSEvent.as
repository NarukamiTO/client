package com.hurlant.crypto.tls {
  import flash.events.Event;
  import flash.utils.ByteArray;

  public class TLSEvent extends Event {
    public static const DATA:String = "data";
    public static const READY:String = "ready";
    public static const PROMPT_ACCEPT_CERT:String = "promptAcceptCert";

    public var data:ByteArray;

    public function TLSEvent(param1:String, param2:ByteArray = null) {
      this.data = param2;
      super(param1,false,false);
    }
  }
}
