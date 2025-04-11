package com.hurlant.crypto.tls {
  import com.hurlant.crypto.cert.X509Certificate;
  import flash.events.Event;

  public class TLSSocketEvent extends Event {
    public static const PROMPT_ACCEPT_CERT:String = "promptAcceptCert";

    public var cert:X509Certificate;

    public function TLSSocketEvent(param1:X509Certificate = null) {
      super(PROMPT_ACCEPT_CERT,false,false);
      this.cert = param1;
    }
  }
}
